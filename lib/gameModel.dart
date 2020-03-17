import 'package:flutter/foundation.dart';

class GameModel extends ChangeNotifier {
  List<String> gameList = List.generate(9, (index) => '');
  int turn = 0;
  bool isWon = false;
  writeToPosition(int x) {
    if (gameList[x].isEmpty && !isWon) {
      gameList[x] = turn % 2 == 0 ? 'O' : 'X';
      turn++;
      notifyListeners();
    }
  }

  reset() {
    gameList = List.generate(9, (index) => '');
    turn = 0;
    isWon = false;
    notifyListeners();
  }

  bool checkRows(int rowID) {
    return (gameList[rowID].isNotEmpty) &&
        (gameList[rowID] == gameList[rowID + 1]) &&
        (gameList[rowID] == gameList[rowID + 2]);
  }

  bool checkColumns(int columnID) {
    return (gameList[columnID].isNotEmpty) &&
        (gameList[columnID] == gameList[columnID + 3]) &&
        (gameList[columnID] == gameList[columnID + 6]);
  }

  bool checkMajorDiagonal() {
    return (gameList[0] == gameList[4]) &&
        (gameList[0] == gameList[8]) &&
        gameList[0].isNotEmpty;
  }

  bool checkMinorDiagonal() {
    return (gameList[2] == gameList[4]) &&
        (gameList[2] == gameList[6]) &&
        gameList[2].isNotEmpty;
  }

  win() {
    if (checkColumns(0) || checkColumns(1) || checkColumns(2)) {
      isWon = true;
      return true;
    } else if (checkColumns(0) || checkRows(3) || checkRows(6)) {
      isWon = true;
      return true;
    } else if (checkMajorDiagonal() || checkMinorDiagonal()) {
      isWon = true;
      return true;
    }
    return false;
  }
}
