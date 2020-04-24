import 'package:flutter/material.dart';

typedef ActionCallBack = void Function(Key key);

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
