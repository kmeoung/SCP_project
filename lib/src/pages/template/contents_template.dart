import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/template/default_template.dart';

abstract class ContentTemplate extends GetView<ScreenLayoutController> {
  final String _userId;
  ContentTemplate(this._userId, {Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  FloatingActionButton? floatingActionButton();

  /// View Custom Detail
  List<Widget> customDetail(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Get.back();
        }
        return Future.value(false);
      },
      child: DefaultTemplate(
        _userId,
        mainContents: Obx(
          () {
            switch (controller.type.value) {
              case ScreenSizeType.MOBILE:
                return _mobileLayout(context);
              case ScreenSizeType.TABLET:
              case ScreenSizeType.DESKTOP:
                return _desktopLayout(context);
            }
          },
        ),
      ),
    );
  }

  /// Page Scaffold State
  Widget _contentsDetail(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: customDetail(context)
            ..add(
              const SizedBox(
                height: 80,
              ),
            ),
        ),
      ),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Scaffold(
      body: _contentsDetail(context),
      floatingActionButton: floatingActionButton(),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: _contentsDetail(context),
      ),
    );
  }
}
