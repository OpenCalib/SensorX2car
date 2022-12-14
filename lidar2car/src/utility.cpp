#include <fstream>
#include "utility.h"

bool LoadLidarPose(std::string pose_file, std::vector<Eigen::Matrix4d> &lidar_pose){
    std::ifstream infile(pose_file);
    std::string line;
    if (!infile) {
        std::cout << "Can't open file " << pose_file << std::endl;
        exit(1);
    }
    while(getline(infile,line)){
        std::stringstream ss(line);
        std::vector<std::string>  elements;
        std::string elem;
        while(getline(ss, elem,' ')){
            elements.emplace_back(elem);
        }
        if(elements.size()!=12){
            printf("num of line elements error! skip this line.\n");
            continue;
        }
        Eigen::Matrix4d pose;
        pose << stod(elements[0]), stod(elements[1]), stod(elements[2]),stod(elements[3]),
                stod(elements[4]), stod(elements[5]), stod(elements[6]),stod(elements[7]),
                stod(elements[8]), stod(elements[9]), stod(elements[10]),stod(elements[11]),
                0,                 0,                 0,                 1;
        lidar_pose.push_back(pose);
    }
    return true;
}

double WeightMean(const std::vector<double> a, std::vector<double> weight)
{
    double sumweight = std::accumulate(std::begin(weight), std::end(weight), 0.0);
    for (int i = 0; i < weight.size();i++)
    {
        weight[i] /= sumweight;
    }
    double sum = 0;
    for (int i = 0; i < weight.size();i++)
    {
        sum += weight[i] * a[i];
    }
    return  sum;
}

double Mean(const std::vector<double> a)
{
    double sum = std::accumulate(std::begin(a), std::end(a), 0.0);
    return  sum / a.size();
}

double Rad2Deg(double yaw)
{
    return yaw * 180 / M_PI;
}

bool DeleteOutliers(std::vector<double> &nums, std::vector<double> &new_nums, double s)
{
    int n = nums.size();
    std::sort(nums.begin(), nums.end());
    double median = (n % 2 == 1) ? nums[n / 2] : (nums[n / 2] + nums[n / 2 - 1]) / 2;
    std::vector<double> deviations;
    for (int i = 0; i < n; i++)
    {
        deviations.push_back(fabs(nums[i] - median));
    }
    std::sort(deviations.begin(), deviations.end());
    double mad = (n % 2 == 1) ? deviations[n / 2] : (deviations[n / 2] + deviations[n / 2 - 1]) / 2;
    for (size_t i = 0; i < n; i++)
    {
        if (fabs(nums[i] - median) < s * mad)
            new_nums.push_back(nums[i]);
    }
    return true;
}