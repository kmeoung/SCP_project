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

void main() => runApp(const Scp());

/// SCP Project
class Scp extends StatelessWidget {
  const Scp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: CustomColors.red,
        backgroundColor: CustomColors.beige,
        appBarTheme: const AppBarTheme(
          color: CustomColors.black,
          centerTitle: false,
          foregroundColor: CustomColors.beige,
        ),
        textTheme: const TextTheme(
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
          name: AllRoutes.HOME, // Home
          page: HomePage(),
        ),
        defaultPage(
          name: AllRoutes.TEAM, // Team
          page: TeamPage(),
        ),
        defaultPage(
          name: AllRoutes.TEAM_ADD, // Team Add
          page: AddOrEditTeam(),
        ),
        defaultPage(
          name: AllRoutes.TEAM_DETAIL, // Team Detail
          page: TeamPage(),
        ),
        defaultPage(
          name: AllRoutes.TEAM_EDIT, // Team Edit
          page: AddOrEditTeam(),
        ),

        defaultPage(
          name: AllRoutes.PROJECT_ALL, // Project 전체
          page: ProjectPage(
            pageType: PROJECT_PAGE_TYPE.ALL,
          ),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_MY, // Project 내껏만
          page: ProjectPage(
            pageType: PROJECT_PAGE_TYPE.MY,
          ),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_SENDTASK, // Project 보낸 할 일
          page: ProjectPage(
            pageType: PROJECT_PAGE_TYPE.SEND,
          ),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_RECEIVETASK, // Project 받은 할 일
          page: ProjectPage(
            pageType: PROJECT_PAGE_TYPE.RECEIVE,
          ),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_ADD, // Project 추가
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: AllRoutes.PROJECT_EDIT, // Project 수정
          page: AddOrEditProject(),
        ),
        defaultPage(
          name: AllRoutes.TASK, // 할 일
          page: TaskPage(),
        ),
        defaultPage(
          name: AllRoutes.TASK_EDIT, // Task 수정
          page: AddOrEditTask(),
        ),
        defaultPage(
          name: AllRoutes.TASK_ADD, // Task 추가
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
