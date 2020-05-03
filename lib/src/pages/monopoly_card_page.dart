import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/colors.dart' as AppColors;
import 'package:monopoly/src/utils/utils.dart';
import 'package:flutter/rendering.dart';
import 'package:monopoly/src/pages/home_page.dart';
import 'package:monopoly/src/models/models.dart';
import 'package:monopoly/src/widgets/widgets.dart';

class MonopolyCardPage extends StatefulWidget {
  MonopolyCardPage(this.monopoly, this.card);

  MonopolyCard card;
  final List<Monopoly> monopoly;

  @override
  _MonopolyCardPageState createState() => _MonopolyCardPageState();
}

class _MonopolyCardPageState extends State<MonopolyCardPage> {

  TextEditingController _textEditingController;

  double transactionAmount = 0;
  Key _divideKey = Key('divide');
  Key _minusKey = Key('minus');
  Key _multiplyKey = Key('multiply');
  Key _plusKey = Key('plus');

  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }


  double calculateValue(Key _actionKey, double currentValue, double lastValue ) {
    double calculatedValue = 0;
    if (identical(_actionKey, _plusKey)) {
      calculatedValue = Math.add(lastValue, currentValue);
    } else if (identical(_actionKey, _minusKey)) {
      calculatedValue = Math.subtract(lastValue, currentValue);
    } else if (identical(_actionKey, _multiplyKey)) {
      calculatedValue = Math.multiply(lastValue, currentValue);
    } else if (identical(_actionKey, _divideKey)) {
      calculatedValue = Math.divide(lastValue, currentValue);
    }
    return calculatedValue;
  }

  Widget _buildPayeeButton(List<Monopoly> monopoly, int payerCardIndex, int payeeCardIndex) {
    return CustomIconButton(
      circleColor: monopoly[payeeCardIndex].color[1],
      buttonImg: MonopolyIconImages.transfer,
      buttonTitle: monopoly[payeeCardIndex].name.toUpperCase(),
      onTap: () {
        setState(() {
          double  payerAmount = calculateValue(
              _minusKey,
              transactionAmount,
              monopoly[payerCardIndex].totalAmount);

          if(payerAmount.isNegative) {
            _textEditingController.clear();
            _textEditingController.text = 'Low Balance';
          }else{
            double payeeAmount = calculateValue(
                _plusKey,
                transactionAmount,
                monopoly[payeeCardIndex].totalAmount);
            monopoly[payerCardIndex].totalAmount = payerAmount;
            monopoly[payeeCardIndex].totalAmount = payeeAmount;
            _textEditingController.clear();
            _textEditingController.text =
                CurrencyFormater.withSuffix(payeeAmount);
          }

        });

      },
    );
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        appBar: AppBar(
          title: Text(
            widget.monopoly[widget.card.index].name.toUpperCase(),
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w100,
              fontSize: 21.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Container(
                height: 21,
                width: 21,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2.0,
                        color: Colors.grey[300],
                        spreadRadius: 2.0),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(51),
                    bottomLeft: Radius.circular(51),
                  ),
                  color: Colors.white,
                ),
                child: Hero(
                  tag: "card",
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: CreditCardContainer(model: widget.monopoly, card: widget.card,),
                      onTap: () {
                      },
                    ),
                  ),
                ),
              ),
              CustomContainer(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width),
                      height: ((MediaQuery.of(context).size.height)/300)*20,
                      child: IgnorePointer(
                        child: TextField(
                          enabled: true,
                          autofocus: true,
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                          controller: _textEditingController,
                          textAlign: TextAlign.center,
                          cursorColor: widget.monopoly[widget.card.index].color[2],
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 35.0,
                          ),
                          decoration: InputDecoration.collapsed(
                              hintText: '0',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0
                              )
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomIconButton(
                          circleColor: MonopolyIconColors.send,
                          buttonImg: MonopolyIconImages.million,
                          buttonTitle: "MILLIONS",
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            transactionAmount = _textEditingController.text.isEmpty? 1 : double.parse(_textEditingController.text);
                            print(transactionAmount);
                            transactionAmount = calculateValue(_multiplyKey, transactionAmount, Constants.MILLION);
                            setState(() {
                              _textEditingController.clear();
                              _textEditingController.text =
                                  CurrencyFormater.withSuffix(transactionAmount);
                            });
                          },
                        ),
                        CustomIconButton(
                          circleColor: MonopolyIconColors.transfer,
                          buttonImg: MonopolyIconImages.thousand,
                          buttonTitle: "THOUSANDS",
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            transactionAmount = _textEditingController.text.isEmpty? 1 : double.parse(_textEditingController.text);
                            transactionAmount = calculateValue(_multiplyKey, transactionAmount, Constants.KILO);
                            setState(() {
                              _textEditingController.clear();
                              _textEditingController.text =
                                  CurrencyFormater.withSuffix(transactionAmount);
                            });
                          },
                        ),
                        CustomIconButton(
                          circleColor: MonopolyIconColors.more,
                          buttonImg: MonopolyIconImages.pay,
                          buttonTitle: "GO",
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            transactionAmount = widget.monopoly[widget.card.index].totalAmount;
                            transactionAmount = calculateValue(_plusKey, transactionAmount, 2*Constants.MILLION);
                            setState(() {
                              widget.monopoly[widget.card.index].totalAmount = transactionAmount;
                              _textEditingController.text =
                                  CurrencyFormater.withSuffix(transactionAmount);
                            });
                          },
                        ),
                        CustomIconButton(
                          circleColor: MonopolyIconColors.passbook,
                          buttonImg: MonopolyIconImages.clear,
                          buttonTitle: "CLEAR",
                          onTap: () {
                            _textEditingController.clear();
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildPayeeButton(
                            widget.monopoly,
                            widget.card.index,
                            (MonopolyCard.PLAYER_RED.index == widget.card.index) ? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_RED.index,
                            ),
                        _buildPayeeButton(
                            widget.monopoly,
                            widget.card.index,
                            (MonopolyCard.PLAYER_GREEN.index == widget.card.index) ? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_GREEN.index,),
                        _buildPayeeButton(
                            widget.monopoly,
                            widget.card.index,
                            (MonopolyCard.PLAYER_BLUE.index == widget.card.index)? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_BLUE.index,),
                        _buildPayeeButton(
                            widget.monopoly,
                            widget.card.index,
                            (MonopolyCard.PLAYER_YELLOW.index == widget.card.index) ? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_YELLOW.index,),
                      ],
                    ),
                  ]),
              ),
              CustomContainer(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Transactions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        CustomRoundedButton(
                          buttonText: "More",
                          color: Colors.blue,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Divider(),
                    ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        HistoryListTile(
                          iconColor: Colors.red,
                          onTap: () {},
                          transactionAmount: "+\$210.00",
                          transactionIcon: MonopolyIconImages.transfer,
                          transactionName: "Amazigh Halzoun",
                          transactionType: "TRANSFER",
                        ),
                        HistoryListTile(
                          iconColor: MonopolyIconColors.transfer,
                          onTap: () {},
                          transactionAmount: "-\$310.00",
                          transactionIcon: MonopolyIconImages.transfer,
                          transactionName: "Cybdom Tech",
                          transactionType: "TRANSFER",
                        ),
                        HistoryListTile(
                          iconColor: MonopolyIconColors.send,
                          onTap: () {},
                          transactionAmount: "-\$210.00",
                          transactionIcon: MonopolyIconImages.transfer,
                          transactionName: "Wife",
                          transactionType: "TRANSFER",
                        ),
                        HistoryListTile(
                          iconColor: MonopolyIconColors.send,
                          onTap: () {},
                          transactionAmount: "-\$210.00",
                          transactionIcon: MonopolyIconImages.transfer,
                          transactionName: "Wife",
                          transactionType: "TRANSFER",
                        ),
                      ],
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

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({
    Key key,
    this.iconColor,
    this.transactionName,
    this.transactionType,
    this.transactionAmount,
    this.transactionIcon,
    this.onTap,
  }) : super(key: key);

  final Color iconColor;
  final GestureTapCallback onTap;
  final String transactionName,
      transactionType,
      transactionAmount,
      transactionIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(transactionName, style: TextStyle(fontSize: 15)),
        subtitle: Text(transactionType),
        trailing: Text(transactionAmount),
        leading: CircleAvatar(
          radius: 20,
          child: Image.asset(
            transactionIcon,
            height: 25,
            width: 25,
          ),
          backgroundColor: iconColor,
        ),
        enabled: true,
        onTap: onTap,
      ),
    );
  }
}

class CustomRoundedButton extends StatelessWidget {
  CustomRoundedButton({
    @required this.color,
    @required this.buttonText,
    @required this.onTap,
  });

  final String buttonText;
  final Color color;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 7.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            "More",
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    @required this.circleColor,
    @required this.buttonTitle,
    @required this.buttonImg,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  final String buttonTitle, buttonImg;
  final Color circleColor;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: circleColor,
                child: Image.asset(
                  buttonImg,
                  height: 25,
                  width: 25,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                buttonTitle,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 12,),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomContainer extends StatelessWidget {
  CustomContainer({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21),
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey[300],
            spreadRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(41),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
