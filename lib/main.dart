import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';

import 'package:scp/src/pages/home/home_page.dart';
import 'package:scp/src/pages/home/all_project_page.dart';
import 'package:scp/src/pages/home/my_project_page.dart';
import 'package:scp/src/pages/home/task_page.dart';
import 'package:scp/src/pages/home/team_page.dart';

void main() => runApp(const Scp());

class Scp extends StatelessWidget {
  const Scp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: CustomColors.red,
        backgroundColor: CustomColors.beige,
        appBarTheme: AppBarTheme(
          color: CustomColors.black,
          centerTitle: false,
          foregroundColor: CustomColors.beige,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: CustomColors.black),
          bodyText2: TextStyle(color: CustomColors.black),
          headline1: TextStyle(color: CustomColors.black),
          headline2: TextStyle(color: CustomColors.black),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(ScreenLayoutController()); // 화면 사이즈 Rx Controller
      }),
      initialRoute: '/',
      getPages: [
        // 페이지 Routing
        defaultPage(
          name: '/',
          page: HomePage(),
        ),
        defaultPage(
          name: '/team',
          page: TeamPage(),
        ),
        defaultPage(
          name: '/project/:pid/all',
          page: AllProjectPage(),
        ),
        defaultPage(
          name: '/project/:pid/my',
          page: MyProjectPage(),
        ),
        defaultPage(
          name: '/project/:pid/task/:tid',
          page: TaskPage(),
        ),
        defaultPage(
          name: '/project/:pid/edit',
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: '/project/add',
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: '/project/:pid/task/:tid/edit',
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: '/project/:pid/task/add',
          page: AddOrEditProject(),
        ),
      ],
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
