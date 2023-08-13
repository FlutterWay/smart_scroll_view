import 'package:flutter/material.dart';

class ShadowProperties {
  final double height;
  final Offset offset;
  final double blurRadius, spreadRadius;
  final Color color;
  final Color? backgroundColor;

  const ShadowProperties({
    double? height,
    this.offset = const Offset(0, 0),
    this.blurRadius = 4,
    this.spreadRadius = 0,
    this.backgroundColor,
    this.color = const Color.fromRGBO(27, 28, 36, 0.60),
  }) : height = height ?? 40;
}
