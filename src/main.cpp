#include <iostream>
#include <cstdlib>
#include <exception>
#include "version.h"

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

    return 0;
}
