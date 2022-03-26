import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/template/default_template.dart';

abstract class ContentTemplate extends GetView<ScreenLayoutController> {
  ContentTemplate({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  FloatingActionButton? floatingActionButton();

  /// View Custom Detail
  List<Widget> customDetail();

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      mainContents: Obx(
        () {
          switch (controller.type.value) {
            case ScreenSizeType.MOBILE:
              return _mobileLayout();
            case ScreenSizeType.TABLET:
            case ScreenSizeType.DESKTOP:
              return _desktopLayout();
          }
        },
      ),
    );
  }

  /// Page Scaffold State
  Widget _contentsDetail() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: customDetail()
            ..add(
              const SizedBox(
                height: 80,
              ),
            ),
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return Scaffold(
      body: _contentsDetail(),
      floatingActionButton: floatingActionButton(),
    );
  }

  Widget _desktopLayout() {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: _contentsDetail(),
      ),
    );
  }
}
