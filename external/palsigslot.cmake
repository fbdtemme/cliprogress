if (TARGET Pal::Sigslot)
    log_target_found(PalSigslot)
    return()
endif()

find_package(PalSigslot QUIET)
if (PalSigslot_FOUND)
    log_module_found(PalSigslot)
    return()
endif()

set(SIGSLOT_COMPILE_EXAMPLES OFF)
set(SIGSLOT_COMPILE_TESTS OFF)

if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/palsigslot)
    log_dir_found(PalSigslot)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/palsigslot)
    set(ctre_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/palsigslot)
    return()
else()
    log_fetch(PalSigslot)

    FetchContent_Declare(
            PalSigslot
            GIT_REPOSITORY https://github.com/palacaze/sigslot.git
            GIT_TAG        master
    )
    FetchContent_MakeAvailable(PalSigslot)
endif()
