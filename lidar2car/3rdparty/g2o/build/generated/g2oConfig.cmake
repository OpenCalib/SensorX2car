include(CMakeFindDependencyMacro)

find_dependency(Eigen3)
find_dependency(OpenGL)

include("${CMAKE_CURRENT_LIST_DIR}/g2oTargets.cmake")

