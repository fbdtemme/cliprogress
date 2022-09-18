#pragma once
#include <memory>


#include "cliprogress/concurrent_queue.hpp"
#include "cliprogress/events/event.hpp"

namespace cliprogress {

class event_item {
public:
    std::shared_ptr<event> value;
    std::weak_ptr<widget> destination;
};

using event_queue = concurrent_queue<event_item>;

}