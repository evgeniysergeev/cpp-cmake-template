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
#include "logging.h"
#endif  // USE_BOOST

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

#ifdef USE_BOOST

  utils::InitLogging(PROJECT_NAME);

  BOOST_LOG_TRIVIAL(info) << ""sv << PROJECT_NAME << " v"sv << PROJECT_VERSION;

  BOOST_LOG_TRIVIAL(trace) << "A trace severity message"sv;
  BOOST_LOG_TRIVIAL(debug) << "A debug severity message"sv;
  BOOST_LOG_TRIVIAL(info) << "An informational severity message"sv;
  BOOST_LOG_TRIVIAL(warning) << "A warning severity message"sv;
  BOOST_LOG_TRIVIAL(error) << "An error severity message"sv;
  BOOST_LOG_TRIVIAL(fatal) << "A fatal severity message"sv;

#endif

#ifdef USE_GSTREAMER

#if defined(__APPLE__)
  return gst_macos_main(gstreamer_tutorial_2, argc, argv, nullptr);
#else
  return gstreamer_tutorial_2(argc, argv, nullptr);
#endif

#endif  // USE_GSTREAMER

  return 0;
}
