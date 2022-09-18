cmake_minimum_required(VERSION 3.14)
project(cliprogress
        LANGUAGES CXX
        VERSION 0.2.0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(CTest)

option(CLIPROGRESS_BUILD_EXAMPLES "Build example program" ON)
option(CLIPROGRESS_BUILD_TESTS "Build tests" ON)
option(CLIPROGRESS_INSTALL "Generate install target" ON)

find_package(fmt CONFIG REQUIRED)
find_package(gsl-lite CONFIG REQUIRED)
find_package(PalSigslot CONFIG REQUIRED)
find_package(termcontrol CONFIG REQUIRED)

add_library(cliprogress)
add_library(cliprogress::cliprogress ALIAS cliprogress)

target_compile_features(cliprogress PUBLIC cxx_std_20)
target_include_directories(cliprogress PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)


target_link_libraries(cliprogress
    PUBLIC
        termcontrol::termcontrol
        Pal::Sigslot
        gsl::gsl-lite-v1
        fmt::fmt
)

add_subdirectory(src)

if (CLIPROGRESS_BUILD_TESTS)
    add_subdirectory(tests)
endif()

if (CLIPROGRESS_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

if (CLIPROGRESS_INSTALL)
    set(cliprogress_target                  cliprogress)
    set(cliprogress_cmake_install_dir       ${CMAKE_INSTALL_LIBDIR}/cmake/cliprogress)
    set(cliprogress_version_config          ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake)
    set(cliprogress_project_config          ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake)
    set(cliprogress_project_config_template ${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}-config.cmake.in)
    set(cliprogress_targets_export_name     ${PROJECT_NAME}-targets)
    set(cliprogress_targets_file            ${cliprogress_targets_export_name}.cmake)
    set(cliprogress_include_build_dir       ${PROJECT_SOURCE_DIR}/include/)
    set(cliprogress_namespace               ${PROJECT_NAME})
    include(CMakePackageConfigHelpers)

    write_basic_package_version_file(
            ${cliprogress_version_config}
            VERSION ${PACKAGE_VERSION}
            COMPATIBILITY AnyNewerVersion
    )
    configure_package_config_file(
            ${cliprogress_project_config_template}
            ${cliprogress_project_config}
            INSTALL_DESTINATION ${cliprogress_cmake_install_dir})

    # install headers
    install(DIRECTORY ${cliprogress_include_build_dir}
            DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
            )
    # install project config file and config version file
    install(FILES ${cliprogress_project_config}
            ${cliprogress_version_config}
            DESTINATION ${cliprogress_cmake_install_dir}
            )

    # install targets to an export set
    install(TARGETS ${cliprogress_target}
            EXPORT ${cliprogress_targets_export_name}
            INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

    # Install the export set to enable importing targets from the build tree
    export(EXPORT ${cliprogress_targets_export_name}
           FILE ${cliprogress_targets_file}
           NAMESPACE ${cliprogress_namespace}::)

    # Install the export set to enable importing targets from the install tree
    install(EXPORT ${cliprogress_targets_export_name}
            FILE ${cliprogress_targets_file}
            NAMESPACE ${cliprogress_namespace}::
            DESTINATION ${cliprogress_cmake_install_dir})

endif()