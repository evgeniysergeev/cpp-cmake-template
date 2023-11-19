#include <boost/log/sinks.hpp>
#include <boost/log/sinks/sync_frontend.hpp>
#include <boost/log/utility/setup/formatter_parser.hpp>
#include <boost/log/sources/severity_channel_logger.hpp>
#include <boost/log/trivial.hpp>
#include <boost/log/utility/setup/file.hpp>
#include <boost/log/utility/setup/common_attributes.hpp>
#include <boost/log/utility/setup/console.hpp>
#include <boost/log/expressions.hpp>
#include <boost/log/attributes/scoped_attribute.hpp>

#include "logging.h"

namespace utils {

namespace logging = boost::log;
namespace src = boost::log::sources;
namespace sinks = boost::log::sinks;
namespace keywords = boost::log::keywords;

using backend_type = sinks::text_file_backend;
using sink_type = sinks::synchronous_sink<backend_type>;

static const std::string kFormat = "[%TimeStamp%] [%Severity%]: %Message%";

void InitLogging(const std::string &log_name)
{
  logging::add_common_attributes();

  // Construct the sink
  auto backend = boost::make_shared<backend_type>(
      keywords::file_name = log_name + "_%N.log",
      keywords::rotation_size = 10 * 1024 * 1024,
      keywords::time_based_rotation = sinks::file::rotation_at_time_point(0, 0, 0),
      keywords::auto_flush = true);

  auto sink = boost::make_shared<sink_type>(backend);

  sink->set_formatter(logging::parse_formatter(kFormat));
  logging::core::get()->add_sink(sink);

#ifdef _DEBUG
  // Also print output to console for debug build
  logging::add_console_log(
      std::cout,
      keywords::format = kFormat);
#endif

  logging::core::get()->set_filter(
    logging::trivial::severity >= logging::trivial::info);
  }

}  // namespace common
