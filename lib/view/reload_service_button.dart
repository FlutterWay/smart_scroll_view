import 'package:flutter/material.dart';

import 'sized_button.dart';

class ReloadServiceButton extends StatelessWidget {
  final dynamic Function() onPressed;
  const ReloadServiceButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedButton(
      width: 150,
      height: 60,
      onPressed: () {
        onPressed();
      },
      color: Colors.blueAccent,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Reload Service",
              style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.repeat,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
