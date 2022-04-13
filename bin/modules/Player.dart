class Player {
  String _value;
  int _score;

  Player(this._value, this._score);

  String get value {
    return _value;
  }

  set value(value) {
    _value = value;
  }

  int get score {
    return _score;
  }

  set score(score) {
    _score = score;
  }
}
