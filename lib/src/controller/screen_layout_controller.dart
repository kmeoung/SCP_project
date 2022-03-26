import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ScreenSizeType { MOBILE, TABLET, DESKTOP }

/// Rx Controller
class ScreenLayoutController extends GetxController {
  static ScreenLayoutController get to => Get.find();
  final Rx<ScreenSizeType> _screenType = ScreenSizeType.DESKTOP.obs;
  Rx<ScreenSizeType> type = ScreenSizeType.DESKTOP.obs;

  @override
  void onInit() {
    // 화면 전환 시 리소스를 많이 사용하여 전환이 끝난 후 200 milliSec후에 전환하도록 설정
    debounce(_screenType, (_) {
      type(_screenType.value);
    }, time: const Duration(milliseconds: 200));
  }

  void builder(BoxConstraints constraints) {
    if (constraints.biggest.width > 1000 && constraints.biggest.width <= 1400) {
      // Tablet Device
      _screenType(ScreenSizeType.TABLET);
    } else if (constraints.biggest.width <= 1000) {
      // mobile Device
      _screenType(ScreenSizeType.MOBILE);
    } else {
      // Desktop
      _screenType(ScreenSizeType.DESKTOP);
    }
  }
}
