
# Compiler and flags
CXX := clang++
STD := -std=c++20
CXXFLAGS := $(shell pkg-config --cflags --libs glfw3)

# Directories
SRC_DIR := src
INCLUDE_DIR := include
BUILD_DIR := build
EXTERNAL_DIR := external
GLAD_SRC_DIR := $(EXTERNAL_DIR)/GLAD/src
GLAD_INCLUDE_DIR := $(EXTERNAL_DIR)/GLAD/include

# Source files
SRCS := $(SRC_DIR)/main.cpp $(GLAD_SRC_DIR)/glad.c

OBJS := $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(patsubst %.c,$(BUILD_DIR)/%.o,$(SRCS)))

# Final executable
TARGET := $(BUILD_DIR)/main

# Default rule
all: $(TARGET)

# Linking rule
$(TARGET): $(OBJS)
	@echo "Linking..."
	$(CXX) $(STD) $(OBJS) -o $@ $(CXXFLAGS)

# Compile .cpp files
$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	@echo "Compiling C++: $<"
	$(CXX) $(STD) $(CXXFLAGS) -I$(INCLUDE_DIR) -I$(GLAD_INCLUDE_DIR) -c $< -o $@

# Compile .c files (for GLAD)
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "Compiling GLAD: $<"
	clang $(CXXFLAGS) -I$(GLAD_INCLUDE_DIR) -c $< -o $@

# Clean build files
clean:
	@echo "Cleaning..."
	rm -rf $(BUILD_DIR)

.PHONY: all clean
