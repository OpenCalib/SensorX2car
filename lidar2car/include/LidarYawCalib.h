#include "Eigen/Core"
#include "Eigen/Dense"
#include <Eigen/Geometry>

#include <datatable.h>
#include <bspline.h>
#include <bsplinebuilder.h>

using namespace SPLINTER;

class LidarYawCalib {
    public:
        LidarYawCalib(const std::string img_path);
        bool LoadData(const std::vector<Eigen::Matrix4d> &lidar_pose);
        bool Calibrate();
        bool GetYawSegs(const DataTable &sample_x, const DataTable &sample_y, std::vector<DataTable> &samples_yaw);
        bool CalibrateSingle(const DataTable &sample_yaw, double &estimate_yaw);
        double GetFinalYaw();

    private:
        int bspine_degree_ = 3;
        int time_gap_ = 4;
        int pose_num_;
        double final_yaw_;
        bool save_result_ = true;
        std::vector<double> lidar_pose_x_;
        std::vector<double> lidar_pose_y_;
        std::vector<double> lidar_pose_yaw_;

        // visualization
        std::string img_path_;
        bool save_trajectory_xy = true;
};