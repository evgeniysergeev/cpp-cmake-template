file(GLOB_RECURSE gamelib_SRC
  "*.h"
  "*.cpp"
  "*.c"
)

add_library(gamelib STATIC ${gamelib_SRC})

# add to include directories
target_include_directories(gamelib
  INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)

# use requrements from interface library with compiler flags
target_link_libraries(gamelib PUBLIC default_compiler_flags)
