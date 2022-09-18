#include <catch2/catch_all.hpp>

#include "cliprogress/widgets/label.hpp"
#include <iostream>
#include <sstream>


TEST_CASE("label")
{
    cliprogress::label l{ "test1" };
    l.set_padding(1);
    l.allocate_size(l.natural_size());

    std::stringstream os {};
    os << l;
    auto r = os.str();
    CHECK(r == " test1 ");
}