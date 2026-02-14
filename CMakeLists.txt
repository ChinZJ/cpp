cmake_minimum_required(VERSION 3.20)

project(
    cpp
    VERSION 1.0.0
    DESCRIPTION "C++ project collection"
    LANGUAGES CXX
)

# ─── C++ Standard Configuration ───────────────────────────────────────────────
# Default to C++20.
set(CMAKE_CXX_STANDARD 20 CACHE STRING "Default C++ standard")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)  # Disallow -std=gnu++20

# ─── Build Configuration ──────────────────────────────────────────────────────
# Use ccache if available
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
    message(STATUS "Using ccache: ${CCACHE_PROGRAM}")
endif()

# Default to Debug if not specified
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
    message(STATUS "Setting build type to 'Debug' as none was specified.")
endif()

# Export compile_commands.json for clang-tidy and IDE integration
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# ─── Include CMake Modules ────────────────────────────────────────────────────
include(cmake/CompilerWarnings.cmake)
include(cmake/Sanitizers.cmake)

# ─── Options ──────────────────────────────────────────────────────────────────
option(ENABLE_SANITIZERS "Enable ASan + UBSan" ON)
option(ENABLE_CLANG_TIDY "Enable clang-tidy static analysis" OFF)

if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY_PROGRAM clang-tidy)
    if(CLANG_TIDY_PROGRAM)
        set(CMAKE_CXX_CLANG_TIDY ${CLANG_TIDY_PROGRAM})
        message(STATUS "clang-tidy enabled: ${CLANG_TIDY_PROGRAM}")
    else()
        message(WARNING "clang-tidy requested but not found")
    endif()
endif()

# ─── Sub-projects ─────────────────────────────────────────────────────────────
# For delegation to subdirectories
add_subdirectory(projects)
