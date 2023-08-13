import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_scroll_view/model/refresh_header_property.dart';

class RefreshHeader extends StatelessWidget {
  final Function() onRetry;
  final RefreshHeaderProperties properties;
  const RefreshHeader(
      {super.key, required this.onRetry, required this.properties});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (context, mode) {
        {
          Widget body;
          if (mode == RefreshStatus.refreshing) {
            body = properties.refreshView == null
                ? const SizedBox()
                : properties.textStyle != null
                    ? CupertinoActivityIndicator(
                        color: properties.textStyle!.color,
                      )
                    : properties.refreshView!;
          } else if (mode == RefreshStatus.failed) {
            body = properties.failedView == null
                ? const SizedBox()
                : TextButton(
                    onPressed: onRetry,
                    child: properties.textStyle != null
                        ? Text(
                            "Load Failed! Click retry!",
                            style: properties.textStyle!,
                          )
                        : properties.failedView!,
                  );
          } else if (mode == RefreshStatus.idle) {
            body = properties.idleView == null
                ? const SizedBox()
                : properties.textStyle != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: properties.textStyle!.color,
                          ),
                          Text(
                            "Pull down to refresh!",
                            style: properties.textStyle!,
                          )
                        ],
                      )
                    : properties.idleView!;
          } else if (mode == RefreshStatus.completed) {
            body = properties.completedView == null
                ? const SizedBox()
                : properties.textStyle != null
                    ? Text(
                        "Done!",
                        style: properties.textStyle,
                      )
                    : properties.completedView!;
          } else {
            body = const SizedBox();
          }
          return SizedBox(
            height: properties.height,
            child: Center(child: body),
          );
        }
      },
    );
  }
}
