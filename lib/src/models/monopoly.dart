import 'package:flutter/material.dart';

enum MonopolyCard { BANKER, PLAYER_RED, PLAYER_GREEN, PLAYER_BLUE, PLAYER_YELLOW }

class Monopoly {
  Monopoly({
    this.cardHolderName,
    this.color,
    this.type,
    this.cardNumber,
    this.validTo,
    this.light,
    this.cardBalance,
    this.alerts,
  });

  String alerts;
  String validTo;
  double cardBalance;
  String cardNumber;
  double light;
  String cardHolderName;
  List<Color> color;
  List<String> type;

}
