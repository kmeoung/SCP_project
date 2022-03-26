import 'package:flutter/material.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';

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
      color: CustomColors.black,
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'SCP',
              style: TextStyle(fontSize: 45, color: CustomColors.beige),
            ),
          ),
          InkWell(
            onTap: () {
              // Drawer 열기
              _key?.currentState?.openEndDrawer();
            },
            child: SizedBox(
              width: 80,
              height: 80,
              child: Icon(
                Icons.menu,
                color: CustomColors.beige,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigation Desktop Layout
  Widget _desktopLayout() {
    return Container();
  }
}
