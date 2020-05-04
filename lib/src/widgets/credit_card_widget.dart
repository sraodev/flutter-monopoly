import 'package:flutter/material.dart';
import 'dart:math';
import 'package:monopoly/src/models/models.dart';
import 'package:monopoly/src/utils/utils.dart';
import 'package:flutter_shine/flutter_shine.dart';

class CreditCardContainer extends StatelessWidget {
  CreditCardContainer({
    @required this.model,
    this.card,
    this.key,
  }) : super(key: key);

  final MonopolyCard card;
  final Key key;
  final List<Monopoly> model;

  @override
  Widget build(BuildContext context) {
    return Container(
      //MediaQuery.of(context).size.width / 4,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 15,
          vertical: MediaQuery.of(context).size.width / 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 5.0,
              color: model[card.index].color[0],
              offset: Offset(0, 5)),
        ],
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.1, 0.4, 0.6, 0.9],
          colors: [
            model[card.index].color[0],
            model[card.index].color[1],
            model[card.index].color[2],
            model[card.index].color[3],
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Image.asset(
                    "assets/images/credit_card/chip.png",
                    width: 41,
                    height: 41,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Image.asset(
                    "assets/images/credit_card/monopoly.png",
                    width: 150,
                    height: 41,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                FlutterShine(
                    builder: (BuildContext context, ShineShadow shineShadow) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "NET WORTH",
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10.0,
                            shadows: shineShadow?.shadows),
                      ),
                      Text(
                        "\$" +
                            CurrencyFormater.withSuffix(
                                model[card.index].cardBalance),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            shadows: shineShadow?.shadows),
                      ),
                    ],
                  );
                }),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            FlutterShine(
                builder: (BuildContext context, ShineShadow shineShadow) {
              return Text(
                model[card.index].cardNumber,
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 18,
                    shadows: shineShadow?.shadows),
              );
            }),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterShine(
                      builder: (BuildContext context, ShineShadow shineShadow) {
                    return Text(
                      model[card.index].cardHolderName.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                        shadows: shineShadow?.shadows,
                      ),
                    );
                  }),
                  FlutterShine(
                      builder: (BuildContext context, ShineShadow shineShadow) {
                    return Column(
                      children: <Widget>[
                        Text(
                          "VALIDTO: ",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 8.0,
                            shadows: shineShadow?.shadows,
                          ),
                        ),
                        Text(
                          model[card.index].validTo,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                            shadows: shineShadow?.shadows,
                          ),
                        ),
                      ],
                    );
                  }),
                  Container(
                    child: Image.asset(
                      "assets/images/credit_card/visa.png",
                      width: 61,
                      height: 41,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
