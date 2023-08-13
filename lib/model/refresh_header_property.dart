import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshHeaderProperties {
  final TextStyle? textStyle;
  final Widget? refreshView;
  final Widget? idleView;
  final Widget? failedView;
  final Widget? completedView;
  final double height;

  const RefreshHeaderProperties(
      {this.textStyle,
      this.height = 60,
      this.refreshView = const CupertinoActivityIndicator(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      this.idleView = const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_downward,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          Text(
            "Pull down to refresh!",
            style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400),
          )
        ],
      ),
      this.failedView = const Text(
        "Load Failed! Click retry!",
        style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400),
      ),
      this.completedView = const Text(
        "Done!",
        style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400),
      )});
}
