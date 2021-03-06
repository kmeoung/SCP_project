import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/http/scp_http_client.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/comm_param.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/home_controller.dart';
import 'package:scp/src/controller/project_controller.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/json_object/home/home_project_obj.dart';
import 'package:scp/src/json_object/task_obj.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';
import 'package:scp/src/pages/home/add_or_edit_task.dart';
import 'package:scp/src/pages/home/task_page.dart';
import 'package:scp/src/pages/template/contents_template.dart';

enum PROJECT_PAGE_TYPE { ALL, MY, RECEIVE, SEND }

class ProjectPage extends ContentTemplate {
  PROJECT_PAGE_TYPE pageType;
  final String pid;
  final String uid;

  ProjectPage(
      {required this.pid, required this.uid, Key? key, required this.pageType})
      : super(uid, key: key);

  final String ALL_TASK = 'ALL Task';
  final String MY_TASK = 'MY Task';
  final String RECEIVE_TASK = 'RECEIVE Task';
  final String SEND_TASK = 'SEND Task';

  /// Get All Task
  _getAllTask() async {
    var url =
        Comm_Params.URL_RPOJECT_ALL.replaceAll(Comm_Params.PROJECT_ID, pid);
    print(url);
    await ScpHttpClient.get(
      url,
      onSuccess: (json, message) {
        Get.find<ProjectController>().clear();
        List<dynamic> tasks = json['tasklist'];
        if (tasks.isNotEmpty) {
          for (Map<String, dynamic> json in tasks) {
            TaskObject task = TaskObject.fromJson(json);
            Get.find<ProjectController>().add(task);
          }
        }
      },
      onFailed: (message) {
        Get.find<ProjectController>().clear();
        Get.snackbar('Server Error', message,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  /// Get All Task
  _getMyTask() async {
    var url = Comm_Params.URL_PROJECT_MY
        .replaceAll(Comm_Params.PROJECT_ID, pid)
        .replaceAll(Comm_Params.USER_ID, uid);
    print(url);
    await ScpHttpClient.get(
      url,
      onSuccess: (json, message) {
        Get.find<ProjectController>().clear();
        List<dynamic> tasks = json['tasklist'];
        if (tasks.isNotEmpty) {
          for (Map<String, dynamic> json in tasks) {
            TaskObject task = TaskObject.fromJson(json);
            Get.find<ProjectController>().add(task);
          }
        }
      },
      onFailed: (message) {
        Get.find<ProjectController>().clear();
        Get.snackbar('Server Error', message,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  @override
  List<Widget> customDetail(BuildContext context) {
    String projectSubTitle;
    switch (pageType) {
      case PROJECT_PAGE_TYPE.ALL:
        projectSubTitle = ALL_TASK;
        _getAllTask();
        break;
      case PROJECT_PAGE_TYPE.MY:
        projectSubTitle = MY_TASK;
        _getMyTask();
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
        title: 'Project Name $pid',
        onTapMore: () {
          Get.to(AddOrEditProject(
            uid: uid,
            pid: pid,
          ));
        },
      ),
      _header(),
      const SizedBox(
        height: 20,
      ),
    ];

    if (pageType == PROJECT_PAGE_TYPE.ALL || pageType == PROJECT_PAGE_TYPE.MY) {
      view.add(
        GetBuilder<ProjectController>(
          init: ProjectController(),
          builder: (_) {
            return _allMyContentView(projectSubTitle);
          },
        ),
      );
    } else {
      view.add(_receiveSendContentView());
    }
    return view;
  }

  Widget _headerTitle({required PROJECT_PAGE_TYPE headerType}) {
    String bigTitle;
    String smallTitle;
    switch (headerType) {
      case PROJECT_PAGE_TYPE.ALL:
        bigTitle = 'All Task';
        smallTitle = 'ALL';
        break;
      case PROJECT_PAGE_TYPE.MY:
        bigTitle = 'My Task';
        smallTitle = 'MY';
        break;
      case PROJECT_PAGE_TYPE.RECEIVE:
        bigTitle = 'Receive Task';
        smallTitle = 'RECEIVE';
        break;
      case PROJECT_PAGE_TYPE.SEND:
        bigTitle = 'Send Task';
        smallTitle = 'SEND';
        break;
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          Get.to(ProjectPage(pid: pid, uid: uid, pageType: headerType));
        },
        child: Container(
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.deepPurple, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: headerType == pageType
                ? CustomColors.deepPurple
                : CustomColors.white,
          ),
          child: Text(
            controller.type == ScreenSizeType.MOBILE ? smallTitle : bigTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: headerType == pageType
                  ? CustomColors.white
                  : CustomColors.deepPurple,
            ),
          ),
        ),
      ),
    );
  }

  /// Binding View Header
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

  /// Binding View All My Content View
  Widget _allMyContentView(String title) {
    List<TaskObject> tasks = Get.find<ProjectController>().tasks;
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.deepPurple,
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
                backgroundColor: CustomColors.deepPurple,
                color: CustomColors.yellow,
                minHeight: 10,
              ),
            ),
            ...List.generate(
              tasks.length,
              (index) {
                TaskObject task = tasks[index];
                Color color = CustomColors.deepPurple;

                switch (task.taskComplete) {
                  case 0: // ???????????? ?????? ??? ???
                    color = CustomColors.deepPurple;
                    break;
                  case 1: // ????????? ??? ???
                    color = CustomColors.yellow;
                    break;
                }

                DateTime now = DateTime.now();
                DateTime deadLine = DateTime.parse(task.taskDeadline);
                // ??????????????? ?????? ??? ????????? ????????? ????????? ??????
                if (deadLine.year >= now.year) {
                  if (deadLine.month >= now.month) {
                    if (deadLine.day >= now.day) {
                      if (deadLine.hour >= now.hour) {
                        color = CustomColors.gray;
                      }
                    }
                  }
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: _taskCard(task.taskId,
                      title: task.taskContent, color: color),
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
      color: CustomColors.deepPurple.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: CustomColors.yellow,
                  child: Icon(
                    Icons.arrow_back,
                    size: 15,
                    color: CustomColors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'My Name',
                  style: TextStyle(color: CustomColors.white, fontSize: 20),
                )
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 5.0,
            color: CustomColors.white,
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
                    title: 'Accept',
                    color: CustomColors.whitePurple,
                    onTap: () {}),
              ),
              Expanded(
                child: _taskRequestBtn(
                    title: 'Cancel', color: CustomColors.yellow, onTap: () {}),
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
            style: TextStyle(color: CustomColors.white, fontSize: 15),
          ),
        ),
      ),
      color: color,
    );
  }

  Widget _taskCard(int tid, {required String title, required Color color}) {
    return InkWell(
      onTap: () {
        Get.to(TaskPage(uid: uid, pid: pid, tid: '$tid'));
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
                  style: const TextStyle(color: CustomColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const CircleAvatar(
                radius: 15,
                backgroundColor: CustomColors.white,
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
        Get.to(
          AddOrEditTask(uid: uid, pid: pid),
        );
      },
      child: const Icon(
        Icons.add,
        color: CustomColors.white,
      ),
      backgroundColor: CustomColors.deepPurple,
    );
  }
}
