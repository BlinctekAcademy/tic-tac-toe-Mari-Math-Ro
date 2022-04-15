class Player {
  String _value;
  int _score;

  Player(this._value, this._score);

  String get value {
    return _value;
  }

  set value(String value) {
    _value = value;
  }

  int get score {
    return _score;
  }

  set score(int score) {
    _score = score;
  }
}
