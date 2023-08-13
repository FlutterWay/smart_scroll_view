import 'package:flutter/material.dart';

class ScrollUpButtonProperties {
  double initialPosition, endPosition;
  Duration duration;
  Duration scrollUpDuration;
  Widget child;

  ScrollUpButtonProperties({
    this.initialPosition = 20,
    this.endPosition = 100,
    this.duration = const Duration(milliseconds: 300),
    this.scrollUpDuration = const Duration(seconds: 1),
    Widget? child,
  }) : child = child ??
            Container(
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.all(8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
                      size: 12,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Başa dön",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ));
}
