cmake_minimum_required(VERSION 3.10)

# set the project name
project(Cpp-CMake-Template VERSION 0.1)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# set default include directories (for config.h)
set(INCLUDE_DIRECTORIES
    "${PROJECT_BINARY_DIR}"
)

# generate config header file
configure_file(config.h.in config.h)

# add the executable
add_executable(Cpp-CMake-Template src/main.cpp)

# add subdirectories
add_subdirectory(src/gamelib)
target_link_libraries(Cpp-CMake-Template PUBLIC gamelib)
list(APPEND INCLUDE_DIRECTORIES
    "${PROJECT_SOURCE_DIR}/src/gamelib"
)

# configure include directories
target_include_directories(Cpp-CMake-Template PUBLIC
    ${INCLUDE_DIRECTORIES}
)

# Run tests
add_subdirectory(tests)
