import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/profile_dialog.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/home/home_page.dart';
import 'package:scp/src/pages/home/project_page.dart';
import 'package:scp/src/pages/home/team_page.dart';

/// Desktop -> 오른쪽 메뉴
/// Mobile -> Drawer
class RightMenu extends StatelessWidget {
  double width;
  ScreenSizeType screenSizeType;
  final _userId;
  RightMenu(
    this._userId, {
    Key? key,
    this.width = 300,
    this.screenSizeType = ScreenSizeType.DESKTOP,
  }) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    switch (screenSizeType) {
      case ScreenSizeType.MOBILE:
        return _mobileLayout(context);
      case ScreenSizeType.TABLET:
      case ScreenSizeType.DESKTOP:
        return _desktopLayout(context);
    }
  }

  Widget _sizeMenuDetail(BuildContext context, bool isDesktop) {
    return Container(
      height: double.infinity,
      color: CustomColors.deepPurple,
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
              InkWell(
                onTap: () {
                  if (screenSizeType == ScreenSizeType.MOBILE) Get.back();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProfileDialog(
                        width: Get.width * 0.5,
                        height: Get.height * 0.5,
                        isDesktop: isDesktop,
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: CustomColors.white,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'User Name',
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: CustomColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: CustomColors.white,
                thickness: 1,
                height: 40,
              ),
              const Text(
                'BigMenu',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: CustomColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              _sideMenu('Home', onPressed: () {
                Get.to(HomePage(
                  uid: _userId,
                ));
              }),
              _sideMenu('Team', onPressed: () {
                Get.to(TeamPage(
                  uid: _userId,
                ));
              }),
              _sideMenu('Chat', onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Not ready yet'),
                    content: const Text('comming soon...'),
                    actions: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Projects',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: CustomColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ...List.generate(
                10,
                (index) => _sideMenu('project $index', onPressed: () {
                  Get.to(ProjectPage(
                      pid: '$index',
                      uid: _userId,
                      pageType: PROJECT_PAGE_TYPE.ALL));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return _sizeMenuDetail(context, false);
  }

  Widget _desktopLayout(BuildContext context) {
    return Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: _sizeMenuDetail(context, true));
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
      return CustomColors.purple;
    }
    return CustomColors.white;
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
