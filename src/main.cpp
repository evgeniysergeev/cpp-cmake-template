#include <iostream>
#include <cstdlib>
#include <exception>
#include <string_view>
#include "version.h"

#ifdef USE_GSTREAMER

#include <gst/gst.h>

#include "gstreamer-tutorial-2.h"

#endif  // USE_GSTREAMER

#ifdef USE_BOOST

#include <boost/log/trivial.hpp>

#endif  // USE_BOOST

using namespace std::string_view_literals;

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

  BOOST_LOG_TRIVIAL(info) << ""sv << PROJECT_NAME << " v"sv << PROJECT_VERSION;

#ifdef USE_GSTREAMER

#if defined(__APPLE__)
  return gst_macos_main(gstreamer_tutorial_2, argc, argv, nullptr);
#else
  return gstreamer_tutorial_2(argc, argv, nullptr);
#endif

#endif  // USE_GSTREAMER

  return 0;
}
