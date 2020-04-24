import 'package:flutter/material.dart';

typedef KeyCallBack = void Function(Key key, int index);

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