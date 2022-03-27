import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';

/// Desktop -> 오른쪽 메뉴
/// Mobile -> Drawer
class RightMenu extends StatelessWidget {
  double width;
  ScreenSizeType screenSizeType;
  RightMenu({
    Key? key,
    this.width = 300,
    this.screenSizeType = ScreenSizeType.DESKTOP,
  }) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    switch (screenSizeType) {
      case ScreenSizeType.MOBILE:
        return _mobileLayout();
      case ScreenSizeType.TABLET:
      case ScreenSizeType.DESKTOP:
        return _desktopLayout();
    }
  }

  Widget _sizeMenuDetail() {
    return Container(
      height: double.infinity,
      color: CustomColors.black,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomColors.beige,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'User Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.beige),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: CustomColors.beige,
                thickness: 1,
                height: 40,
              ),
              Text(
                'BigMenu',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: CustomColors.beige),
              ),
              const SizedBox(
                height: 20,
              ),
              _sideMenu('Home', onPressed: () {
                Get.toNamed(AllRoutes.HOME);
              }),
              _sideMenu('Team', onPressed: () {
                Get.toNamed(AllRoutes.TEAM);
              }),
              _sideMenu('Chat', onPressed: () {}),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Projects',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: CustomColors.beige),
              ),
              const SizedBox(
                height: 20,
              ),
              ...List.generate(
                10,
                (index) => _sideMenu('project $index', onPressed: () {
                  Get.toNamed(AllRoutes.PROJECT_ALL
                      .replaceAll(AllRoutes.ARGS_PID, '$index'));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return _sizeMenuDetail();
  }

  Widget _desktopLayout() {
    return Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: _sizeMenuDetail());
  }

  /// 사이드 메뉴
  Widget _sideMenu(String title, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          // 모바일 타입일 때 Drawer 종료 후 이동
          if (screenSizeType == ScreenSizeType.MOBILE) Get.back();
          onPressed();
        }
      },
      style: ButtonStyle(
          alignment: Alignment.centerLeft,
          foregroundColor:
              MaterialStateProperty.resolveWith(getForegroundColor),
          overlayColor:
              MaterialStateProperty.resolveWith((state) => Colors.transparent),
          padding: MaterialStateProperty.resolveWith(getPadding)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  /// Drawer 버튼 색상
  Color getForegroundColor(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return CustomColors.apricot;
    }
    return CustomColors.beige;
  }

  /// Drawer 버튼 이벤트
  EdgeInsets getPadding(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return const EdgeInsets.only(left: 5);
    }
    return EdgeInsets.zero;
  }
}
