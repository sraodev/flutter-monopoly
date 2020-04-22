import 'package:flutter/material.dart';
class Monopoly {
  Monopoly({
    this.name,
    this.color,
    this.type,
    this.top,
    this.plantOfTheMonth,
    this.price,
    this.image,
    this.size,
    this.description,
    this.temperature,
    this.light,
    this.totalAmount,
    this.soilMoisture,
    this.waterTankLevel,
    this.wateringTime,
    this.alerts,
  });

  String alerts;
  String description;
  double totalAmount;
  String image;
  double light;
  String name;
  Color color;
  bool plantOfTheMonth;
  double price;
  String size;
  double soilMoisture;
  double temperature;
  bool top;
  List<String> type;
  double wateringTime;
  double waterTankLevel;
}
