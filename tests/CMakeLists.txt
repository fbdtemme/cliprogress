cmake_minimum_required(VERSION 3.14)

find_package(Catch2 CONFIG REQUIRED)
include(Catch)

add_executable(cliprogress-tests
        widgets/label.cpp
        widgets/bar.cpp
        application.cpp
)

target_link_libraries(cliprogress-tests cliprogress Catch2::Catch2WithMain)
catch_discover_tests(cliprogress-tests)