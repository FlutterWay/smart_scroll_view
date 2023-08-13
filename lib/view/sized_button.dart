import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double borderWith;
  final Color? borderColor;
  final Color? color;
  final Alignment alignment;
  final Function() onPressed;
  final double? width, height;
  final bool isCircle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry innerPadding;
  final LinearGradient? linearGradient;
  final List<BoxShadow>? boxShadow;
  const SizedButton(
      {super.key,
      this.child,
      this.radius = 10,
      this.alignment = Alignment.center,
      this.borderColor,
      this.color,
      this.linearGradient,
      this.isCircle = false,
      this.boxShadow,
      required this.width,
      required this.height,
      this.borderWith = 1,
      this.padding = EdgeInsets.zero,
      this.innerPadding = EdgeInsets.zero,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    BoxBorder? border = borderColor != null
        ? Border.all(width: borderWith, color: borderColor!)
        : null;
    BoxDecoration decoration = isCircle
        ? BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border,
            boxShadow: boxShadow,
            gradient: linearGradient,
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: linearGradient,
            color: color,
            boxShadow: boxShadow,
            border: border);
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: padding,
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onPressed,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: alignment,
            decoration: decoration,
            padding: innerPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
