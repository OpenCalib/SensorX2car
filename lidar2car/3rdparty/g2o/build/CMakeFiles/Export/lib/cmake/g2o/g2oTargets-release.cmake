#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "g2o::csparse" for configuration "Release"
set_property(TARGET g2o::csparse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::csparse PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "m"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_ext_csparse.so"
  IMPORTED_SONAME_RELEASE "libg2o_ext_csparse.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::csparse )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::csparse "/usr/local/lib/libg2o_ext_csparse.so" )

# Import target "g2o::freeglut_minimal" for configuration "Release"
set_property(TARGET g2o::freeglut_minimal APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::freeglut_minimal PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_ext_freeglut_minimal.so"
  IMPORTED_SONAME_RELEASE "libg2o_ext_freeglut_minimal.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::freeglut_minimal )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::freeglut_minimal "/usr/local/lib/libg2o_ext_freeglut_minimal.so" )

# Import target "g2o::stuff" for configuration "Release"
set_property(TARGET g2o::stuff APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::stuff PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "rt"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_stuff.so"
  IMPORTED_SONAME_RELEASE "libg2o_stuff.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::stuff )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::stuff "/usr/local/lib/libg2o_stuff.so" )

# Import target "g2o::opengl_helper" for configuration "Release"
set_property(TARGET g2o::opengl_helper APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::opengl_helper PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "OpenGL::GL;OpenGL::GLU"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_opengl_helper.so"
  IMPORTED_SONAME_RELEASE "libg2o_opengl_helper.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::opengl_helper )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::opengl_helper "/usr/local/lib/libg2o_opengl_helper.so" )

# Import target "g2o::core" for configuration "Release"
set_property(TARGET g2o::core APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::core PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::stuff"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_core.so"
  IMPORTED_SONAME_RELEASE "libg2o_core.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::core )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::core "/usr/local/lib/libg2o_core.so" )

# Import target "g2o::g2o_cli_library" for configuration "Release"
set_property(TARGET g2o::g2o_cli_library APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_cli_library PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core;dl"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_cli.so"
  IMPORTED_SONAME_RELEASE "libg2o_cli.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_cli_library )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_cli_library "/usr/local/lib/libg2o_cli.so" )

# Import target "g2o::g2o_cli_application" for configuration "Release"
set_property(TARGET g2o::g2o_cli_application APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_cli_application PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/local/bin/g2o"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_cli_application )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_cli_application "/usr/local/bin/g2o" )

# Import target "g2o::g2o_hierarchical_library" for configuration "Release"
set_property(TARGET g2o::g2o_hierarchical_library APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_hierarchical_library PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_hierarchical.so"
  IMPORTED_SONAME_RELEASE "libg2o_hierarchical.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_hierarchical_library )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_hierarchical_library "/usr/local/lib/libg2o_hierarchical.so" )

# Import target "g2o::g2o_simulator_library" for configuration "Release"
set_property(TARGET g2o::g2o_simulator_library APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_simulator_library PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::types_slam3d_addons;g2o::types_slam3d;g2o::types_slam2d_addons;g2o::types_slam2d;g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_simulator.so"
  IMPORTED_SONAME_RELEASE "libg2o_simulator.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_simulator_library )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_simulator_library "/usr/local/lib/libg2o_simulator.so" )

# Import target "g2o::g2o_simulator2d_application" for configuration "Release"
set_property(TARGET g2o::g2o_simulator2d_application APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_simulator2d_application PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/local/bin/g2o_simulator2d"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_simulator2d_application )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_simulator2d_application "/usr/local/bin/g2o_simulator2d" )

# Import target "g2o::g2o_simulator3d_application" for configuration "Release"
set_property(TARGET g2o::g2o_simulator3d_application APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_simulator3d_application PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/local/bin/g2o_simulator3d"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_simulator3d_application )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_simulator3d_application "/usr/local/bin/g2o_simulator3d" )

# Import target "g2o::g2o_anonymize_observations_application" for configuration "Release"
set_property(TARGET g2o::g2o_anonymize_observations_application APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::g2o_anonymize_observations_application PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/local/bin/g2o_anonymize_observations"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::g2o_anonymize_observations_application )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::g2o_anonymize_observations_application "/usr/local/bin/g2o_anonymize_observations" )

# Import target "g2o::types_data" for configuration "Release"
set_property(TARGET g2o::types_data APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_data PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core;g2o::types_slam2d;g2o::freeglut_minimal;g2o::opengl_helper"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_data.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_data.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_data )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_data "/usr/local/lib/libg2o_types_data.so" )

# Import target "g2o::types_slam2d" for configuration "Release"
set_property(TARGET g2o::types_slam2d APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_slam2d PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core;g2o::opengl_helper;/usr/lib/x86_64-linux-gnu/libGL.so"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_slam2d.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_slam2d.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_slam2d )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_slam2d "/usr/local/lib/libg2o_types_slam2d.so" )

# Import target "g2o::types_slam3d" for configuration "Release"
set_property(TARGET g2o::types_slam3d APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_slam3d PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core;g2o::opengl_helper;/usr/lib/x86_64-linux-gnu/libGL.so"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_slam3d.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_slam3d.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_slam3d )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_slam3d "/usr/local/lib/libg2o_types_slam3d.so" )

# Import target "g2o::types_sba" for configuration "Release"
set_property(TARGET g2o::types_sba APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_sba PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core;g2o::types_slam3d"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_sba.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_sba.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_sba )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_sba "/usr/local/lib/libg2o_types_sba.so" )

# Import target "g2o::types_sim3" for configuration "Release"
set_property(TARGET g2o::types_sim3 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_sim3 PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::types_sba"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_sim3.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_sim3.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_sim3 )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_sim3 "/usr/local/lib/libg2o_types_sim3.so" )

# Import target "g2o::types_icp" for configuration "Release"
set_property(TARGET g2o::types_icp APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_icp PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::types_sba;g2o::types_slam3d"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_icp.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_icp.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_icp )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_icp "/usr/local/lib/libg2o_types_icp.so" )

# Import target "g2o::types_sclam2d" for configuration "Release"
set_property(TARGET g2o::types_sclam2d APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_sclam2d PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::types_slam2d;g2o::core;/usr/lib/x86_64-linux-gnu/libGL.so"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_sclam2d.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_sclam2d.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_sclam2d )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_sclam2d "/usr/local/lib/libg2o_types_sclam2d.so" )

# Import target "g2o::types_slam2d_addons" for configuration "Release"
set_property(TARGET g2o::types_slam2d_addons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_slam2d_addons PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::types_slam2d;g2o::core;/usr/lib/x86_64-linux-gnu/libGL.so"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_slam2d_addons.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_slam2d_addons.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_slam2d_addons )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_slam2d_addons "/usr/local/lib/libg2o_types_slam2d_addons.so" )

# Import target "g2o::types_slam3d_addons" for configuration "Release"
set_property(TARGET g2o::types_slam3d_addons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::types_slam3d_addons PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::types_slam3d;g2o::core;/usr/lib/x86_64-linux-gnu/libGL.so"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_types_slam3d_addons.so"
  IMPORTED_SONAME_RELEASE "libg2o_types_slam3d_addons.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::types_slam3d_addons )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::types_slam3d_addons "/usr/local/lib/libg2o_types_slam3d_addons.so" )

# Import target "g2o::solver_pcg" for configuration "Release"
set_property(TARGET g2o::solver_pcg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::solver_pcg PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_solver_pcg.so"
  IMPORTED_SONAME_RELEASE "libg2o_solver_pcg.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::solver_pcg )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::solver_pcg "/usr/local/lib/libg2o_solver_pcg.so" )

# Import target "g2o::solver_dense" for configuration "Release"
set_property(TARGET g2o::solver_dense APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::solver_dense PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_solver_dense.so"
  IMPORTED_SONAME_RELEASE "libg2o_solver_dense.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::solver_dense )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::solver_dense "/usr/local/lib/libg2o_solver_dense.so" )

# Import target "g2o::solver_structure_only" for configuration "Release"
set_property(TARGET g2o::solver_structure_only APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::solver_structure_only PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_solver_structure_only.so"
  IMPORTED_SONAME_RELEASE "libg2o_solver_structure_only.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::solver_structure_only )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::solver_structure_only "/usr/local/lib/libg2o_solver_structure_only.so" )

# Import target "g2o::solver_csparse" for configuration "Release"
set_property(TARGET g2o::solver_csparse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::solver_csparse PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::csparse_extension;g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_solver_csparse.so"
  IMPORTED_SONAME_RELEASE "libg2o_solver_csparse.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::solver_csparse )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::solver_csparse "/usr/local/lib/libg2o_solver_csparse.so" )

# Import target "g2o::csparse_extension" for configuration "Release"
set_property(TARGET g2o::csparse_extension APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::csparse_extension PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::csparse"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_csparse_extension.so"
  IMPORTED_SONAME_RELEASE "libg2o_csparse_extension.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::csparse_extension )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::csparse_extension "/usr/local/lib/libg2o_csparse_extension.so" )

# Import target "g2o::solver_slam2d_linear" for configuration "Release"
set_property(TARGET g2o::solver_slam2d_linear APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::solver_slam2d_linear PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::solver_csparse;g2o::types_slam2d"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_solver_slam2d_linear.so"
  IMPORTED_SONAME_RELEASE "libg2o_solver_slam2d_linear.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::solver_slam2d_linear )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::solver_slam2d_linear "/usr/local/lib/libg2o_solver_slam2d_linear.so" )

# Import target "g2o::solver_eigen" for configuration "Release"
set_property(TARGET g2o::solver_eigen APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(g2o::solver_eigen PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "g2o::core"
  IMPORTED_LOCATION_RELEASE "/usr/local/lib/libg2o_solver_eigen.so"
  IMPORTED_SONAME_RELEASE "libg2o_solver_eigen.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS g2o::solver_eigen )
list(APPEND _IMPORT_CHECK_FILES_FOR_g2o::solver_eigen "/usr/local/lib/libg2o_solver_eigen.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
