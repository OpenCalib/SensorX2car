## Introduction
This project is used to calibrate camera2car pose from single image by detecting vanishing point and horizon line.

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
