cmake_minimum_required(VERSION 3.14)

include(FetchContent)

function(log_found library)
    message(STATUS "Local installation of dependency ${library} found.")
endfunction()

function(log_not_found library)
    message(STATUS "Fetching dependency ${library}...")
endfunction()


find_package(fmt QUIET)
if (fmt_FOUND OR TARGET fmt::fmt)
    log_found(fmt)
else()
    log_not_found(fmt)
    FetchContent_Declare(
            fmt
            GIT_REPOSITORY https://github.com/fmtlib/fmt.git
            GIT_TAG        master
    )
    set(FORMAT_BUILD_TESTING OFF)
    set(FMT_INSTALL ON)
    FetchContent_MakeAvailable(fmt)
endif()

find_package(PalSigslot QUIET)
if (PalSigslot_FOUND OR TARGET Pal::Sigslot)
    log_found(PalSigslot)
else()
    log_not_found(PalSigslot)

    FetchContent_Declare(
            PalSigslot
            GIT_REPOSITORY https://github.com/palacaze/sigslot.git
            GIT_TAG        master
    )
    # disable tests
    FetchContent_MakeAvailable(PalSigslot)
endif()

find_package(gsl-lite QUIET)
if (gsl-lite_FOUND OR TARGET gsl::gsl-lite-v1)
    message(STATUS "Local installation of gsl-lite found.")
else()
    message(STATUS "Fetching dependency gsl-lite...")
    FetchContent_Declare(
            gsl-lite
            GIT_REPOSITORY https://github.com/gsl-lite/gsl-lite.git
            GIT_TAG        master
    )
    FetchContent_MakeAvailable(gsl-lite)
endif()

find_package(termcontrol QUIET)
if (termcontrol_FOUND)
    log_found(termcontrol OR TARGET termcontrol::termcontrol)
else()
    log_not_found(termcontrol)
    FetchContent_Declare(
            termcontrol
            GIT_REPOSITORY https://github.com/fbdtemme/termcontrol.git
            GIT_TAG        main
    )
    FetchContent_MakeAvailable(termcontrol)
endif()

find_package(Catch2 QUIET)
if (Catch2_FOUND)
    log_found(Catch2)
else()
    log_not_found(Catch2)
    FetchContent_Declare(
            Catch2
            GIT_REPOSITORY https://github.com/catchorg/Catch2.git
            GIT_TAG        v2.x
    )
    FetchContent_MakeAvailable(Catch2)
    set(CMAKE_MODULE_PATH "${Catch2_SOURCE_DIR}/contrib" ${CMAKE_MODULE_PATH})
endif()
