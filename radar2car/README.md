## Introduction
This project is used to calibrate yaw from radar to car.
## Environment
```shell
docker pull xiaokyan/opencalib:v1
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
./bin/run_radar2car delphi data/front_radar/ data/novatel_inspva.csv  ./outputs/
```
## Input
- <dataset_folder>: contain radar data files and GNSS data files.
- <output_dir>: save output file
## Output
- fitline: save points $(x, y)$ to draw cosine curve:
$y = A*cos(x-yaw)$

