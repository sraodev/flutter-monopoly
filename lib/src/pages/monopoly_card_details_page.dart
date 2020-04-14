import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoly/colors.dart' as AppColors;
import 'package:monopoly/src/models/plant.dart';
import 'package:monopoly/src/pages/home_page.dart';
import 'package:monopoly/src/widgets/custom_icons_icons.dart';
import 'package:monopoly/src/widgets/description_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:monopoly/src/widgets/monopoly_icon_icons.dart';

typedef ActionCallBack = void Function(Key key);
typedef KeyCallBack = void Function(Key key);

const Color primaryColor = const Color(0xff50E3C2);
const Color keypadColor = const Color(0xff4A4A4A);

class MonopolyCardDetailPage extends StatefulWidget {
  MonopolyCardDetailPage(this.plants, this.card);

  Monopoly card;
  final List<Plant> plants;

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
  bool _button_status = false;
  Key _clearKey = Key('clear');
  List _currentValues = List();
  Key _divideKey = Key('divide');
  Key _dotKey = Key('dot');
  Key _eightKey = Key('eight');
  Key _equalsKey = Key('equals');
  Key _fiveKey = Key('five');
  Key _fourKey = Key('four');
  Key _minusKey = Key('minus');
  Key _multiplyKey = Key('multiply');
  Key _nineKey = Key('nine');
  Key _oneKey = Key('one');
  Key _plusKey = Key('plus');
  Key _sevenKey = Key('seven');
  Key _sixKey = Key('six');
  TextEditingController _textEditingController;
  Key _threeKey = Key('three');
  Key _twoKey = Key('two');
  Key _zeroKey = Key('zero');

  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  Widget _buildWaterButton(context) {
    return Center(
        child: Container(
      padding: EdgeInsets.only(top: 395),
      child: GestureDetector(
        child: Container(
          child: Stack(children: <Widget>[
            Container(
              alignment: FractionalOffset.center,
              height: 75.0,
              width: 75.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreen,
                      blurRadius: 5.0,
                    ),
                  ]),
            ),
            Positioned(
              left: 5,
              bottom: 5,
              child: Stack(children: <Widget>[
                Container(
                  height: 65.0,
                  width: 65.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: _button_status
                          ? Colors.lightGreen
                          : AppColors.mainColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.tint,
                      color: _button_status
                          ? AppColors.mainColor
                          : Colors.lightGreen,
                      //color: AppColors.mainColor,
                      size: 30.0,
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ),
        onTap: () {
          setState(() {
            if (_button_status) {
              _button_status = false;
              print("Watering button: OFF");
              databaseReference
                  .child("Plantify/Users/UID/Plants/PlantID/pumpState")
                  .set(_button_status);
            } else {
              _button_status = true;
              print("Watering button: ON");
              databaseReference
                  .child("Plantify/Users/UID/Plants/PlantID/pumpState")
                  .set(_button_status);
            }
          });
        },
      ),
    ));
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

  Widget _buildPlantInfo() {
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
                widget.plants[widget.card.index].name,
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
                                        text: ' ${widget.plants[widget.card.index].totalAmount.toDouble()}'),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      child: Text("M",
                                          style: TextStyle(
                                              fontSize: 45,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white38)),
                                    ),
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

  void onKeyTapped(Key key) {

    if (savedLastValue == false && lastValue != null) {
      _currentValues.clear();
      savedLastValue = true;
    }
    setState(() {
      if (identical(_sevenKey, key)) {
        _currentValues.add('7');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_eightKey, key)) {
        _currentValues.add('8');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_nineKey, key)) {
        _currentValues.add('9');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_fourKey, key)) {
        _currentValues.add('4');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_fiveKey, key)) {
        _currentValues.add('5');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_sixKey, key)) {
        _currentValues.add('6');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_oneKey, key)) {
        _currentValues.add('1');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_twoKey, key)) {
        _currentValues.add('2');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_threeKey, key)) {
        _currentValues.add('3');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_dotKey, key)) {
        if (!_currentValues.contains('.')) {
          _currentValues.add('.');
        }
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_zeroKey, key)) {
        _currentValues.add('0');
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_clearKey, key)) {
        print('Values :: $_currentValues');
        _currentValues.removeLast();
        _textEditingController.text = convertToString(_currentValues);
      } else if(identical(_allClearKey, key)) {
        _currentValues.clear();
        lastValue = null;
        savedLastValue = false;
        _textEditingController.clear();
      } else if (identical(_equalsKey, key)) {
        calculateValue();
        savedLastValue = false;
      }
    });
  }

  String validateDouble(double doubleValue) {
    int value;
    if (doubleValue % 1 == 0) {
      value = doubleValue.toInt();
    } else {
      return doubleValue.toStringAsFixed(1);
    }
    return value.toString();
  }

  void calculateValue() {
    String value;
    double doubleValue;
    if (identical(_actionKey, _plusKey)){
      doubleValue = Math.add(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      print('Value after conversion : $value');
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    } else if (identical(_actionKey, _minusKey)) {
      doubleValue = Math.subtract(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    } else if (identical(_actionKey, _multiplyKey)) {
      doubleValue = Math.multiply(lastValue, double.parse(convertToString(_currentValues)));
      value = validateDouble(doubleValue);
      _currentValues.clear();
      _currentValues = convertToList(value);
      _actionKey = null;
      setState(() {
        _textEditingController.text = value;
      });
    } else if (identical(_actionKey, _divideKey)) {
      doubleValue = Math.divide(lastValue, double.parse(convertToString(_currentValues)));
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
    for (int i = 0;i < values.length;i++) {
      val+=_currentValues[i];
    }
    return val;
  }

  List convertToList(String value) {
    List list = new List();
    for(int i = 0;i < value.length;i++) {
      list.add(String.fromCharCode(value.codeUnitAt(i)));
    }
    return list;
  }

  KeyItem buildKeyItem(String val, Key key) {
    return KeyItem(
      key: key,
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

  Widget _buildPayCard(List<Plant> plants, int cardIndex){
    return KeyItem(
        key: _equalsKey,
        onKeyTap: onKeyTapped,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: plants[cardIndex].color,
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
                  //color : AppColors.mainColor,
//                  color: (widget.showIndex == index)
//                      ? AppColors.mainColor
//                      : AppColors.secondColor,
                ),

                height: 70.0,
                width: 70.0,
              ),
              RichText(
                  text: TextSpan(
                    // set the default style for the children TextSpans
                      children: [
                        TextSpan(
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: ' ${widget.plants[cardIndex].light.toInt()}'),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                child: Text('%',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                            ]),
                      ])),
            ],
          ),
        )
    );
  }

  Widget _buildDescription(List<Plant> plants) {
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
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: <
                Widget>[
              Container(
                alignment: Alignment.center,
                width: width,
                height: (height/300)*20,
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
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 50.0
                        )
                    ),              ),
                ),
              ),
            ]),
            Divider(color: widget.plants[widget.card.index].color,),
