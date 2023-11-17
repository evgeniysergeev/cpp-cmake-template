cmake_minimum_required(VERSION 3.15)

# set the project name
project(Cpp-CMake-Template VERSION 0.1.2.3)

#set(PROJECT_LICENSE "MIT")

set(PROJECT_LONG_DESCRIPTION "Simple CMake C++ template")

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
endif()

# determine which compiler is currently using to build
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

# create interface library for compiler flags
add_library(default_compiler_flags INTERFACE)

# specify the C++ standard
target_compile_features(default_compiler_flags INTERFACE cxx_std_20)

# set default compiler warning flags
target_compile_options(default_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

# generate config header file
configure_file(src/version.h.in version.h)

file(GLOB_RECURSE CPP_CMAKE_TEMPLATE_SRC
  "src/*.h"
  "src/*.cpp"
  "src/*.c"
)

# add the executable
add_executable(
  Cpp-CMake-Template
  ${CPP_CMAKE_TEMPLATE_SRC}
  src/logging/logging.h
  src/logging/logging.cpp
)

# add dependencies

option(USE_BOOST "Use Boost Library" ON)
option(USE_GSTREAMER "Use gstreamer tutorial" OFF)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/use_boost.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/use_gstreamer.cmake)

# add subdirectories
add_subdirectory(src/gamelib)
target_link_libraries(Cpp-CMake-Template PUBLIC gamelib default_compiler_flags)

# configure include directories
target_include_directories(Cpp-CMake-Template PUBLIC
  ${PROJECT_BINARY_DIR}
  "src"
  "src/logging"
)

# Run tests
add_subdirectory(tests)
