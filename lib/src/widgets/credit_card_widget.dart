import 'package:flutter/material.dart';
import 'package:monopoly/src/models/monopoly.dart';
import 'package:monopoly/src/utils/currency_formater_helper.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 31, vertical: 21),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/credit_card/chip.png",
                width: 51,
                height: 51,
              ),
            ),
            Text(
              "4000 1234 5678 9010",
              //CurrencyFormater.withSuffix(model[card.index].totalAmount),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "VALID FROM: ",
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    Text(
                      "09/21",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  width: 21,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "VALID THRU: ",
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    Text(
                      "09/23",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              model[card.index].name.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
