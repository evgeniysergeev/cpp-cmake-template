#include "logging.h"

namespace utils {

namespace logging = boost::log;
namespace src = boost::log::sources;
namespace sinks = boost::log::sinks;
namespace keywords = boost::log::keywords;

void InitLogging(const std::string &log_file_name)
{
  logging::add_file_log(log_file_name);

  logging::add_file_log
  (
      keywords::file_name = log_file_name,
      keywords::rotation_size = 10 * 1024 * 1024,
      keywords::time_based_rotation = sinks::file::rotation_at_time_point(0, 0, 0)//,
      //keywords::format = "[%TimeStamp%]: %Message%"
  );

  logging::core::get()->set_filter
  (
    logging::trivial::severity >= logging::trivial::info
  );
}

}  // namespace common
