CXX=clang++
CXXFLAGS=-std=c++17 -Wall -g
TARGET=main

all: $(TARGET)

$(TARGET): main.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) main.cpp

clean:
	rm -f $(TARGET)

run-part1:
	./$(TARGET) 1 < input

run-part2:
	./$(TARGET) 2 < input
