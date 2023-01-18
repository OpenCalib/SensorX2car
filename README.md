# SensorX2car
SensorX2car is a calibration toolbox for the online calibration of sensor-to-car coordinate systems in road scenes, which contains four commonly used sensors (pose_sensor (IMU + GNSS), LiDAR (Light Detection and Ranging), Camera, and millimeter-wave Radar) for autonomous driving. For more calibration codes, please refer to the link <a href="https://github.com/PJLab-ADG/SensorsCalibration" title="SensorsCalibration">SensorsCalibration</a>
<!-- CITATION -->

| calibration param |calibration type| calibration method | mannual calibration | auto calibration | usage documentation |
| :--------------: |:--------------:| :------------: | :--------------: | :------------: | :------------: |
| camera2car      | extrinsic |  target-less   |    &#10004; |  &#10004;  |[camera2car](camera2car/README.md)|
| lidar2car       | extrinsic |  target-less   |             |  &#10004;  |[lidar2car](lidar2car/README.md)|
| pose_sensor2car | extrinsic |  target-less   |             |  &#10004;  |[pose_sensor2car](pose_sensor2car/README.md)|
| radar2car       | extrinsic |  target-less   |             |  &#10004;  |[radar2car](radar2car/README.md)|

## Citation
If you find this project useful in your research, please consider cite:
```
@article{opencalib,
    title={OpenCalib: A Multi-sensor Calibration Toolbox for Autonomous Driving},
    author={Yan, Guohang and Liu, Zhuochun and Wang, Chengjie and Shi, Chunlei and Wei, Pengjin and Cai, Xinyu and Ma, Tao and Liu, Zhizheng and Zhong, Zebin and Liu, Yuqian and Zhao, Ming and Ma, Zheng and Li, Yikang},
    journal={arXiv preprint arXiv:2205.14087},
    year={2022},
}
```

## Contact
If you have questions about this repo, please contact Yan Guohang (`yanguohang@pjlab.org.cn`). If you need business cooperation, please call 19821266250 (same number on WeChat).
