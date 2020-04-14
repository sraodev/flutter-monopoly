import 'package:flutter/material.dart';
import 'package:monopoly/colors.dart' as AppColors;

class ShoppingBasket extends StatelessWidget {
  ShoppingBasket({
    this.inverted = false,
  });

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 40.0,
          width: 40.0,
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: inverted
                        ? AppColors.secondColor.withAlpha(75)
                        : Colors.white.withAlpha(30),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 25.0,
                  ),
                ),
              ],

            ),
          ),
        ),

//        Positioned(
//          top: 5,
//          right: 5,
//          child: Container(
//            height: 20.0,
//            width: 20.0,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.all(Radius.circular(100.0)),
//              color: !inverted ? Colors.white : AppColors.mainColor,
//            ),
//            child: Center(
//              child: Text(
//                '0',
//                style: TextStyle(
//                  color: inverted ? Colors.white : AppColors.mainColor,
//                  fontSize: 10.0,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//
//            ),
//          ),
//        ),
      ],
    );
  }
}
