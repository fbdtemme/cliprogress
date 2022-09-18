#pragma once

#include <memory>
#include <cliprogress/events/event.hpp>
#include <cliprogress/widget.hpp>

namespace cliprogress {

/// Sigint signal
class termination_event : public event
{
public:
    termination_event()
            : event(event_type::termination)
    {};
};

}