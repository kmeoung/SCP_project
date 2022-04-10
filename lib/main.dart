import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';
import 'package:scp/src/pages/home/add_or_edit_task.dart';
import 'package:scp/src/pages/home/add_or_edit_team.dart';

import 'package:scp/src/pages/home/home_page.dart';
import 'package:scp/src/pages/home/project_page.dart';
import 'package:scp/src/pages/home/task_page.dart';
import 'package:scp/src/pages/home/team_page.dart';
import 'package:scp/src/pages/login.dart';

void main() => runApp(const Scp());

/// SCP Project
class Scp extends StatelessWidget {
  const Scp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: CustomColors.yellow,
        backgroundColor: CustomColors.white,
        appBarTheme: const AppBarTheme(
          color: CustomColors.deepPurple,
          centerTitle: false,
          foregroundColor: CustomColors.white,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: CustomColors.deepPurple),
          bodyText2: TextStyle(color: CustomColors.deepPurple),
          headline1: TextStyle(color: CustomColors.deepPurple),
          headline2: TextStyle(color: CustomColors.deepPurple),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(ScreenLayoutController()); // 화면 사이즈 Rx Controller
      }),
      home: LoginPage(),
    );
  }

  GetPage defaultPage({required String name, required Widget page}) {
    return GetPage(
      name: name,
      page: () => page,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
