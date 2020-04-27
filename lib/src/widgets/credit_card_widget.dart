import 'package:flutter/material.dart';
import 'package:monopoly/src/models/models.dart';
import 'package:monopoly/src/utils/utils.dart';


class CreditCardContainer extends StatelessWidget {
  CreditCardContainer({@required this.model,
    this.card,
    this.key,
  }) : super(key: key);

  final Key key;
  final MonopolyCard card;
  final List<Monopoly> model;

  @override
  Widget build(BuildContext context) {
    return Container(
      //MediaQuery.of(context).size.width / 4,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 12,
          vertical: MediaQuery.of(context).size.width / 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 5.0, color: model[card.index].color[0], offset: Offset(0, 5)),
        ],
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [
            0.1,
            0.4,
            0.6,
            0.9
          ],
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
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Image.asset(
                    "assets/images/credit_card/chip.png",
                    width: 41,
                    height: 41,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(111, 0, 0, 0),
                  child: Image.asset(
                    "assets/images/credit_card/monopoly.png",
                    width: 120,
                    height: 41,
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 5,
            ),

            Text(
              "4000 1234 5678 9010",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "NET WORTH ",
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    Text(
                      CurrencyFormater.withSuffix(model[card.index].totalAmount),
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "US DOLLARS: ",
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    Text(
                      "0000",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        model[card.index].name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                  ),
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
