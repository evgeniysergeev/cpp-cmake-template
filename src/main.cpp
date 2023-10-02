#include <iostream>
#include "config.h"

int main(int argc, char* argv[], char* env[])
{
    std::cout << "C++ CMake Template"
        << " v" << TEMPLATE_PROJECT_VERSION_MAJOR << "." << TEMPLATE_PROJECT_VERSION_MINOR << std::endl;

    return 0;
}
