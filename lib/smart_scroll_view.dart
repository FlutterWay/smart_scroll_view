library smart_scroll_view;

import 'dart:ui';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_scroll_view/model/header_properties.dart';
import 'package:smart_scroll_view/model/refresh_properties.dart';
import 'package:smart_scroll_view/model/second_header_properties.dart';
import 'package:smart_scroll_view/model/service_status_views.dart';

import '../../../model/service_status.dart';
import 'model/scroll_up_button_property.dart';
import 'model/smart_scroll_view_model.dart';
import 'view/reload_service_button.dart';
import 'view/shadow_properties.dart';

export 'package:easy_refresh/easy_refresh.dart';

export 'model/header_button_property.dart';
export 'model/header_properties.dart';
export 'model/refresh_header_property.dart';
export 'model/refresh_properties.dart';
export 'model/scroll_up_button_property.dart';
export 'model/second_header_properties.dart';
export 'model/service_status.dart';
export 'model/service_status_views.dart';

class SmartScrollView extends StatefulWidget {
  final double? itemHeight;
  final Duration headerAnimateDuration;
  final HeaderProperties? headerProperties;
  final Widget? bottomWidget;
  final ScrollController? controller;
  final ServiceStatusViews? serviceStatusViews;
  final void Function()? onLoading;
  final void Function()? onReload;
  final SecondHeaderProperties? secondHeaderProperties;
  final ScrollUpButtonProperties? scrollUpButtonProperties;
  final Function(int index)? onScrollIndexChange;
  final EdgeInsetsGeometry listPadding;
  final ServiceStatus? serviceStatus;
  final RefreshProperties? refreshProperties;
  final int? floatActionButtonIndex;
  final ShadowProperties? shadowProperties;
  final FloatingActionButton? floatActionButton;
  final Widget? Function(BuildContext, int) builder;
  final int childCount;
  final Color? backgroundColor;
  const SmartScrollView({
    super.key,
    required this.builder,
    required this.childCount,
    this.itemHeight,
    this.refreshProperties,
    this.scrollUpButtonProperties,
    this.controller,
    this.onScrollIndexChange,
    this.floatActionButtonIndex,
    this.backgroundColor,
    this.bottomWidget,
    this.onLoading,
    this.serviceStatusViews,
    this.floatActionButton,
    this.shadowProperties = const ShadowProperties(),
    this.onReload,
    this.secondHeaderProperties,
    this.listPadding = EdgeInsets.zero,
    this.serviceStatus,
    this.headerProperties,
    this.headerAnimateDuration = const Duration(milliseconds: 300),
  });

  @override
  State<SmartScrollView> createState() => _SmartScrollViewState();
}

class _SmartScrollViewState extends State<SmartScrollView> {
  late ScrollController _scrollController;
  double scrollPosition = 0;
  double toolbarHeight = 0;
  double toolbarCurrentHeight = -1;
  bool modelInitialized = false;

  SmartScrollViewModel model = SmartScrollViewModel();

  @override
  void initState() {
    model.onScrollIndexChange = widget.onScrollIndexChange;
    super.initState();
  }

  void initModel() {
    model.init(widget.itemHeight, widget.floatActionButtonIndex);
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(listenScroll);
    modelInitialized = true;
  }

