import os
import os.path as osp

import torch
from torch.utils.data import Dataset
from torch.utils.data.dataloader import default_collate
from torchvision.transforms import functional as F
import glob as gb
import numpy as np
import numpy.linalg as LA
import cv2
import json
import csv
import matplotlib.pyplot as plt
from pylsd import lsd

import datasets.transforms as T
import pickle

def center_crop(img):
    sz = img.shape[0:2]
    side_length = np.min(sz)
    if sz[0] > sz[1]:
        ul_x = 0  
        ul_y = int(np.floor((sz[0]/2) - (side_length/2)))
        x_inds = [ul_x, sz[1]-1]
        y_inds = [ul_y, ul_y + side_length - 1]
    else:
        ul_x = int(np.floor((sz[1]/2) - (side_length/2)))
        ul_y = 0
        x_inds = [ul_x, ul_x + side_length - 1]
        y_inds = [ul_y, sz[0]-1]

    c_img = img[y_inds[0]:y_inds[1]+1, x_inds[0]:x_inds[1]+1, :]

    return c_img

def create_masks(image):
    height = image.shape[0]
    width = image.shape[1]
    masks = torch.zeros((1, height, width), dtype=torch.uint8)
    return masks

def filter_length(segs, min_line_length=10):
    lengths = LA.norm(segs[:,2:4] - segs[:,:2], axis=1)
    segs = segs[lengths > min_line_length]
    return segs[:,:4]

def normalize_segs(segs, pp, rho):    
    pp = np.array([pp[0], pp[1], pp[0], pp[1]], dtype=np.float32)    
    return rho*(segs - pp)    

def normalize_safe_np(v, axis=-1, eps=1e-6):
    de = LA.norm(v, axis=axis, keepdims=True)
    de = np.maximum(de, eps)
    return v/de

def segs2lines_np(segs):
    ones = np.ones(len(segs))
    ones = np.expand_dims(ones, axis=-1)
    p1 = np.concatenate([segs[:,:2], ones], axis=-1)
    p2 = np.concatenate([segs[:,2:], ones], axis=-1)
    lines = np.cross(p1, p2)
    return normalize_safe_np(lines)

def sample_segs_np(segs, num_sample, use_prob=True):    
    num_segs = len(segs)
    sampled_segs = np.zeros([num_sample, 4], dtype=np.float32)
    mask = np.zeros([num_sample, 1], dtype=np.float32)
    if num_sample > num_segs:
        sampled_segs[:num_segs] = segs
        mask[:num_segs] = np.ones([num_segs, 1], dtype=np.float32)
    else:    
        lengths = LA.norm(segs[:,2:] - segs[:,:2], axis=-1)
        prob = lengths/np.sum(lengths)        
        idxs = np.random.choice(segs.shape[0], num_sample, replace=True, p=prob)
        sampled_segs = segs[idxs]
        mask = np.ones([num_sample, 1], dtype=np.float32)
    return sampled_segs, mask

def sample_vert_segs_np(segs, thresh_theta=22.5):    
    lines = segs2lines_np(segs)
    (a,b) = lines[:,0],lines[:,1]
    theta = np.arctan2(np.abs(b),np.abs(a))
    thresh_theta = np.radians(thresh_theta)
    return segs[theta < thresh_theta]

def augment(image, vp, angle, division):
    if division == 1:  # left-right flip
        return image[:, ::-1].copy(), (vp * [-1, 1, 1]).copy(), -angle
    return image, vp, angle

