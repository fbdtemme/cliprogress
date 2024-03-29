cmake_minimum_required(VERSION 3.14)

include(FetchContent)

function(log_target_found library)
    message(STATUS "Target of dependency ${library} already exist in project.")
endfunction()

function(log_module_found library)
    message(STATUS "Local installation of dependency ${library} found.")
endfunction()

function(log_dir_found library)
    message(STATUS "Source directory for dependency ${library} found.")
endfunction()

function(log_fetch library)
    message(STATUS "Fetching dependency ${library}...")
endfunction()

if (CLIPROGRESS_BUILD_TESTING)
    include(${CMAKE_CURRENT_LIST_DIR}/Catch2.cmake)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/fmt.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/gsl-lite.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/ctre.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/palsigslot.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/termcontrol.cmake)

