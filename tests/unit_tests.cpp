#include "math_operations.h"
#include <gtest/gtest.h>

// Test case for the add function
TEST(AddFunctionTest, PositiveNumbers) {
    EXPECT_EQ(add(3, 5), 8);
}

TEST(AddFunctionTest, NegativeNumbers) {
    EXPECT_EQ(add(-3, -5), -8);
}

TEST(AddFunctionTest, MixedNumbers) {
    EXPECT_EQ(add(-3, 5), 2);
}

TEST(AddFunctionTest, Zero) {
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(0, 5), 5);
    EXPECT_EQ(add(5, 0), 5);
}

// Main function for running all tests
int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
