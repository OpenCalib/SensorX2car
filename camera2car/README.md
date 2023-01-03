## Introduction
This project is used to calibrate camera2car pose from single image by detecting vanishing point and horizon line.

### Demo

https://user-images.githubusercontent.com/91944792/210300604-06cac052-18f1-45b9-938e-141429d986b6.mp4


## Detection Network
### Setup Environment
  ```
  conda create -n ctrlc
  conda activate ctrlc
  conda install -c pytorch torchvision

  pip install -r requirements.txt
  ```
### Train
* Single GPU

```shell
python train.py --config-file config-files/ctrlc.yaml
```

* Multi GPU

```shell
python -m torch.distributed.launch --nproc_per_node=4 --use_env train.py --config-file config-files/ctrlc.yaml
```
### Pre-trained Model
You can download our pre-trained model from [Google Drive](https://drive.google.com/file/d/1yuYZ85pFMVD4tHdw07ZSVHz__ecI58fV/view?usp=share_link) to test.

### Evaluation
* kitti dataset
```
python test_kitti.py --config-file config-files/ctrlc.yaml --opts MODE test
```
* single image inference
```
python test_img.py --config-file config-files/ctrlc.yaml --opts MODE test DATASET_DIR ./pic/ OUTPUT_DIR ./outputs/
```

### Acknowledgments

This code is based on the implementations of [**CTRL-C: Camera calibration TRansformer with Line-Classification**](https://github.com/jwlee-vcl/CTRL-C). 
