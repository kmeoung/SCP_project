import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';
import 'package:scp/src/pages/template/contents_template.dart';

enum PROJECT_PAGE_TYPE { ALL, MY, RECEIVE, SEND }

class ProjectPage extends ContentTemplate {
  PROJECT_PAGE_TYPE pageType;

  ProjectPage({Key? key, required this.pageType}) : super(key: key);

  final String ALL_TASK = 'ALL Task';
  final String MY_TASK = 'MY Task';
  final String RECEIVE_TASK = 'RECEIVE Task';
  final String SEND_TASK = 'SEND Task';

  @override
  List<Widget> customDetail(BuildContext context) {
    String projectSubTitle;
    switch (pageType) {
      case PROJECT_PAGE_TYPE.ALL:
        projectSubTitle = ALL_TASK;
        break;
      case PROJECT_PAGE_TYPE.MY:
        projectSubTitle = MY_TASK;
        break;
      case PROJECT_PAGE_TYPE.RECEIVE:
        projectSubTitle = RECEIVE_TASK;
        break;
      case PROJECT_PAGE_TYPE.SEND:
        projectSubTitle = SEND_TASK;
        break;
    }

    var view = [
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
    ];

    if (pageType == PROJECT_PAGE_TYPE.ALL || pageType == PROJECT_PAGE_TYPE.MY) {
      view.add(_allMyContentView(projectSubTitle));
    } else {
      view.add(_receiveSendContentView());
    }
    return view;
  }

  Widget _headerTitle({required PROJECT_PAGE_TYPE headerType}) {
    String bigTitle;
    String smallTitle;
    String link;
    switch (headerType) {
      case PROJECT_PAGE_TYPE.ALL:
        bigTitle = 'All Task';
        smallTitle = 'ALL';
        link = AllRoutes.PROJECT_ALL;
        break;
      case PROJECT_PAGE_TYPE.MY:
        bigTitle = 'My Task';
        smallTitle = 'MY';
        link = AllRoutes.PROJECT_MY;
        break;
      case PROJECT_PAGE_TYPE.RECEIVE:
        bigTitle = 'Receive Task';
        smallTitle = 'RECEIVE';
        link = AllRoutes.PROJECT_RECEIVETASK;
        break;
      case PROJECT_PAGE_TYPE.SEND:
        bigTitle = 'Send Task';
        smallTitle = 'SEND';
        link = AllRoutes.PROJECT_SENDTASK;
        break;
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(
            link.replaceAll(AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!),
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
            color: headerType == pageType
                ? CustomColors.black
                : CustomColors.beige,
          ),
          child: Text(
            controller.type.value == ScreenSizeType.MOBILE
                ? smallTitle
                : bigTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: headerType == pageType
                  ? CustomColors.beige
                  : CustomColors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        _headerTitle(headerType: PROJECT_PAGE_TYPE.ALL),
        const SizedBox(
          width: 20,
        ),
        _headerTitle(headerType: PROJECT_PAGE_TYPE.MY),
        const SizedBox(
          width: 20,
        ),
        _headerTitle(headerType: PROJECT_PAGE_TYPE.RECEIVE),
        const SizedBox(
          width: 20,
        ),
        _headerTitle(headerType: PROJECT_PAGE_TYPE.SEND),
      ],
    );
  }

  Widget _allMyContentView(String title) {
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

  Widget _receiveSendContentView() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: CustomColors.black.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: CustomColors.red,
                  child: Icon(
                    Icons.arrow_back,
                    size: 15,
                    color: CustomColors.beige,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'My Name',
                  style: TextStyle(color: CustomColors.beige, fontSize: 20),
                )
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 5.0,
            color: CustomColors.beige,
            child: Container(
              width: double.infinity,
              height: 500,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: _taskRequestBtn(
                    title: 'Accept', color: CustomColors.green, onTap: () {}),
              ),
              Expanded(
                child: _taskRequestBtn(
                    title: 'Cancel', color: CustomColors.red, onTap: () {}),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _taskRequestBtn(
      {String title = '', Color? color, GestureTapCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 5.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: CustomColors.beige, fontSize: 15),
          ),
        ),
      ),
      color: color,
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
        if (Get.parameters[AllRoutes.PID] != null) {
          Get.toNamed(
            AllRoutes.TASK_ADD
                .replaceAll(AllRoutes.ARGS_PID, Get.parameters[AllRoutes.PID]!),
          );
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
