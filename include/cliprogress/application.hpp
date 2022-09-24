#pragma once
#include <atomic>
#include <concepts>
#include <map>
#include <memory>

#include "cliprogress/progress_data.hpp"
#include "cliprogress/events/event.hpp"
#include "cliprogress/event_queue.hpp"
#include "cliprogress/widget.hpp"
#include "cliprogress/periodic_timer.hpp"
#include "cliprogress/terminal_writer.hpp"

#if defined(__linux__)
#include "cliprogress/posix_signal_notifier.hpp"
#endif

namespace cliprogress {


/// The root progressbar
class application
{
public:
    application();

    application(std::ostream& os);

    void queue_event(std::shared_ptr<event> e, std::weak_ptr<widget> receiver = {});

    /// Enter main event loop.s
    void start();

    /// Block until the application quits after a call to request_stop().
    void wait();

    /// Stops the event loop.
    void request_stop();

    std::weak_ptr<widget> add_widget(std::shared_ptr<widget> w);

    void remove_widget(const widget* w);

    void remove_widget(const std::shared_ptr<widget>& w);

    /// Add a widget id to the register
    void register_widget_id(std::size_t id, std::weak_ptr<widget> root);

    void unregister_widget_id(std::size_t id);

    terminal_writer& writer();

    /// Return the singe application instance.
    static application* instance() noexcept;

    ~application() noexcept;

private:
    void register_signals();

    void resize_handler();

    void sigint_handler();

    void event_loop(std::stop_token stop_token);

    void process_event(event_item& item);

    template <typename Fn>
    void for_each_widget(Fn&& fn)
    {
        std::unique_lock lck(widgets_mutex_);
        std::for_each(widgets_.begin(), widgets_.end(), fn);
    }

    std::jthread event_loop_;
    termcontrol::terminal_size term_size_;
    std::atomic_ref<termcontrol::terminal_size> term_size_ref_;
    terminal_writer writer_ {};
    event_queue event_queue_;

#if defined(__linux__)
    std::shared_ptr<posix_signal_notifier> signal_notifier_ {};
#endif

    std::mutex widgets_mutex_;
    std::list<std::shared_ptr<widget>> widgets_ {};

    detail::periodic_timer frame_clock_;
    detail::periodic_timer terminal_size_clock_;

    std::mutex widget_register_mutex_;
    std::map<std::size_t, std::weak_ptr<widget>> widget_register_;

    inline static std::atomic<application*> instance_;

};
}