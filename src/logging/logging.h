#pragma once

#include <string_view>

#include <boost/log/core.hpp>
#include <boost/log/expressions.hpp>
#include <boost/log/trivial.hpp>

using namespace std::string_view_literals;

namespace logging = boost::log;

namespace utils {

void InitLogging();

}  // namespace common
