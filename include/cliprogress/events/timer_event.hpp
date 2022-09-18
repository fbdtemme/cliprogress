#pragma once

#include <memory>
#include <cliprogress/events/event.hpp>
#include <cliprogress/widget.hpp>

namespace cliprogress {

class timer_event : public event
{
public:
    explicit timer_event(std::size_t timer_id)
        : event(event_type::timer)
        , timer_id_(timer_id)
    {}

    [[nodiscard]]
    std::size_t timer_id() const
    {
        return timer_id_;
    }

private:
    std::size_t timer_id_;
};

}