//            Row(
//              children: <Widget>[
//                buildActionButton('+', _plusKey),
//                buildActionButton('-', _minusKey),
//                buildActionButton('x', _multiplyKey),
//                buildActionButton('/', _divideKey)
//              ],
//            ),
              Container(
                //padding: EdgeInsets.all(10.0),
                color: CupertinoColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('7', _sevenKey),
                          buildKeyItem('8',_eightKey),
                          buildKeyItem('9',_nineKey),
                        ],
                      ),
                    //Divider(color: widget.plant.color,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('4',_fourKey),
                          buildKeyItem('5',_fiveKey),
                          buildKeyItem('6',_sixKey),
                        ],
                      ),
                    //Divider(color: widget.plant.color,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('1',_oneKey),
                          buildKeyItem('2',_twoKey),
                          buildKeyItem('3',_threeKey),
                        ],
                      ),
                    //Divider(color: widget.plant.color,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('.',_dotKey),
                          buildKeyItem('0',_zeroKey),
                          buildKeyItem('C',_allClearKey),
//                          KeyItem(
//                            key: _clearKey,
//                            child: Icon(
//                              Icons.backspace,
//                              size: 10,
//                              color: keypadColor,
//                            ),
//                            onKeyTap: onKeyTapped,
//                          ),
                        ],
                      ),
                    //Divider(color: widget.plants[widget.card.index].color,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildKeyItem('M',_allClearKey),
                          buildKeyItem('K',Key('')),
                          buildActionButton("Pay", _plusKey),
                        ],
                      ),
                  ],
                ),
              ),
            Divider(color: widget.plants[widget.card.index].color,),
//            Row(crossAxisAlignment: CrossAxisAlignment.center, children: <
//                Widget>[
//              _buildPayCard(plants, (Monopoly.PLAYER_RED.index == widget.card.index)? 0 : Monopoly.PLAYER_RED.index),
//              _buildPayCard(plants, (Monopoly.PLAYER_GREEN.index == widget.card.index)? 0 : Monopoly.PLAYER_GREEN.index),
//              _buildPayCard(plants, (Monopoly.PLAYER_BLUE.index == widget.card.index)? 0 : Monopoly.PLAYER_BLUE.index),
//              _buildPayCard(plants, (Monopoly.PLAYER_YELLOW.index == widget.card.index)? 0 : Monopoly.PLAYER_YELLOW.index),
//            ]),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );

  }

  ActionButton buildActionButton(String name , Key key) {
    return ActionButton(
      key: key,
      actionName: name,
      onTapped: onActionTapped,
      enabled: identical(_actionKey, key) ? true : false,
      //padding: height > 100 ? EdgeInsets.all(10.0) : EdgeInsets.all(0.0),
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
                    color: widget.plants[widget.card.index].color,
                  ),
                ),
                Column(
                  children: <Widget>[
                    _buildHeader(context),
                    _buildPlantInfo(),
                    Container(
                      height: 40.0,
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
            _buildDescription(widget.plants),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  ActionButton({@required this.actionName,this.onTapped,this.enabled,this.key,this.padding}) : super(key : key);

  final String actionName;
  final Color changedBackground = primaryColor;
  final Color changedForeground = Colors.white;
  final Color defaultBackground = Colors.transparent;
  final Color defaultForeground = primaryColor;
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
        color: Color(0xffF6F6F6),
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
                  fontSize: 20.0,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KeyItem extends StatelessWidget {
  KeyItem({@required this.child,this.key,this.onKeyTap});

  final Widget child;
  final Key key;
  final KeyCallBack onKeyTap;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          splashColor: primaryColor,
          highlightColor: Colors.white,
          onTap: () => onKeyTap(key),
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
    return val1+val2;
  }

  static double subtract(double val1,val2) {
    return val1 - val2;
  }

  static double multiply(double val1, double val2) {
    return val1*val2;
  }

  static double divide(double val1, double val2) {
    return val1/val2;
  }
}