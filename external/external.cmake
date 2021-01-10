cmake_minimum_required(VERSION 3.14)

include(FetchContent)

function(log_found library)
    message(STATUS "Local installation of dependency ${library} found.")
endfunction()

function(log_not_found library)
    message(STATUS "Fetching dependency ${library}...")
endfunction()

find_package(PalSigslot  QUIET)
if (PalSigslot_FOUND)
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

find_package(termcontrol QUIET)
if (termcontrol_FOUND OR TARGET termcontrol::termcontrol)
    log_found(termcontrol)
else()
    log_not_found(termcontrol)
    FetchContent_Declare(
            termcontrol
            GIT_REPOSITORY https://github.com/fbdtemme/termcontrol.git
            GIT_TAG        master
    )
    FetchContent_MakeAvailable(termcontrol)
endif()
