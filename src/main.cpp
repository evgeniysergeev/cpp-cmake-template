#include <iostream>
#include <cstdlib>
#include <exception>
#include "version.h"

#include "gstreamer-tutorial-1.h"

static std::terminate_handler s_prev_termination_handler = nullptr;

static void termination_handler()
{
  if (s_prev_termination_handler != nullptr) {
    s_prev_termination_handler();
  }

  std::abort();
}

int main(int argc, char* argv[], char* env[])
{
  s_prev_termination_handler = std::set_terminate(termination_handler);

  std::cout << PROJECT_NAME
    << " v" << PROJECT_VERSION
    << std::endl;

#ifdef USE_GSTREAMER

#if defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE
  return gst_macos_main(gstreamer_tutorial_main, argc, argv, NULL);
#else
  return gstreamer_tutorial_main(argc, argv);
#endif

#endif  // USE_GSTREAMER

  return 0;
}