class KittiDataset(Dataset):
    def __init__(self, cfg, listpath, basepath, return_masks=False, transform=None):
        self.listpath = listpath # csv_path:'kitti_split/train.csv'
        self.basepath = basepath # pkl_path:'.../kitti_horizon_vp'
        self.input_width = cfg.DATASETS.INPUT_WIDTH
        self.input_height = cfg.DATASETS.INPUT_HEIGHT
        self.min_line_length = cfg.DATASETS.MIN_LINE_LENGTH
        self.num_input_lines = cfg.DATASETS.NUM_INPUT_LINES
        self.num_input_vert_lines = cfg.DATASETS.NUM_INPUT_VERT_LINE
        self.vert_line_angle = cfg.DATASETS.VERT_LINE_ANGLE
        self.return_vert_lines = cfg.DATASETS.RETURN_VERT_LINES
        self.return_masks = return_masks
        self.transform = transform
        
        self.list_filename = []

        with open(self.listpath, newline='') as csvfile:
            reader = csv.reader(csvfile, delimiter=' ')
            for row in reader:
                date = row[0] # '2011_09_26 '
                drive = row[1] # '0001'
                
                total_length = int(row[2]) # 108
                for index in range(total_length):
                    self.list_filename.append(self.basepath + '/' + date + '/' + drive + '/%06d.pkl' % index)
                
                # if use kitti_horizon_vp_straight
                # path = os.path.join(basepath, date, drive ,'*.pkl')
                # pkl_path = gb.glob(path)
                # self.list_filename.extend(pkl_path)
                
        
        if cfg.MODE == "train" and cfg.DATASETS.AUGMENTATION:
            self.size = len(self.list_filename) * 2
        else:
            self.size = len(self.list_filename)
        print('dataset size: {} images'.format(self.size))
        
    def __getitem__(self, idx):
        target = {}
        extra = {}
        
        filename = self.list_filename[idx % len(self.list_filename)]
        
        with open(filename, 'rb') as fp:
            data = pickle.load(fp)

        image = np.transpose(data['image'], [1, 2, 0])
        image = cv2.normalize(image, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
        # image = image[:,:,::-1] # convert to rgb
        org_h, org_w = image.shape[0], image.shape[1]
        org_sz = np.array([org_h, org_w])
        
        pp = (org_w/2, org_h/2) 
        rho = 2.0/np.minimum(org_w,org_h)
        
        gt_angle = data['angle']
        if np.isnan(gt_angle):
            gt_angle = 0.
            print("warning:gt_angle is Nan")
        gt_vp = data['vp']
        gt_vp[0] = rho * (gt_vp[0] - org_w/2)
        gt_vp[1] = rho * (gt_vp[1] - org_h/2)
        gt_vp.append(1.)
        gt_vp = np.array(gt_vp)

        image, gt_vp, gt_hl = augment(image, gt_vp, gt_angle, idx // len(self.list_filename))
        # cv2.imwrite(image)
        org_image = image.copy()
        
        crop_image = center_crop(org_image)
        crop_h, crop_w = crop_image.shape[0], crop_image.shape[1]
        crop_sz = np.array([crop_h, crop_w]) 
                
        image = cv2.resize(image, dsize=(self.input_width, self.input_height))
        input_sz = np.array([self.input_height, self.input_width])

        
        # detect line and preprocess       
        gray = cv2.cvtColor(org_image, cv2.COLOR_BGR2GRAY)
        org_segs = lsd(gray, scale=0.8)
        org_segs = filter_length(org_segs, self.min_line_length)
        num_segs = len(org_segs)
        assert num_segs > 10, print(num_segs)
        
        segs = normalize_segs(org_segs, pp=pp, rho=rho)
        
        # whole segs
        sampled_segs, line_mask = sample_segs_np(
            segs, self.num_input_lines)
        sampled_lines = segs2lines_np(sampled_segs)
        
        # vertical directional segs
        vert_segs = sample_vert_segs_np(segs, thresh_theta=self.vert_line_angle)
        if len(vert_segs) < 2:
            vert_segs = segs
            
        sampled_vert_segs, vert_line_mask = sample_segs_np(
            vert_segs, self.num_input_vert_lines)
        sampled_vert_lines = segs2lines_np(sampled_vert_segs)
        
        if self.return_masks:
            masks = create_masks(image)
        
        image = np.ascontiguousarray(image)
        target['hl'] = torch.from_numpy(np.ascontiguousarray(gt_hl)).contiguous().float()
        target['vp'] = torch.from_numpy(np.ascontiguousarray(gt_vp)).contiguous().float()
        
        if self.return_vert_lines:
            target['segs'] = torch.from_numpy(np.ascontiguousarray(sampled_vert_segs)).contiguous().float()
            target['lines'] = torch.from_numpy(np.ascontiguousarray(sampled_vert_lines)).contiguous().float()
            target['line_mask'] = torch.from_numpy(np.ascontiguousarray(vert_line_mask)).contiguous().float()
        else:
            target['segs'] = torch.from_numpy(np.ascontiguousarray(sampled_segs)).contiguous().float()
            target['lines'] = torch.from_numpy(np.ascontiguousarray(sampled_lines)).contiguous().float()
            target['line_mask'] = torch.from_numpy(np.ascontiguousarray(line_mask)).contiguous().float()
                    
        if self.return_masks:
            target['masks'] = masks
        target['org_img'] = org_image
        target['org_sz'] = org_sz
        target['crop_sz'] = crop_sz
        target['input_sz'] = input_sz
        target['img_path'] = filename
        target['filename'] = filename
        
        extra['lines'] = target['lines'].clone()
        extra['line_mask'] = target['line_mask'].clone()

        return self.transform(image, extra, target)
    
    def __len__(self):
        return self.size  

def make_transform():
    return T.Compose([
        T.ToTensor(),
        T.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
    ]) 

def build_kitti(image_set, cfg):
    root = cfg.DATASET_DIR # dataset path
    if not os.path.exists(root):
        print('Dataset path: {} does not exist'.format(root))
        exit()
        
    PATHS = {
        "train": 'kitti_spilt/train.csv',
        "val":   'kitti_spilt/val.csv',
        "test":  'kitti_spilt/test.csv',
    }

    ann_file = PATHS[image_set]

    dataset = KittiDataset(cfg, ann_file, root, return_masks=cfg.MODELS.MASKS, transform=make_transform())
    return dataset

