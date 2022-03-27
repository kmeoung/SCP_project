import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class MyProjectPage extends ContentTemplate {
  MyProjectPage({Key? key}) : super(key: key);

  @override
  List<Widget> customDetail() {
    return [
      ContentTitle(
        title: 'Project Name ${Get.parameters[AllRoutes.PID]}',
        onTapMore: () {
          if (Get.parameters[AllRoutes.PID] != null) {
            Get.toNamed(
              AllRoutes.PROJECT_EDIT.replaceAll(
                  AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!),
            );
          }
        },
      ),
      _header(),
      const SizedBox(
        height: 20,
      ),
      _contentsView('My Project'),
    ];
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(
                AllRoutes.PROJECT_ALL.replaceAll(
                    AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!),
              );
            },
            child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.black, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Colors.white,
              ),
              child: Text(
                'All Project',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: CustomColors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(
                AllRoutes.PROJECT_MY.replaceAll(
                    AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!),
              );
            },
            child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.black, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: CustomColors.black,
              ),
              child: Text(
                'My Project',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: CustomColors.beige,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.defaultDialog(
                  title: 'Receive Task', middleText: 'not ready yet');
            },
            child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.black, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Colors.white,
              ),
              child: Text(
                'Receive Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: CustomColors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.defaultDialog(
                  title: 'Send Task', middleText: 'not ready yet');
            },
            child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.black, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Colors.white,
              ),
              child: Text(
                'Send Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: CustomColors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentsView(String title) {
    int dummySize = Random().nextInt(20) + 1;
    int dummy2 = Random().nextInt(3);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: Get.height * 0.7),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
              alignment: Alignment.center,
              color: Colors.transparent,
              child: LinearProgressIndicator(
                value: Random().nextDouble(),
                backgroundColor: CustomColors.black,
                color: CustomColors.red,
                minHeight: 10,
              ),
            ),
            ...List.generate(
              dummySize,
              (index) {
                String type = '';
                Color color = CustomColors.black;
                if (index < dummy2) {
                  color = CustomColors.red;
                  type = 'Delayed';
                } else if (index > dummySize - 3) {
                  color = CustomColors.green;
                  type = 'Succeed';
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: _taskCard(index,
                      title: 'task $index $type', color: color),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskCard(int tid, {required String title, required Color color}) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AllRoutes.TASK
              .replaceAll(AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!)
              .replaceAll(AllRoutes.ARGS_TID, '$tid'),
        );
      },
      child: Card(
        elevation: 5.0,
        color: color.withOpacity(0.7),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                radius: 15,
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
        if (Get.parameters[AllRoutes.ARGS_PID] != null) {
          Get.toNamed(AllRoutes.TASK_ADD
              .replaceAll(AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!));
        }
      },
      child: Icon(
        Icons.add,
        color: CustomColors.beige,
      ),
      backgroundColor: CustomColors.black,
    );
  }
}
