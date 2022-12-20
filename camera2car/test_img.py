import os
import os.path as osp
import argparse
from datetime import date
import json
import random
import time
from pathlib import Path
import numpy as np
import numpy.linalg as LA
from tqdm import tqdm
import matplotlib as mpl
import matplotlib.pyplot as plt
import cv2
import csv
import math
import torch
import torch.nn.functional as F
from torch.utils.data import DataLoader
import util.misc as utils
from datasets import build_image_dataset
from models import build_model
from config import cfg

cmap = plt.get_cmap("jet")
norm = mpl.colors.Normalize(vmin=0.0, vmax=1.0)
sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
sm.set_array([])

def c(x):
    return sm.to_rgba(x)

def get_args_parser():
    parser = argparse.ArgumentParser('Set gptran', add_help=False)
    parser.add_argument('--config-file', 
                        metavar="FILE",
                        help="path to config file",
                        type=str,
                        default='config-files/ctrlc.yaml')
    parser.add_argument("--opts",
                        help="Modify config options using the command-line",
                        default=None,
                        nargs=argparse.REMAINDER
                        )
    return parser

def compute_horizon(pred_hl, pred_vp, img_sz):
    hl_left = pred_vp[1] + (pred_vp[0] + img_sz[1] / 2) * math.tan(pred_hl)
    hl_right = pred_vp[1] + (pred_vp[0] - img_sz[1] / 2) * math.tan(pred_hl)
    return hl_left, hl_right
    

def to_device(data, device):
    if type(data) == dict:
        return {k: v.to(device) for k, v in data.items()}
    return [{k: v.to(device) if isinstance(v, torch.Tensor) else v
             for k, v in t.items()} for t in data]


def main(cfg):
    device = torch.device(cfg.DEVICE)
    
    model, _ = build_model(cfg)
    model.to(device)
    
    dataset_test = build_image_dataset(cfg)
    sampler_test = torch.utils.data.SequentialSampler(dataset_test)
    data_loader_test = DataLoader(dataset_test, 1, sampler=sampler_test,
                                 drop_last=False, 
                                 collate_fn=utils.collate_fn, 
                                 num_workers=1)
    
    checkpoint = torch.load(cfg.LOAD, map_location='cpu') # change model
    model.load_state_dict(checkpoint['model'])
    model = model.eval()
    
    for i, (samples, extra_samples, targets) in enumerate(tqdm(data_loader_test)):
        with torch.no_grad():
            samples = samples.to(device)
            extra_samples = to_device(extra_samples, device)
            outputs = model(samples, extra_samples)
                    
            pred_vp = outputs['pred_vp'].to('cpu')[0].numpy()
            pred_hl = outputs['pred_hl'].to('cpu')[0].numpy()

            img_sz = targets[0]['org_sz']
            pp = (img_sz[1]/2, img_sz[0]/2) 
            rho = 2.0/np.minimum(img_sz[0],img_sz[1])
            
            filename = targets[0]['filename']
            filename = osp.splitext(filename)[0]
            
            pred_vp[0] = pred_vp[0] / pred_vp[2] / rho
            pred_vp[1] = pred_vp[1] / pred_vp[2] / rho
            
            hl_left, hl_right = compute_horizon(pred_hl, pred_vp, img_sz)
            
            img = targets[0]['org_img']
            extent=[-img_sz[1]/2, img_sz[1]/2, img_sz[0]/2, -img_sz[0]/2]
            
            plt.figure(figsize=(5,5))                
            plt.imshow(img, extent=extent)
            plt.plot(pred_vp[0], pred_vp[1], 'ro')
            plt.plot([-img_sz[1] / 2, img_sz[1] / 2], 
                     [hl_left, hl_right], 'r-', alpha=1.0)
            plt.xlim(-img_sz[1]/2, img_sz[1]/2)
            plt.ylim( img_sz[0]/2,-img_sz[0]/2)
            plt.axis('off')
            img_name = cfg.OUTPUT_DIR +'/' + filename + '_vp_hl.png'
            plt.savefig(img_name, pad_inches=0, bbox_inches='tight')
            plt.close('all')
            
            print("filename: ", filename)
            print("VP: ({}, {})".format(pred_vp[0] + img_sz[1] / 2, pred_vp[1] + img_sz[0] / 2))
            print("HL angle: {} rad".format(pred_hl))
                    

            
if __name__ == '__main__':
    parser = argparse.ArgumentParser('GPANet training and evaluation script', 
                                     parents=[get_args_parser()])
    args = parser.parse_args()
    cfg.merge_from_file(args.config_file)
    cfg.merge_from_list(args.opts)
    
    if cfg.OUTPUT_DIR:
        Path(cfg.OUTPUT_DIR).mkdir(parents=True, exist_ok=True)
    main(cfg)
