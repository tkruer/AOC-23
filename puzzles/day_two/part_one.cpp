#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <string>

enum class GameState { None, GameId, Number, Color };

int main() {
  const std::map<std::string, unsigned int> maximumAmountPerColor = {
      {"blue", 14}, {"green", 13}, {"red", 12}};

  std::ifstream inputFile("./input.txt");
  std::string word;

  GameState currentState = GameState::None;
  unsigned int totalGameIdSum = 0;
  unsigned int currentGameId = 0;
  unsigned int currentAmount = 0;
  bool isImpossible = false;

  while (std::getline(inputFile, word)) {
    std::stringstream currentLine(word);

    while (std::getline(currentLine, word, ' ')) {
      if (currentState == GameState::None && word[0] == 'G') {
        currentState = GameState::GameId;
        if (!isImpossible) {
          totalGameIdSum += currentGameId;
        }
        isImpossible = false;
        continue;
      }

      std::istringstream wordStream(word);

      switch (currentState) {
      case GameState::GameId:
        wordStream >> currentGameId;
        currentState = GameState::Number;
        break;
      case GameState::Number:
        wordStream >> currentAmount;
        currentState = GameState::Color;
        break;
      case GameState::Color:
        if (word.back() == ',' || word.back() == ';') {
          word.pop_back();
          currentState = GameState::Number;
        } else {
          currentState = GameState::None;
        }
        if (currentAmount > maximumAmountPerColor.at(word)) {
          isImpossible = true;
        }
        break;
      default:
        break;
      }
    }
  }

  if (!isImpossible) {
    totalGameIdSum += currentGameId;
  }

  std::cout << "The sum of the IDs is " << totalGameIdSum << std::endl;

  std::ofstream outputFile("./output");
  outputFile << totalGameIdSum << std::endl;
}
