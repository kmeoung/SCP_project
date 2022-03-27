import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class HomePage extends ContentTemplate {
  HomePage({Key? key}) : super(key: key);

  @override
  List<Widget> customDetail() {
    return [
      ContentTitle(title: 'My Project'),
      _homeItemView(tempCount: 6),
      const SizedBox(
        height: 40,
      ),
      ContentTitle(title: 'Shared Project'),
      _homeItemView(tempCount: 3),
    ];
  }

  Widget _homeItemView({int tempCount = 2}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tempCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: controller.type.value == ScreenSizeType.MOBILE
            ? 2
            : controller.type.value == ScreenSizeType.TABLET
                ? 3
                : 5,
        childAspectRatio: 9 / 10,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return _projectCard('Project $index', index);
      },
    );
  }

  Widget _projectCard(String title, int pid) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AllRoutes.PROJECT_ALL.replaceAll(AllRoutes.ARGS_PID, '$pid'),
        );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: CustomColors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 45,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              child: SizedBox(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.beige,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      iconSize: 30,
                      onPressed: () {
                        Get.toNamed(
                          AllRoutes.PROJECT_EDIT
                              .replaceAll(AllRoutes.ARGS_PID, '$pid'),
                        );
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.more_horiz,
                        color: CustomColors.beige,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColors.beige,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    Random().nextInt(3) + 1,
                    (index) {
                      int rand = Random().nextInt(3);
                      var color = CustomColors.black;
                      String tempTitleHeader = '';
                      switch (rand) {
                        case 0:
                          color = CustomColors.red;
                          tempTitleHeader = 'Delayed';
                          break;
                        case 1:
                          color = CustomColors.green;
                          tempTitleHeader = 'Succeed';
                          break;
                      }
                      return Expanded(
                        child: _taskCard(pid, index,
                            title: 'Task $index $tempTitleHeader',
                            color: color),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 9.0),
              alignment: Alignment.center,
              color: Colors.transparent,
              child: LinearProgressIndicator(
                value: Random().nextDouble(),
                backgroundColor: CustomColors.beige,
                color: CustomColors.red,
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskCard(int pid, int tid,
      {required String title, required Color color}) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AllRoutes.TASK
              .replaceAll(AllRoutes.ARGS_PID, '$pid')
              .replaceAll(AllRoutes.ARGS_TID, '$tid'),
        );
      },
      child: Card(
        elevation: 5.0,
        color: color.withOpacity(0.7),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: CustomColors.beige),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: CustomColors.beige,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  FloatingActionButton? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(AllRoutes.PROJECT_ADD);
      },
      child: Icon(
        Icons.add,
        color: CustomColors.beige,
      ),
      backgroundColor: CustomColors.black,
    );
  }
}
