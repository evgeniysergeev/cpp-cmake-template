#include <iostream>
#include "config.h"

int main(int argc, char* argv[], char* env[])
{
    std::cout << "C++ CMake Template"
        << " v" << TEMPLATE_PROJECT_VERSION << std::endl
        << " (" << TEMPLATE_PROJECT_VERSION_MAJOR
                << "." << TEMPLATE_PROJECT_VERSION_MINOR
                << "." << TEMPLATE_PROJECT_VERSION_PATCH << "), "
        << "(" << TEMPLATE_PROJECT_VERSION_TWEAK << ")"
        << std::endl;

    return 0;
}
