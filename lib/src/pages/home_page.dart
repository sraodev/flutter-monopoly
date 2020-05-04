import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/colors.dart' as AppColors;
import 'package:random_string/random_string.dart';
import 'package:monopoly/src/models/models.dart';
import 'package:monopoly/src/pages/monopoly_card_page.dart';
import 'package:monopoly/src/widgets/widgets.dart';
import 'package:monopoly/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Monopoly> monopoly = [
    Monopoly(
        cardHolderName: 'Banker',
        color: [
          Colors.grey[900],
          Colors.grey[700],
          Colors.grey[400],
          Colors.grey[200],
        ],
        cardNumber: randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString(),
        validTo: DateTime.now().month.toString() +
            "/" +
            DateTime.now().year.toString(),
        cardBalance: 150000000,
        alerts: ''),
    Monopoly(
        cardHolderName: 'Player 1',
        color: [
          Colors.red[900],
          Colors.red[700],
          Colors.red[400],
          Colors.red[200],
        ],
        cardNumber: randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString(),
        validTo: DateTime.now().month.toString() +
            "/" +
            DateTime.now().year.toString(),
        cardBalance: 15000000,
        alerts: ''),
    Monopoly(
        cardHolderName: 'Player 2',
        color: [
          Colors.green[900],
          Colors.green[700],
          Colors.green[400],
          Colors.green[200],
        ],
        cardNumber: randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString(),
        validTo: DateTime.now().month.toString() +
            "/" +
            DateTime.now().year.toString(),
        cardBalance: 15000000,
        alerts: ''),
    Monopoly(
        cardHolderName: 'Player 3',
        color: [
          Colors.blue[900],
          Colors.blue[700],
          Colors.blue[400],
          Colors.blue[200],
        ],
        cardNumber: randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString(),
        validTo: DateTime.now().month.toString() +
            "/" +
            DateTime.now().year.toString(),
        cardBalance: 15000000,
        alerts: ''),
    Monopoly(
        cardHolderName: 'Player 4',
        color: [
          Colors.yellow[900],
          Colors.yellow[700],
          Colors.yellow[400],
          Colors.yellow[200],
        ],
        cardNumber: randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString() +
            " " +
            randomNumeric(4).toString(),
        validTo: DateTime.now().month.toString() +
            "/" +
            DateTime.now().year.toString(),
        cardBalance: 15000000,
        alerts: ''),
  ];

  @override
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 30.0, right: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset(
                "assets/images/monopoly_logo.png",
                width: 51,
                height: 51,
                color: Colors.grey[500],
              ),
            ),
            RichText(
                text: TextSpan(
                    // set the default style for the children TextSpans
                    children: [
                  TextSpan(
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500]),
                      text: Constants.APP_NAME),
                ])),
          ],
        ),
      ),
    );
  }

  @override
  Widget _buildMonopolyCreditCard(List<Monopoly> monopoly, MonopolyCard card) {
    return Hero(
      tag: monopoly[card.index].cardHolderName,
      child: InkWell(
        child: CreditCardContainer(model: monopoly, card: card),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MonopolyCardPage(monopoly, card),
            ),
          );
        },
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          _buildMonopolyCreditCard(monopoly, MonopolyCard.BANKER),
          _buildMonopolyCreditCard(monopoly, MonopolyCard.PLAYER_RED),
          _buildMonopolyCreditCard(monopoly, MonopolyCard.PLAYER_GREEN),
          _buildMonopolyCreditCard(monopoly, MonopolyCard.PLAYER_BLUE),
          _buildMonopolyCreditCard(monopoly, MonopolyCard.PLAYER_YELLOW),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: _buildBody(),
    );
  }
}
