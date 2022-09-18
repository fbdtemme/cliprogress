#pragma once

#include <memory>

#include "cliprogress/events/event.hpp"
#include "cliprogress/widget.hpp"

namespace cliprogress {

class layout_event : public event
{
public:
    layout_event(std::weak_ptr<widget> source)
            : source_(source)
            , event(event_type::layout)
    {}

    std::weak_ptr<widget> source() const
    {
        return source_;
    }

private:
    std::weak_ptr<widget> source_;
};

}