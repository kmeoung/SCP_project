import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/components/navigation_menu.dart';
import 'package:scp/src/components/right_menu.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';

/// View Template
class DefaultTemplate extends StatelessWidget {
  DefaultTemplate({Key? key, required this.mainContents}) : super(key: key);
  Widget mainContents;

  /// Page Scaffold State
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _contentView() {
    List<Widget> widgets = [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: mainContents,
      ))
    ];
    if (ScreenLayoutController.to.type.value != ScreenSizeType.MOBILE) {
      if (ScreenLayoutController.to.type.value == ScreenSizeType.DESKTOP) {
        widgets.add(RightMenu(
          width: 300,
        ));
      } else {
        widgets.add(RightMenu(
          width: 150,
        ));
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            ScreenLayoutController.to.builder(constraints);
            return Container();
          },
        ),
        Obx(
          () => Scaffold(
            key: _key,
            backgroundColor: CustomColors.beige,
            endDrawer: ScreenLayoutController.to.type.value ==
                    ScreenSizeType.MOBILE
                ? Container(
                    width: Get.size.width * 0.6,
                    color: CustomColors.black,
                    child: RightMenu(
                        screenSizeType: ScreenLayoutController.to.type.value),
                  )
                : null,
            body: Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NavigationMenu(
                    ScreenLayoutController.to.type.value,
                    scaffoldKey: _key,
                  ),
                  Expanded(child: _contentView()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
