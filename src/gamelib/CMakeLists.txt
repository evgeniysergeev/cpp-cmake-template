add_library(gamelib STATIC map.cpp world.cpp)

# just some option
option(USE_MYMATH "Use tutorial provided math implementation" ON)

if (USE_MYMATH)
    target_compile_definitions(gamelib PRIVATE "USE_MYMATH")
endif()
