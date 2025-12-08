cmake_minimum_required(VERSION 3.10)

project(MathProject LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Основна бібліотека/модуль з попередньої лаби
add_library(math_lib
    math_operations.cpp
)

target_include_directories(math_lib
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
)

add_executable(main_app
    main.cpp
)

target_link_libraries(main_app
    PRIVATE math_lib
)

# Юніт-тести зараз повністю вимкнені, щоб CI не падав
option(ENABLE_UNIT_TESTS "Build unit tests" OFF)

if(ENABLE_UNIT_TESTS)
    enable_testing()

    add_executable(unit_tests
        tests/unit_tests.cpp
    )

    target_link_libraries(unit_tests
        PRIVATE math_lib
    )

    add_test(NAME unit_tests COMMAND unit_tests)
endif()
