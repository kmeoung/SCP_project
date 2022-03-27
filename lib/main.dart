import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';
import 'package:scp/src/pages/home/add_or_edit_task.dart';

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
      getPages: [
        // 페이지 Routing
        defaultPage(
          name: AllRoutes.HOME,
          page: HomePage(),
        ),
        defaultPage(
          name: AllRoutes.TEAM,
          page: TeamPage(),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_ALL,
          page: AllProjectPage(),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_MY,
          page: MyProjectPage(),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_ADD,
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_EDIT,
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: AllRoutes.TASK,
          page: TaskPage(),
        ),
        defaultPage(
          name: AllRoutes.TASK_ADD,
          page: AddOrEditTask(),
        ),
        defaultPage(
          name: AllRoutes.TASK_EDIT,
          page: AddOrEditTask(),
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
