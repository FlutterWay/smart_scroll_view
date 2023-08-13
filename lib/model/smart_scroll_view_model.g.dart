// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_scroll_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmartScrollViewModel on _SmartScrollViewModelBase, Store {
  late final _$showSecondHeaderAtom = Atom(
      name: '_SmartScrollViewModelBase.showSecondHeader', context: context);

  @override
  bool get showSecondHeader {
    _$showSecondHeaderAtom.reportRead();
    return super.showSecondHeader;
  }

  @override
  set showSecondHeader(bool value) {
    _$showSecondHeaderAtom.reportWrite(value, super.showSecondHeader, () {
      super.showSecondHeader = value;
    });
  }

  late final _$lastItemIndexAtom =
      Atom(name: '_SmartScrollViewModelBase.lastItemIndex', context: context);

  @override
  double get lastItemIndex {
    _$lastItemIndexAtom.reportRead();
    return super.lastItemIndex;
  }

  @override
  set lastItemIndex(double value) {
    _$lastItemIndexAtom.reportWrite(value, super.lastItemIndex, () {
      super.lastItemIndex = value;
    });
  }

  late final _$serviceStatusAtom =
      Atom(name: '_SmartScrollViewModelBase.serviceStatus', context: context);

  @override
  ServiceStatus get serviceStatus {
    _$serviceStatusAtom.reportRead();
    return super.serviceStatus;
  }

  @override
  set serviceStatus(ServiceStatus value) {
    _$serviceStatusAtom.reportWrite(value, super.serviceStatus, () {
      super.serviceStatus = value;
    });
  }

  late final _$viewFloatActionAtom =
      Atom(name: '_SmartScrollViewModelBase.viewFloatAction', context: context);

  @override
  bool get viewFloatAction {
    _$viewFloatActionAtom.reportRead();
    return super.viewFloatAction;
  }

  @override
  set viewFloatAction(bool value) {
    _$viewFloatActionAtom.reportWrite(value, super.viewFloatAction, () {
      super.viewFloatAction = value;
    });
  }

  late final _$showToolbarAtom =
      Atom(name: '_SmartScrollViewModelBase.showToolbar', context: context);

  @override
  bool get showToolbar {
    _$showToolbarAtom.reportRead();
    return super.showToolbar;
  }

  @override
  set showToolbar(bool value) {
    _$showToolbarAtom.reportWrite(value, super.showToolbar, () {
      super.showToolbar = value;
    });
  }

  late final _$refreshAreaOpacityAtom = Atom(
      name: '_SmartScrollViewModelBase.refreshAreaOpacity', context: context);

  @override
  double get refreshAreaOpacity {
    _$refreshAreaOpacityAtom.reportRead();
    return super.refreshAreaOpacity;
  }

  @override
  set refreshAreaOpacity(double value) {
    _$refreshAreaOpacityAtom.reportWrite(value, super.refreshAreaOpacity, () {
      super.refreshAreaOpacity = value;
    });
  }

  late final _$headerOpacityAtom =
      Atom(name: '_SmartScrollViewModelBase.headerOpacity', context: context);

  @override
  double get headerOpacity {
    _$headerOpacityAtom.reportRead();
    return super.headerOpacity;
  }

  @override
  set headerOpacity(double value) {
    _$headerOpacityAtom.reportWrite(value, super.headerOpacity, () {
      super.headerOpacity = value;
    });
  }

  late final _$viewScrollUpAtom =
      Atom(name: '_SmartScrollViewModelBase.viewScrollUp', context: context);

  @override
  bool get viewScrollUp {
    _$viewScrollUpAtom.reportRead();
    return super.viewScrollUp;
  }

  @override
  set viewScrollUp(bool value) {
    _$viewScrollUpAtom.reportWrite(value, super.viewScrollUp, () {
      super.viewScrollUp = value;
    });
  }

  late final _$testAtom =
      Atom(name: '_SmartScrollViewModelBase.test', context: context);

  @override
  bool get test {
    _$testAtom.reportRead();
    return super.test;
  }

  @override
  set test(bool value) {
    _$testAtom.reportWrite(value, super.test, () {
      super.test = value;
    });
  }

  late final _$_SmartScrollViewModelBaseActionController =
      ActionController(name: '_SmartScrollViewModelBase', context: context);

  @override
  void calculateIndex(double currentPosition) {
    final _$actionInfo = _$_SmartScrollViewModelBaseActionController
        .startAction(name: '_SmartScrollViewModelBase.calculateIndex');
    try {
      return super.calculateIndex(currentPosition);
    } finally {
      _$_SmartScrollViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateScrollPosition(double currentPosition) {
    final _$actionInfo = _$_SmartScrollViewModelBaseActionController
        .startAction(name: '_SmartScrollViewModelBase.updateScrollPosition');
    try {
      return super.updateScrollPosition(currentPosition);
    } finally {
      _$_SmartScrollViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showSecondHeader: ${showSecondHeader},
lastItemIndex: ${lastItemIndex},
serviceStatus: ${serviceStatus},
viewFloatAction: ${viewFloatAction},
showToolbar: ${showToolbar},
refreshAreaOpacity: ${refreshAreaOpacity},
headerOpacity: ${headerOpacity},
viewScrollUp: ${viewScrollUp},
test: ${test}
    ''';
  }
}
