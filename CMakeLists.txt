cmake_minimum_required(VERSION 3.10)

project(hello_project LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(hello main.cpp math_operations.cpp)
enable_testing()

# Google Test via FetchContent
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/release-1.12.1.tar.gz
)
FetchContent_MakeAvailable(googletest)

add_executable(unit_tests tests/unit_tests.cpp math_operations.cpp)
target_link_libraries(unit_tests PRIVATE GTest::gtest GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(unit_tests)
