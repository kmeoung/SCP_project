import 'package:flutter/material.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';

/// Mobile Layout 시 상단에 뜨는 Navigation Menu
class NavigationMenu extends StatelessWidget {
  /// 화면 타입
  ScreenSizeType screenSizeType;

  /// Page Scaffold State
  final GlobalKey<ScaffoldState>? _key;

  NavigationMenu(this.screenSizeType,
      {Key? key, GlobalKey<ScaffoldState>? scaffoldKey})
      : _key = scaffoldKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (screenSizeType) {
      case ScreenSizeType.DESKTOP: // Desktop
      case ScreenSizeType.TABLET:
        return _desktopLayout();
      case ScreenSizeType.MOBILE: // Mobile
        return _mobileLayout();
    }
  }

  /// Navigation Mobile Layout
  Widget _mobileLayout() {
    return Container(
      color: CustomColors.deepPurple,
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'SCP ',
                  style: TextStyle(
                      color: CustomColors.yellow,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Project ',
                  style: TextStyle(
                      color: CustomColors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Drawer 열기
              _key?.currentState?.openEndDrawer();
            },
            child: const SizedBox(
              width: 80,
              height: 80,
              child: Icon(
                Icons.menu,
                color: CustomColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigation Desktop Layout
  /// Desktop에서는 메뉴 버튼이 필요 없음
  Widget _desktopLayout() {
    return Container();
  }
}
