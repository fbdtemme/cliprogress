cmake_minimum_required(VERSION 3.14)
project(cliprogress
        LANGUAGES CXX
        VERSION 0.2.0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(CTest)
option(CLIPROGRESS_BUILD_EXAMPLES "Build example program" ON)
option(CLIPROGRESS_BUILD_TESTS "Build tests" ON)

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
