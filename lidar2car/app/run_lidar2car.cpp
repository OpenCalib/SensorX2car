#include <iostream>
#include <time.h>
#include <iterator>
#include <stdio.h>
#include <string>
#include <vector>
#include <dirent.h>
#include <chrono>

#include "FastLoam.h"
#include "LidarYawCalib.h"
#include "utility.h"

const char usage[] = {
    " ./bin/run_lidar2car dataset_folder/ output_dir/ \n"
    "PARAMS:\n"
    "  dataset_folder: path to lidar dataset directory \n"
    "  output_dir: folder to save output files.\n"};


int main(int argc, char **argv)
{
    
    if (argc != 3)
    {
        std::cerr << "Usage:" << usage;
        return 1;
    }
    std::string dataset_folder = argv[1];
    std::string output_dir = argv[2];
    
    std::vector<Eigen::Matrix4d> lidar_pose;

    RunFastLoam(dataset_folder, output_dir, lidar_pose);

    LidarYawCalib calibrator(output_dir);
    calibrator.LoadData(lidar_pose);
    if(calibrator.Calibrate()){
        double yaw = calibrator.GetFinalYaw();
        std::cout << "Final: yaw = " << Rad2Deg(yaw) << " degree" << std::endl;
    }
    else{
        std::cout << "No valid data." << std::endl;
    }
}



