#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <string>

int main() {
  std::ifstream inputFile("./input.txt");
  std::string word;

  while (std::getline(inputFile, word)) {
    std::stringstream currentLine(word);

    while (std::getline(currentLine, word, ' ')) {
    }
  }
}
