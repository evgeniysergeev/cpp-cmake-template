# Run tests
option(BUILD_TESTS "Build tests" ON)

if(BUILD_TESTS)
  # add tests the executable
  add_executable(tests tests.cpp)

  target_compile_definitions(tests PRIVATE "BUILD_TESTS")

endif()