  @override
  void dispose() {
    _scrollController.removeListener(listenScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void listenScroll() {
    double currentPosition = _scrollController.position.pixels;
    model.updateScrollPosition(currentPosition);
    if (toolbarCurrentHeight == -1) {
      toolbarCurrentHeight = toolbarHeight;
    }
    if (currentPosition < scrollPosition) {
      if (toolbarCurrentHeight < toolbarHeight) {
        toolbarCurrentHeight += scrollPosition - currentPosition;
      }
      scrollPosition = _scrollController.position.pixels;
    } else {
      if (toolbarCurrentHeight > 0) {
        toolbarCurrentHeight -= currentPosition - scrollPosition;
      }
      scrollPosition = _scrollController.position.pixels;
    }
  }

  @override
  Widget build(BuildContext context) {
    model.itemHeight = widget.itemHeight;
    model.headerHeight =
        widget.headerProperties == null ? 0 : widget.headerProperties!.height;
    model.totalHeight = MediaQuery.of(context).size.height;
    if (!modelInitialized) {
      initModel();
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          widget.refreshProperties != null
              ? EasyRefresh(
                  controller: widget.refreshProperties!.controller,
                  onRefresh: widget.refreshProperties!.onRefresh,
                  header: BuilderHeader(
                      builder: (context, state) {
                        Widget? child;
                        if (state.mode == IndicatorMode.processing) {
                          child = widget.refreshProperties!.header.refreshView;
                        } else if (state.mode == IndicatorMode.drag) {
                          child = Opacity(
                              opacity: model.refreshAreaOpacity,
                              child: widget.refreshProperties!.header.idleView);
                        } else if (state.mode == IndicatorMode.done &&
                            state.result == IndicatorResult.success) {
                          child =
                              widget.refreshProperties!.header.completedView;
                        } else if (state.mode == IndicatorMode.done &&
                            state.result == IndicatorResult.fail) {
                          child = widget.refreshProperties!.header.failedView;
                        }
                        return Container(
                          height: widget.refreshProperties!.header.height,
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                      triggerOffset: widget.refreshProperties!.header.height,
                      maxOverOffset: widget.refreshProperties!.header.height,
                      clamping: false,
                      processedDuration: Duration.zero,
                      position: IndicatorPosition.locator),
                  child: viewBody(),
                )
              : viewBody(),
          if (widget.secondHeaderProperties != null) secondHeaderView(),
          if (widget.floatActionButtonIndex != null) viewFloatActionButton(),
          if (widget.shadowProperties != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: widget.shadowProperties!.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.shadowProperties!.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: widget.shadowProperties!.blurRadius,
                        spreadRadius: widget.shadowProperties!.spreadRadius,
                        color: widget.shadowProperties!.color,
                        offset: widget.shadowProperties!.offset)
                  ],
                ),
              ),
            ),
          if (widget.bottomWidget != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: widget.bottomWidget,
            ),
          if (widget.scrollUpButtonProperties != null) scrollUpButton(),
        ],
      );
    });
  }

  Widget scrollUpButton() {
    return Observer(builder: (context) {
      return Align(
        alignment: Alignment.topCenter,
        child: AnimatedPadding(
          padding: EdgeInsets.only(
              top: model.viewScrollUp
                  ? widget.scrollUpButtonProperties!.endPosition
                  : widget.scrollUpButtonProperties!.initialPosition),
          duration: widget.scrollUpButtonProperties!.duration,
          child: AnimatedOpacity(
            duration: widget.scrollUpButtonProperties!.duration,
            opacity: model.viewScrollUp ? 1 : 0,
            child: TextButton(
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(seconds: 1), curve: Curves.easeIn);
              },
              child: widget.scrollUpButtonProperties!.child,
            ),
          ),
        ),
      );
    });
  }

  Widget viewBody() {
    return Container(
      color: widget.backgroundColor,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (widget.headerProperties != null)
            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              child: SliverAppBar(
                leading: null,
                floating: true,
                automaticallyImplyLeading: false,
                toolbarHeight: widget.headerProperties!.height,
                flexibleSpace: Observer(builder: (context) {
                  return FlexibleSpaceBar(
                    background: Opacity(
                      opacity: model.headerOpacity,
                      child: widget.headerProperties!.child,
                    ),
                  );
                }),
                backgroundColor: widget.headerProperties!.backgroundColor,
                expandedHeight: widget.headerProperties!.height,
              ),
            ),
          const HeaderLocator.sliver(),
          serviceView(),
        ],
      ),
    );
  }

  Widget serviceView() {
    return switch (widget.serviceStatus) {
      ServiceStatus.success => successView(),
      ServiceStatus.onProcess => onProcessView(),
      ServiceStatus.waiting => onProcessView(),
      ServiceStatus.failed => failedView(),
      null => successView()
    };
  }

  Widget successView() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(widget.builder,
            childCount: widget.childCount));
  }

  Widget viewFloatActionButton() {
    return Positioned(
      bottom: 50,
      right: 23,
      child: Observer(builder: (context) {
        return AnimatedOpacity(
          opacity: model.viewFloatAction ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: widget.floatActionButton,
        );
      }),
    );
  }

  Widget secondHeaderView() {
    return Observer(builder: (context) {
      return Opacity(
        opacity: (1 - model.headerOpacity),
        child: SizedBox(
          height:
              widget.secondHeaderProperties!.height * (1 - model.headerOpacity),
          child: Stack(
            children: [
              if (widget.secondHeaderProperties!.blurPx != null)
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: widget.secondHeaderProperties!.blurPx!,
                        sigmaY: widget.secondHeaderProperties!.blurPx!),
                    child: const SizedBox(
                        width: double.infinity, height: double.infinity),
                  ),
                ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: widget.secondHeaderProperties!.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                        blurRadius: 10,
                        color: widget.secondHeaderProperties!.shadowColor)
                  ],
                ),
              ),
              widget.secondHeaderProperties!.child,
            ],
          ),
        ),
      );
    });
  }

  Widget failedView() {
    return SizedBox(
      height: model.totalHeight! - model.headerHeight,
      width: double.infinity,
      child: Center(
        child: ReloadServiceButton(
          onPressed: () => widget.onReload,
        ),
      ),
    );
  }

  Widget onProcessView() {
    return Center(
      child: SizedBox(
        height: model.totalHeight! - model.headerHeight,
        width: double.infinity,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
