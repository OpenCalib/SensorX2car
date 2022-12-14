#include <iostream>

#include "Eigen/Core"
#include "Eigen/Dense"
#include <Eigen/Geometry>

bool LoadLidarPose(std::string pose_file, std::vector<Eigen::Matrix4d> &lidar_pose);
double WeightMean(const std::vector<double> a, std::vector<double> weight);
double Mean(const std::vector<double> a);
double Rad2Deg(double yaw);
bool DeleteOutliers(std::vector<double> &nums, std::vector<double> &new_nums, double s);