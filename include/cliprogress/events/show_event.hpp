#pragma once

#include "cliprogress/events/event.hpp"
namespace cliprogress {

class show_event : public event
{
public:
    show_event()
            : event(event_type::show)
    {};
};

}