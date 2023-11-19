# on macOS "uname -m" returns the architecture (x86_64 or arm64)
if(APPLE)
  execute_process(
    COMMAND uname -m
    RESULT_VARIABLE result
    OUTPUT_VARIABLE APPLE_NATIVE_ARCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
endif()  # APPLE
