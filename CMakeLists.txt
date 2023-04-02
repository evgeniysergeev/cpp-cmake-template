cmake_minimum_required(VERSION 3.10)

# set the project name
project(Cpp-CMake-Template VERSION 0.1)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# add the executable
add_executable(Cpp-CMake-Template src/main.cpp)

target_include_directories(Cpp-CMake-Template PUBLIC
  "${PROJECT_BINARY_DIR}"
)
