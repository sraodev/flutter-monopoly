import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/src/utils/constants.dart';
import 'package:monopoly/src/utils/currency_formater_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoly/colors.dart' as AppColors;
import 'package:monopoly/src/models/monopoly.dart';
import 'package:monopoly/src/pages/home_page.dart';
import 'package:monopoly/src/widgets/description_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:monopoly/src/widgets/monopoly_icon_icons.dart';

typedef ActionCallBack = void Function(Key key);
typedef KeyCallBack = void Function(Key key, int index);

const Color primaryColor = const Color(0xff50E3C2);
const Color keypadColor = const Color(0xff4A4A4A);

class MonopolyCardDetailPage extends StatefulWidget {
  MonopolyCardDetailPage(this.monopoly, this.card);

  MonopolyCard card;
  final List<Monopoly> monopoly;

  @override
  _MonopolyCardDetailPageState createState() => _MonopolyCardDetailPageState();
}

class _MonopolyCardDetailPageState extends State<MonopolyCardDetailPage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  var height;
  double lastValue;
  bool savedLastValue = false;
  var width;

  Key _actionKey;
  Key _allClearKey = Key('allclear');
  Key _blackCardKey = Key('blackCardKey');
  Key _blueCardKey = Key('blueCardKey');
  Key _clearKey = Key('clear');
  List _currentValues = List();
  Key _divideKey = Key('divide');
  Key _dotKey = Key('dot');
  Key _eightKey = Key('eight');
  Key _equalsKey = Key('equals');
  Key _fiveKey = Key('five');
  Key _fourKey = Key('four');
  Key _greenCardKey = Key('greenCardKey');
  Key _kiloKey = Key('kiloKey');
  Key _millionKey = Key('millionKey');
  Key _minusKey = Key('minus');
  Key _multiplyKey = Key('multiply');
  Key _nineKey = Key('nine');
  Key _oneKey = Key('one');
  Key _plusKey = Key('plus');
  Key _redCardKey = Key('redCardKey');
  Key _sevenKey = Key('seven');
  Key _sixKey = Key('six');
  TextEditingController _textEditingController;
  Key _threeKey = Key('three');
  Key _twoKey = Key('two');
  Key _yellowCardKey = Key('yellowCardKey');
  Key _zeroKey = Key('zero');

  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  Widget _buildHeader(context) {
    return Container(
      height: 30.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 45.0),
      padding: EdgeInsets.only(left: 25.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            iconSize: 24,
            padding: EdgeInsets.only(right: 25.0),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonopolyInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.monopoly[widget.card.index].name,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 25.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Icon(
                  MonopolyIcon.dollar,
                  color: Colors.white38,
                  size: 45.0,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        RichText(
                            text: TextSpan(
                                // set the default style for the children TextSpans
                                children: [
                              TextSpan(
                                  style: TextStyle(
                                      fontSize: 55,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: CurrencyFormater.withSuffix(widget.monopoly[widget.card.index].totalAmount)),
                                  ]),
                            ])),
                      ]),
                    ]),
              ]),
            ],
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  void onActionTapped(Key actionKey) {
    setState(() {
      _actionKey = actionKey;

      if (_currentValues.isNotEmpty) {
        lastValue = double.parse(convertToString(_currentValues));
      }
    });
  }

  void onKeyTapped(Key key, int cardIndex) {
    if (savedLastValue == false && lastValue != null) {
      _currentValues.clear();
      savedLastValue = true;
    }
    setState(() {
      if (identical(_sevenKey, key)) {
        _currentValues.add('7');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_eightKey, key)) {
        _currentValues.add('8');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_nineKey, key)) {
        _currentValues.add('9');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_fourKey, key)) {
        _currentValues.add('4');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_fiveKey, key)) {
        _currentValues.add('5');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_sixKey, key)) {
        _currentValues.add('6');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_oneKey, key)) {
        _currentValues.add('1');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_twoKey, key)) {
        _currentValues.add('2');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_threeKey, key)) {
        _currentValues.add('3');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_dotKey, key)) {
        if (!_currentValues.contains('.')) {
          _currentValues.add('.');
        }
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_zeroKey, key)) {
        _currentValues.add('0');
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_clearKey, key)) {
        print('Values :: $_currentValues');
        _currentValues.removeLast();
        _textEditingController.text = convertToString(_currentValues);
      } else if (identical(_allClearKey, key)) {
        _currentValues.clear();
        lastValue = null;
        savedLastValue = false;
        _actionKey = null;
        _textEditingController.clear();
      } else if (identical(_equalsKey, key)) {
        calculateValue(MonopolyCard.BANKER.index);
        savedLastValue = false;
      } else if (identical(_kiloKey, key)) {
          double doubleValue = Math.multiply(
              Constants.KILO, double.parse(convertToString(_currentValues)));

          if(doubleValue.toInt() <= widget.monopoly[cardIndex].totalAmount.toInt()){
            String value = validateDouble(doubleValue);
            _currentValues.clear();
            _currentValues = convertToList(value);
            _actionKey = null;
            setState(() {
              _textEditingController.text = CurrencyFormater.withSuffix(doubleValue);
            });
          }else{
            _currentValues.clear();
            lastValue = null;
            savedLastValue = false;
            _actionKey = null;
            _textEditingController.clear();
            _textEditingController.text = 'Low Balance';
          }
      } else if (identical(_millionKey, key)) {
        double doubleValue = Math.multiply(
            Constants.MILLION, double.parse(convertToString(_currentValues)));

        if(doubleValue.toInt() <= widget.monopoly[cardIndex].totalAmount.toInt()){
          String value = validateDouble(doubleValue);
          _currentValues.clear();
          _currentValues = convertToList(value);
          _actionKey = null;
          setState(() {
            _textEditingController.text = CurrencyFormater.withSuffix(doubleValue);
          });
        }else{
          _currentValues.clear();
          lastValue = null;
          savedLastValue = false;
          _actionKey = null;
          _textEditingController.clear();
          _textEditingController.text = 'Low Balance';
        }
      } else if (identical(_redCardKey, key)) {
        if(_actionKey != null) {
          _currentValues.clear();
          _currentValues.add('${widget.monopoly[cardIndex].totalAmount}');
          calculateValue(cardIndex);

          _actionKey = _plusKey;
          _currentValues.clear();
          _currentValues.add(
              '${widget.monopoly[MonopolyCard.PLAYER_RED.index].totalAmount}');
          calculateValue(MonopolyCard.PLAYER_RED.index);
          savedLastValue = false;
        }else{
          setState(() {
            _textEditingController.text = 'InvalidOp';
            _currentValues.clear();
          });
        }
      } else if (identical(_blueCardKey, key)) {
        if(_actionKey != null) {
          _currentValues.clear();
          _currentValues.add('${widget.monopoly[cardIndex].totalAmount}');
          calculateValue(cardIndex);

          _actionKey = _plusKey;
          _currentValues.clear();
          _currentValues.add(
              '${widget.monopoly[MonopolyCard.PLAYER_BLUE.index].totalAmount}');
          calculateValue(MonopolyCard.PLAYER_BLUE.index);
          savedLastValue = false;
        }else{
          setState(() {
            _textEditingController.text = 'InvalidOp';
            _currentValues.clear();
          });
        }
      } else if (identical(_greenCardKey, key)) {
        if(_actionKey != null) {
          _currentValues.clear();
          _currentValues.add('${widget.monopoly[cardIndex].totalAmount}');
          calculateValue(cardIndex);

          _actionKey = _plusKey;
          _currentValues.clear();
          _currentValues.add('${widget.monopoly[MonopolyCard.PLAYER_GREEN.index]
              .totalAmount}');
          calculateValue(MonopolyCard.PLAYER_GREEN.index);
          savedLastValue = false;
        }else{
          setState(() {
            _textEditingController.text = 'InvalidOp';
            _currentValues.clear();
          });
        }
      } else if (identical(_yellowCardKey, key)) {
        if(_actionKey != null) {
          _currentValues.clear();
          _currentValues.add('${widget.monopoly[cardIndex].totalAmount}');
          calculateValue(cardIndex);

          _actionKey = _plusKey;
          _currentValues.clear();
          _currentValues.add(
              '${widget.monopoly[MonopolyCard.PLAYER_YELLOW.index]
                  .totalAmount}');
          calculateValue(MonopolyCard.PLAYER_YELLOW.index);
          savedLastValue = false;
        }else{
          setState(() {
            _textEditingController.text = 'InvalidOp';
            _currentValues.clear();
          });
        }
      }else if (identical(_blackCardKey, key)) {
        if(_actionKey != null){
        _actionKey = _plusKey;
        _currentValues.clear();
        _currentValues.add('${widget.monopoly[MonopolyCard.BANKER.index].totalAmount}');
        calculateValue(MonopolyCard.BANKER.index);
        savedLastValue = false;
      }else{
          setState(() {
            _textEditingController.text = 'InvalidOp';
            _currentValues.clear();
          });
        }
      }
    });
  }

  String validateDouble(double doubleValue) {
    int value;
    if (doubleValue % 1 == 0) {
      value = doubleValue.toInt();
    } else {
      return doubleValue.toStringAsFixed(3);
    }
    return value.toString();
  }

  void calculateValue(int cardIndex) {
    String value;
    double doubleValue;
    if (identical(_actionKey, _plusKey)) {
      if(lastValue.toInt() >= Constants.KILO.toInt()) {
        doubleValue =
            Math.add(lastValue, double.parse(convertToString(_currentValues)));
        value = validateDouble(doubleValue);
        print('Value after conversion : $value');
        _currentValues.clear();
        _currentValues = convertToList(value);
        _actionKey = null;
        setState(() {
          widget.monopoly[cardIndex].totalAmount = doubleValue;
          _textEditingController.text =
              CurrencyFormater.withSuffix(doubleValue);
        });
      }else{
        setState(() {
          _textEditingController.text = 'InvalidNum';
        });
      }
    } else if (identical(_actionKey, _minusKey)) {
        if(lastValue.toInt() >= Constants.KILO.toInt()) {
          doubleValue = Math.subtract(
            double.parse(convertToString(_currentValues)), lastValue,);
          value = validateDouble(doubleValue);
          print('Value after conversion : $value');
          _currentValues.clear();
          _currentValues = convertToList(value);
          _actionKey = null;
          setState(() {
            widget.monopoly[cardIndex].totalAmount =
                double.parse(convertToString(_currentValues));
            _textEditingController.text = CurrencyFormater.withSuffix(
                double.parse(convertToString(_currentValues)));
          });
        }else{
          setState(() {
            _textEditingController.text = 'InvalidNum';
          });
        }
    } else if (identical(_actionKey, _multiplyKey)) {
      doubleValue = Math.multiply(
          lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = CurrencyFormater.withSuffix(double.parse(convertToString(_currentValues)));
      });
    } else if (identical(_actionKey, _divideKey)) {
      doubleValue =
          Math.divide(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    }
  }

  String convertToString(List values) {
    String val = '';
    print(_currentValues);
    for (int i = 0; i < values.length; i++) {
      val += _currentValues[i];
    }
    return val;
  }

  List convertToList(String value) {
    List list = new List();
    for (int i = 0; i < value.length; i++) {
      list.add(String.fromCharCode(value.codeUnitAt(i)));
    }
    return list;
  }

  KeyItem buildKeyItem(String val, Key key, int cardIndex, Color color) {
    return KeyItem(
      key: key,
      color: color,
      index: cardIndex,
      child: Text(
        val,
        style: TextStyle(
          color: Colors.grey,
          fontFamily: 'Avenir',
          fontStyle: FontStyle.normal,
          fontSize: 40.0,
        ),
      ),
      onKeyTap: onKeyTapped,
    );
  }

  Widget _buildPayCard(List<Monopoly> monopoly, int debitCardIndex, int creditCardIndex, Key cardKey) {
    return KeyItem(
      key: cardKey,
      index: debitCardIndex,
      onKeyTap: onKeyTapped,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: monopoly[creditCardIndex].color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ]),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: monopoly[creditCardIndex].color,
                    ),
                    height: 75.0,
                    width: 75.0,
                  )
                ],
              ),
            ),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 2, 0, 0),
              child: RichText(
                  text: TextSpan(
                      // set the default style for the children TextSpans
                      children: [
                    TextSpan(
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.black),
                        children: <InlineSpan>[
                          TextSpan(
                              text:
                                  '${widget.monopoly[creditCardIndex].name}'),
                        ]),
                  ])),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _buildDescription(List<Monopoly> monopoly) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    debugPrint('Width :: $width and Height :: $height');
    return Container(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    height: (height / 300) * 20,
                    child: IgnorePointer(
                      child: TextField(
                        enabled: true,
                        autofocus: true,
                        controller: _textEditingController,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 60.0,
                        ),
                        decoration: InputDecoration.collapsed(
                            hintText: '0',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 50.0)),
                      ),
                    ),
                  ),
                ]),
            Divider(
              color: widget.monopoly[widget.card.index].color,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              color: CupertinoColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildKeyItem('7', _sevenKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                      buildKeyItem('8', _eightKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                      buildKeyItem('9', _nineKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildKeyItem('4', _fourKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                      buildKeyItem('5', _fiveKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                      buildKeyItem(
                          '6', _sixKey, widget.card.index, widget.monopoly[widget.card.index].color),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildKeyItem(
                          '1', _oneKey, widget.card.index, widget.monopoly[widget.card.index].color),
                      buildKeyItem(
                          '2', _twoKey, widget.card.index, widget.monopoly[widget.card.index].color),
                      buildKeyItem('3', _threeKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildKeyItem(
                          '.', _dotKey, widget.card.index, widget.monopoly[widget.card.index].color),
                      buildKeyItem('0', _zeroKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                      buildKeyItem('C', _allClearKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildKeyItem('M', _millionKey, widget.card.index,
                          widget.monopoly[widget.card.index].color),
                      buildKeyItem(
                          'K', _kiloKey, widget.card.index, widget.monopoly[widget.card.index].color),
                      buildActionButton("Pay", _minusKey,
                          widget.monopoly[widget.card.index].color),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: widget.monopoly[widget.card.index].color,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildPayCard(
                    monopoly,
                    widget.card.index,
                    (MonopolyCard.PLAYER_RED.index == widget.card.index) ? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_RED.index,
                    (MonopolyCard.PLAYER_RED.index == widget.card.index) ? _blackCardKey : _redCardKey),
                _buildPayCard(
                    monopoly,
                    widget.card.index,
                    (MonopolyCard.PLAYER_BLUE.index == widget.card.index)? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_BLUE.index,
                    (MonopolyCard.PLAYER_BLUE.index == widget.card.index)? _blackCardKey : _blueCardKey),
                _buildPayCard(
                    monopoly,
                    widget.card.index,
                    (MonopolyCard.PLAYER_GREEN.index == widget.card.index) ? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_GREEN.index,
                    (MonopolyCard.PLAYER_GREEN.index == widget.card.index) ? _blackCardKey : _greenCardKey),
                _buildPayCard(
                    monopoly,
                    widget.card.index,
                    (MonopolyCard.PLAYER_YELLOW.index == widget.card.index) ? MonopolyCard.BANKER.index : MonopolyCard.PLAYER_YELLOW.index,
                    (MonopolyCard.PLAYER_YELLOW.index == widget.card.index) ? _blackCardKey : _yellowCardKey),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  ActionButton buildActionButton(String name, Key key, Color color) {
    return ActionButton(
      key: key,
      actionName: name,
      onTapped: onActionTapped,
      enabled: identical(_actionKey, key) ? true : false,
      //padding: height > 100 ? EdgeInsets.all(10.0) : EdgeInsets.all(0.0),
      changedBackground: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: widget.monopoly[widget.card.index].color,
                  ),
                ),
                Column(
                  children: <Widget>[
                    _buildHeader(context),
                    _buildMonopolyInfo(),
                    Container(
                      height: 35.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                //_buildPlantImage(context),
                //_buildWaterButton(context),
                //_buildAlerts(context),
                //_buildPlantImage(context),
              ],
            ),
            _buildDescription(widget.monopoly),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  ActionButton(
      {@required this.actionName,
      this.onTapped,
      this.enabled,
      this.key,
      this.padding,
      this.changedBackground})
      : super(key: key);

  final String actionName;
  final Color changedBackground;
  final Color changedForeground = Colors.white;
  final Color defaultBackground = Colors.transparent;
  final Color defaultForeground = Colors.grey;
  final bool enabled;
  final Key key;
  final ActionCallBack onTapped;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.all(0.0),
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            onTapped(key);
          },
          child: CircleAvatar(
            backgroundColor: enabled ? changedBackground : defaultBackground,
            radius: 30,
            child: Text(
              actionName,
              style: TextStyle(
                  color: enabled ? changedForeground : defaultForeground,
                  fontSize: 25.0,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class KeyItem extends StatelessWidget {
  KeyItem({@required this.child, this.key, this.index, this.onKeyTap, this.color});

  final Widget child;
  final Color color;
  final int index;
  final Key key;
  final KeyCallBack onKeyTap;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          splashColor: color,
          highlightColor: Colors.white,
          onTap: () => onKeyTap(key, index),
          child: Container(
            //color: Colors.white,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class Math {
  static double add(double val1, val2) {
    return val1 + val2;
  }

  static double subtract(double val1, val2) {
    return val1 - val2;
  }

  static double multiply(double val1, double val2) {
    return val1 * val2;
  }

  static double divide(double val1, double val2) {
    return val1 / val2;
  }
}
