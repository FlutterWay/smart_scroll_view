import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_scroll_view/smart_scroll_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SmartScrollViewExample(),
    );
  }
}

class SmartScrollViewExample extends StatefulWidget {
  const SmartScrollViewExample({super.key});

  @override
  State<SmartScrollViewExample> createState() => _SmartScrollViewExampleState();
}

class _SmartScrollViewExampleState extends State<SmartScrollViewExample> {
  var controller = EasyRefreshController();
  Color firstColor = const Color(0xFF1a1c19);
  Color secondaryColor = const Color(0xFF424940);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartScrollView(
        backgroundColor: firstColor,
        listPadding: const EdgeInsets.symmetric(horizontal: 5),
        refreshProperties: refreshProperties,
        headerProperties: headerProperties,
        secondHeaderProperties: secondHeaderProperties,
        itemHeight: 110,
        shadowProperties: null,
        scrollUpButtonProperties: ScrollUpButtonProperties(),
        onScrollIndexChange: (index) {
          if (kDebugMode) {
            print(index);
          }
        },
        builder: (context, index) => itemView(index),
        childCount: 30,
      ),
    );
  }

  Widget itemView(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: secondaryColor,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(children: [
          Container(
            height: 80,
            width: 80,
            color: firstColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 15,
                  width: 160,
                  color: firstColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  height: 15,
                  width: 80,
                  color: firstColor,
                ),
              ),
              Container(
                height: 15,
                width: 80,
                color: firstColor,
              ),
            ],
          )
        ]),
      ),
    );
  }

  RefreshProperties get refreshProperties => RefreshProperties(
      controller: controller,
      header: const RefreshHeaderProperties(
        refreshView: CupertinoActivityIndicator(
          color: Colors.white,
        ),
        idleView: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
            Text(
              "Pull down to refresh!",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        failedView: Text(
          "Load Failed! Click retry!",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
        ),
        completedView: Text(
          "Done!",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        //controller.finishRefresh();
      });

  HeaderProperties get headerProperties => HeaderProperties(
        child: const Center(
          child: Text(
            "Smart Scroll View",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        height: 150,
        backgroundColor: Colors.black,
      );

  SecondHeaderProperties get secondHeaderProperties => SecondHeaderProperties(
      child: const Center(
        child: Text(
          "Smart Scroll View",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      height: 150,
      shadowColor: secondaryColor.withOpacity(0.4),
      backgroundColor: secondaryColor.withOpacity(0.95));
}
