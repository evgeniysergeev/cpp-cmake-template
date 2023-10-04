cmake_minimum_required(VERSION 3.15)

# set the project name
project(Cpp-CMake-Template VERSION 0.1.2.3)

# determine which compiler is currently using to build
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

# create interface library for compiler flags
add_library(default_compiler_flags INTERFACE)

# specify the C++ standard
target_compile_features(default_compiler_flags INTERFACE cxx_std_17)

# set default compiler warning flags
target_compile_options(default_compiler_flags INTERFACE
    "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
    "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

# generate config header file
configure_file(config.h.in config.h)

# add the executable
add_executable(Cpp-CMake-Template src/main.cpp)

# add subdirectories
add_subdirectory(src/gamelib)
target_link_libraries(Cpp-CMake-Template PUBLIC gamelib default_compiler_flags)

# configure include directories
target_include_directories(Cpp-CMake-Template PUBLIC
    ${PROJECT_BINARY_DIR}
    "src"
)

# Run tests
add_subdirectory(tests)
