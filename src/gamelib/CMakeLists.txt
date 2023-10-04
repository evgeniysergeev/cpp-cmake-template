add_library(gamelib STATIC map.cpp world.cpp)

# add to include directories
target_include_directories(gamelib
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)

# use requrements from interface library with compiler flags
target_link_libraries(gamelib PUBLIC default_compiler_flags)

# just some option
option(USE_MYMATH "Use tutorial provided math implementation" ON)

if (USE_MYMATH)
    target_compile_definitions(gamelib PRIVATE "USE_MYMATH")
endif()
