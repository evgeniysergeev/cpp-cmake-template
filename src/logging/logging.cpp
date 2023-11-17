#include "logging.h"

namespace utils {

void InitLogging()
{
  logging::core::get()->set_filter
  (
    logging::trivial::severity >= logging::trivial::info
  );
}

}  // namespace common
