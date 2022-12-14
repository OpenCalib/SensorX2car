## Introduction
This project is used to calibrate yaw from lidar to car.
## Environment
```shell
docker pull xiaokyan/opencalib:v1
```
if remote visualization is not set up, uncomment this sentence in file "src/LidarYawCalib.cpp" to make plt run in the background.
```
plt::backend("Agg");
```
## Compile
```shell
# mkdir build
mkdir -p build && cd build
# build
cmake .. && make
```
## Run example
```shell
./bin/run_lidar2car ./data/example/ ./output/
```
## Input
- <dataset_folder>: contain lidar files
- <output_dir>: save output file
## Output
- yaw.txt: calibration result
- pose.txt: lidar pose result
- trajectory.png: lidar trajectory
- compared_yaw.png: comparison between lidar pose yaw and trajectory yaw, which can be used to verify the result roughly