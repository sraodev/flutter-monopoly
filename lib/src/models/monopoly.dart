import 'package:flutter/material.dart';

enum MonopolyCard {
  BANKER,
  PLAYER_RED,
  PLAYER_GREEN,
  PLAYER_BLUE,
  PLAYER_YELLOW
}

class Monopoly {
  Monopoly({
    this.cardHolderName,
    this.color,
    this.cardNumber,
    this.validTo,
    this.cardBalance,
    this.alerts,
  });

  String alerts;
  double cardBalance;
  String cardHolderName;
  String cardNumber;
  List<Color> color;
  String validTo;
}
