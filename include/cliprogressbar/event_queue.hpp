#pragma once
#include <memory>
#include <tbb/concurrent_queue.h>

#include "cliprogressbar/events/event.hpp"

namespace cliprogress {

class event_item {
public:
    std::shared_ptr<event> value;
    std::weak_ptr<widget> destination;
};

using event_queue = tbb::concurrent_bounded_queue<event_item>;

}