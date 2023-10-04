cmake_minimum_required(VERSION 3.12)

# set the project name
project(Cpp-CMake-Template VERSION 0.1.2.3)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# generate config header file
configure_file(config.h.in config.h)

# add the executable
add_executable(Cpp-CMake-Template src/main.cpp)

# add subdirectories
add_subdirectory(src/gamelib)
target_link_libraries(Cpp-CMake-Template PUBLIC gamelib)

# configure include directories
target_include_directories(Cpp-CMake-Template PUBLIC
    ${PROJECT_BINARY_DIR}
    "src"
)

# Run tests
add_subdirectory(tests)
