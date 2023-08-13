import 'package:flutter/material.dart';

class SecondHeaderProperties {
  final Widget child;
  final Color? backgroundColor;
  final Color shadowColor;
  final double? blurPx;
  final double height;

  const SecondHeaderProperties({
    required this.child,
    this.height = 96,
    this.backgroundColor = const Color.fromRGBO(224, 224, 224, 1),
    this.shadowColor = const Color.fromRGBO(189, 189, 189, 1),
    this.blurPx = 1,
  });
}
