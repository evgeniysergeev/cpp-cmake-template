#include <iostream>
#include <cstdlib>
#include <exception>
#include "config.h"

static std::terminate_handler s_prev_termination_handler = nullptr;

static void termination_handler()
{
    std::cerr << "Unhandled exception" << std::endl << std::flush;

    if (s_prev_termination_handler != nullptr) {
      s_prev_termination_handler();
    }

    std::abort();
}

int main(int argc, char* argv[], char* env[])
{
    s_prev_termination_handler = std::set_terminate(termination_handler);

    std::cout << "C++ CMake Template"
        << " v" << TEMPLATE_PROJECT_VERSION << std::endl
        << " (" << TEMPLATE_PROJECT_VERSION_MAJOR
                << "." << TEMPLATE_PROJECT_VERSION_MINOR
                << "." << TEMPLATE_PROJECT_VERSION_PATCH << "), "
        << "(" << TEMPLATE_PROJECT_VERSION_TWEAK << ")"
        << std::endl;

    return 0;
}
