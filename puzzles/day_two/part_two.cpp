#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <string>

enum class GameState { None, GameId, Number, Color };

int main() {
    std::ifstream inputFile("./input.txt");
    std::string word;

    GameState currentState = GameState::None;
    unsigned int totalProduct = 0;
    unsigned int currentAmount = 0;

    std::map<std::string, unsigned int> minimumAmountPerColor = {
        {"blue",  0},
        {"green", 0},
        {"red",   0}
    };

    while (std::getline(inputFile, word)) {
        std::stringstream currentLine(word);

        while (std::getline(currentLine, word, ' ')) {
            if (currentState == GameState::None && word[0] == 'G') {
                currentState = GameState::GameId;

                unsigned int product = 1;
                for (const auto& pair : minimumAmountPerColor) {
                    product *= pair.second;
                    minimumAmountPerColor[pair.first] = 0;
                }
                totalProduct += product;
                continue;
            }

            std::istringstream wordStream(word);

            switch (currentState) {
            case GameState::GameId:
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
                if (currentAmount > minimumAmountPerColor[word]) {
                    minimumAmountPerColor[word] = currentAmount;
                }
                break;
            default:
                break;
            }
        }
    }

    // Compute the product for the last game
    unsigned int finalProduct = 1;
    for (const auto& pair : minimumAmountPerColor) {
        finalProduct *= pair.second;
    }
    totalProduct += finalProduct;

    std::cout << "The sum of the products is " << totalProduct << std::endl;

    std::ofstream outputFile("./output");
    outputFile << totalProduct << std::endl;
}
