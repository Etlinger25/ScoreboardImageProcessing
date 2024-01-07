class Player {
  String playerName = 'Player';

  int playerScore1;
  int playerScore2;
  int playerScore3;
  int playerScore4;
  bool isSum = false;
  String defaultStringForSum = 'össz';

  Player({
    this.playerName = 'Player',
    this.playerScore1 = 0,
    this.playerScore2 = 0,
    this.playerScore3 = 0,
    this.playerScore4 = 0,
    this.isSum = false,
  });

  int get playerTotalScore =>
      playerScore1 + playerScore2 + playerScore3 + playerScore4;

  int get totalScore => playerTotalScore;
}
