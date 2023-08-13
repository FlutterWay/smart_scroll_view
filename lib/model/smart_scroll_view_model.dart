// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import 'service_status.dart';

part 'smart_scroll_view_model.g.dart';

class SmartScrollViewModel = _SmartScrollViewModelBase
    with _$SmartScrollViewModel;

abstract class _SmartScrollViewModelBase with Store {
  @observable
  bool showSecondHeader = false;

  @observable
  double lastItemIndex = 7;

  double? itemHeight;
  double? totalHeight;
  late double headerHeight;
  double lastPosition = 0;
  double increasedScrollPosition = 0;
  double decreasedScrollPosition = 0;
  double decreasedScrollPositionTotal = 0;

  Function(int index)? onScrollIndexChange;

  int? floatActionButtonIndex;

  @observable
  ServiceStatus serviceStatus = ServiceStatus.waiting;

  @observable
  bool viewFloatAction = false;

  @observable
  bool showToolbar = true;

  @observable
  double refreshAreaOpacity = 0;

  @observable
  double headerOpacity = 1.0;

  @observable
  bool viewScrollUp = false;

  @observable
  bool test = false;

  void init(double? itemHeight, int? floatActionButtonIndex) {
    this.floatActionButtonIndex = floatActionButtonIndex;
    this.itemHeight = itemHeight;
    calculateIndex(0);
  }

  @action
  void calculateIndex(double currentPosition) {
    if (itemHeight != null) {
      double index =
          (((totalHeight! - headerHeight) + currentPosition) / itemHeight!)
              .abs();
      if (onScrollIndexChange != null &&
          index.toInt() != lastItemIndex.toInt()) {
        onScrollIndexChange!(index.toInt());
      }
      lastItemIndex = index;
      if (floatActionButtonIndex != null) {
        viewFloatAction =
            lastItemIndex >= floatActionButtonIndex! ? true : false;
      }
    }
  }

  @action
  void updateScrollPosition(double currentPosition) {
    if (currentPosition > 100 && !viewScrollUp) {
      viewScrollUp = true;
    } else if (currentPosition <= 100 && viewScrollUp) {
      viewScrollUp = false;
    }
    refreshAreaOpacity = currentPosition.abs() / headerHeight;
    if (currentPosition > 0) {
      if (currentPosition > lastPosition) {
        decreasedScrollPosition = 0;
        increasedScrollPosition = currentPosition - lastPosition;

        double newOpacity =
            headerOpacity - (increasedScrollPosition / (headerHeight * 0.7));
        if (newOpacity >= 0) {
          headerOpacity = newOpacity;
        } else if (newOpacity < 0 && headerOpacity > 0) {
          headerOpacity = 0;
        }
        if (headerOpacity == 0 && !showSecondHeader) {
          showSecondHeader = true;
        }
      } else {
        increasedScrollPosition = 0;
        decreasedScrollPosition = lastPosition - currentPosition;
        decreasedScrollPositionTotal += lastPosition - currentPosition;

        double newOpacity =
            headerOpacity + (decreasedScrollPosition / (headerHeight * 0.7));
        if (newOpacity <= 1) {
          headerOpacity = newOpacity;
        } else if (newOpacity > 1 && headerOpacity < 1) {
          headerOpacity = 1;
        }
        if (headerOpacity > 0.3 && showSecondHeader) {
          showSecondHeader = false;
        }
      }
      lastPosition = currentPosition;
      calculateIndex(currentPosition);
    }
  }
}
