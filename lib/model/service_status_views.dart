import 'package:flutter/material.dart';

class ServiceStatusViews {
  final Widget? onProcessView;
  final Widget? onFailedView;
  final Widget? waitingView;

  ServiceStatusViews({this.onProcessView, this.waitingView, this.onFailedView});
}
