#include <iostream>
#include <chrono>
#include <fstream>
#include "LidarYawCalib.h"
#include "utility.h"
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

LidarYawCalib::LidarYawCalib(const std::string img_path) 
{
    img_path_ = img_path;
    // plt::backend("Agg"); // plt run in background
}

bool LidarYawCalib::LoadData(const std::vector<Eigen::Matrix4d> &lidar_pose){
    pose_num_ = lidar_pose.size();
    std::cout << "Using " << pose_num_ << " lidar frames to calibrate ..." << std::endl;
    for (int i = 0; i < pose_num_; i++)
    {
        Eigen::Matrix4d T = lidar_pose[i];
        lidar_pose_x_.push_back(T(0, 3));
        lidar_pose_y_.push_back(T(1, 3));
        double yaw = atan2(T(1, 0), T(0, 0));
        if (lidar_pose_yaw_.size()!=0){
            if(yaw - lidar_pose_yaw_.back() > M_PI) {
                yaw -= 2 * M_PI;
            }
            else if(yaw - lidar_pose_yaw_.back() < -M_PI) {
                yaw += 2 * M_PI;
            }
        }
        lidar_pose_yaw_.push_back(yaw);
    }

    if(save_trajectory_xy){
        plt::plot(lidar_pose_x_, lidar_pose_y_);
        plt::savefig(img_path_ + "trajectory.png");
        // plt::show();
        plt::close();
    }
    return true;
}

bool LidarYawCalib::Calibrate(){
    // bspline pose_x and pose_y
    DataTable sample_x, sample_y;
    DenseVector t(1);
    for(int i = 0; i < pose_num_; i += time_gap_)
    {
        t(0) = i;
        sample_x.addSample(t, lidar_pose_x_[i]);
        sample_y.addSample(t, lidar_pose_y_[i]);
    }

    // get yaw from dx and dy
    std::vector<DataTable> samples_yaw;
    GetYawSegs(sample_x, sample_y, samples_yaw);

    std::vector<double> yaws, weights;
    // calibrate each segment yaw

    for (int i = 0; i < samples_yaw.size(); i++)
    {
        DataTable sample_yaw = samples_yaw[i];
        plt::plot(sample_yaw.getTableX()[0], sample_yaw.getVectorY(), {{"label", "trajectory yaw"}});
        double yaw;
        if(CalibrateSingle(sample_yaw, yaw)){
            yaws.push_back(yaw);
            weights.push_back(sample_yaw.getNumSamples());
            std::cout << "Segment" << i << ": yaw =" << Rad2Deg(yaw) << " degree" << std::endl;
        }
    }
    plt::plot(lidar_pose_yaw_, {{"label", "lidar pose yaw"}});
    plt::legend();
    plt::savefig(img_path_ + "compared_yaw.png");
    plt::close();
    if (yaws.size() == 0)
        return false;
    final_yaw_ = Mean(yaws);

    if(save_result_){
        std::ofstream file;    
        file.open(img_path_ + "yaw.txt");
        for (int i = 0; i < yaws.size(); i++) 
        {
            file << "Segment" << i << ": yaw = " << Rad2Deg(yaws[i]) << " degree" << std::endl;
        }
        file << "Final: yaw = " << Rad2Deg(final_yaw_) << " degree" << std::endl;
        file.close();
    }

    return true;
}

bool LidarYawCalib::GetYawSegs(const DataTable &sample_x, const DataTable &sample_y, std::vector<DataTable> &samples_yaw){
    
    BSpline bspline_x = BSpline::Builder(sample_x).degree(bspine_degree_).smoothing(BSpline::Smoothing::PSPLINE).alpha(0.03).build();
    BSpline bspline_y = BSpline::Builder(sample_y).degree(bspine_degree_).smoothing(BSpline::Smoothing::PSPLINE).alpha(0.03).build();

    int discarded_nums = int(pose_num_ * 0.1);
    DataTable tmp_yaw;
    int last_t;
    double last_yaw;

    for (int i = discarded_nums; i < pose_num_ - discarded_nums; i += time_gap_)
    {
        DenseVector t(1);
        t(0) = i;
        double dx = bspline_x.evalJacobian(t)(0, 0);
        double dy = bspline_y.evalJacobian(t)(0, 0);
        double ddx = bspline_x.evalHessian(t)(0, 0);
        double ddy = bspline_y.evalHessian(t)(0, 0);
        double cur_x = fabs(ddx) / pow(1 + dx * dx, 1.5);
        double cur_y = fabs(ddy) / pow(1 + dy * dy, 1.5);

        // delete unmoving points
        if (dx * dx + dy * dy < 1e-3)
            continue;
        // detele points with large curvature
        if (cur_x > 0.015 || cur_y > 0.015)
            continue;

        double yaw = atan2(dy, dx);
        t(0) = i + bspine_degree_;
        if(tmp_yaw.getNumSamples() != 0 && i - last_t > time_gap_ * 5)
        {
            if(tmp_yaw.getNumSamples() > 20) 
            {
                samples_yaw.push_back(tmp_yaw);
            }
            tmp_yaw = DataTable();
        }
        if(tmp_yaw.getNumSamples() != 0 && fabs(yaw - last_yaw) > M_PI){
            if(yaw - last_yaw > M_PI) {
                yaw -= 2 * M_PI;
            }
            else if(yaw - last_yaw < -M_PI) {
                yaw += 2 * M_PI;
            }
        }
        tmp_yaw.addSample(t, yaw);
        last_yaw = yaw;
        last_t = i;
    }
    if(tmp_yaw.getNumSamples() > 20) 
    {
        samples_yaw.push_back(tmp_yaw);
    }


    return true;
}

bool LidarYawCalib::CalibrateSingle(const DataTable & sample_yaw, double & estimate_yaw)
{
    BSpline bspline_yaw = BSpline::Builder(sample_yaw).degree(bspine_degree_).smoothing(BSpline::Smoothing::PSPLINE).alpha(0.06).build();
    std::vector<double> timestamp = sample_yaw.getTableX()[0];
    std::vector<double> offset_yaws;
    int discarded_nums = int(timestamp.size() * 0.05);
    for (int i = discarded_nums; i < timestamp.size() - discarded_nums; i++)
    {
        DenseVector t(1);
        t(0) = timestamp[i];
        double yaw = bspline_yaw.eval(t);
        // double dyaw = bspline_yaw.evalJacobian(t)(0, 0);
        // double ddyaw = bspline_yaw.evalHessian(t)(0, 0);
        double offset_yaw = lidar_pose_yaw_[timestamp[i]] - yaw;
        if (offset_yaw > M_PI)
            offset_yaw -= 2 * M_PI;
        else if(offset_yaw < - M_PI)
            offset_yaw += 2 * M_PI;
        offset_yaws.push_back(offset_yaw);
    }

    std::vector<double> new_offset_yaws;
    DeleteOutliers(offset_yaws, new_offset_yaws, 3);
    estimate_yaw = Mean(new_offset_yaws);
    return true;
}

double LidarYawCalib::GetFinalYaw()
{
    return final_yaw_;
}
