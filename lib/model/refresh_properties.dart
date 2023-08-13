import 'package:easy_refresh/easy_refresh.dart';
import 'package:smart_scroll_view/model/refresh_header_property.dart';

class RefreshProperties {
  final RefreshHeaderProperties header;
  final EasyRefreshController? controller;
  final void Function() onRefresh;

  RefreshProperties(
      {required this.header,
      required this.onRefresh,
      required this.controller});
}
