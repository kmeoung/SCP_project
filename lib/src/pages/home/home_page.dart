import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/http/scp_http_client.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/comm_param.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/home_controller.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/json_object/home/home_project_obj.dart';
import 'package:scp/src/json_object/task_obj.dart';
import 'package:scp/src/pages/home/add_or_edit_project.dart';
import 'package:scp/src/pages/home/project_page.dart';
import 'package:scp/src/pages/home/task_page.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class HomePage extends ContentTemplate {
  final String _userId;
  HomePage({required String uid, Key? key})
      : _userId = uid,
        super(uid, key: key);

  @override
  List<Widget> customDetail(BuildContext context) {
    Get.put(HomeController());
    _getData();
    return [
      ContentTitle(title: 'My Project'),
      _homeItemView(
          projects:
              Get.find<HomeController>().get(projectType: PROJECT_TYPE.MY)),
      const SizedBox(
        height: 40,
      ),
      ContentTitle(title: 'Shared Project'),
      _homeItemView(
          projects: Get.find<HomeController>()
              .get(projectType: PROJECT_TYPE.ANOTHER)),
    ];
  }

  /// Get Server
  _getData() async {
    var url = Comm_Params.URL_HOME.replaceAll(Comm_Params.USER_ID, _userId);
    await ScpHttpClient.get(
      url,
      onSuccess: (json, message) {
        Get.find<HomeController>().clear(projectType: PROJECT_TYPE.ALL);
        List<dynamic> projects = json['projects'];
        if (projects.isNotEmpty) {
          for (Map<String, dynamic> json in projects) {
            ProjectObject obj = ProjectObject.fromJson(json);
            if (obj.userCode == IS_HAVE.leader) {
              Get.find<HomeController>().add(
                obj,
                projectType: PROJECT_TYPE.MY,
              );
            } else {
              Get.find<HomeController>().add(
                obj,
                projectType: PROJECT_TYPE.ANOTHER,
              );
            }
          }
        }
      },
      onFailed: (message) {
        Get.find<HomeController>().clear(projectType: PROJECT_TYPE.ALL);
        Get.snackbar('Server Error', message,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  /// View Binding Home Item View
  Widget _homeItemView({required List<ProjectObject> projects}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
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
      itemBuilder: (context, index) => _projectCard(projects[index]),
    );
  }

  /// View Binding Project Card
  Widget _projectCard(ProjectObject project) {
    int taskSize = project.tasklist.length;
    int successTasks = project.tasklist
        .where((element) =>
            TaskObject.fromJson(element as Map<String, dynamic>).taskComplete ==
            1)
        .length;

    print('task Size : $taskSize');
    print('successTask : $successTasks');
    return InkWell(
      onTap: () {
        Get.to(
          ProjectPage(
              pid: '${project.projectId}',
              uid: _userId,
              pageType: PROJECT_PAGE_TYPE.ALL),
        );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: CustomColors.deepPurple,
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
                        project.projectName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      iconSize: 30,
                      onPressed: () {
                        Get.to(
                          AddOrEditProject(
                            uid: _userId,
                            pid: '${project.projectId}',
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.more_horiz,
                        color: CustomColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    (project.tasklist.length > 3)
                        ? 3
                        : project.tasklist.isEmpty
                            ? 1
                            : project.tasklist.length,
                    (index) {
                      if (project.tasklist.isEmpty) {
                        return Expanded(
                          child: _taskCard(project.projectId, -1,
                              title: '할 일을 추가해 주세요.', color: CustomColors.gray),
                        );
                      } else {
                        TaskObject task = TaskObject.fromJson(
                            project.tasklist[index] as Map<String, dynamic>);

                        var color = CustomColors.deepPurple;
                        switch (task.taskComplete) {
                          case 0: // 완료하지 않은 할 일
                            color = CustomColors.deepPurple;
                            break;
                          case 1: // 완료한 할 일
                            color = CustomColors.yellow;
                            break;
                        }

                        DateTime now = DateTime.now();
                        DateTime deadLine = DateTime.parse(task.taskDeadline);
                        // 데드라인이 얼마 안 남았을 경우와 넘겼을 경우
                        if (deadLine.year >= now.year) {
                          if (deadLine.month >= now.month) {
                            if (deadLine.day >= now.day) {
                              if (deadLine.hour >= now.hour) {
                                color = CustomColors.gray;
                              }
                            }
                          }
                        }

                        return Expanded(
                          child: _taskCard(project.projectId, task.taskId,
                              title: task.taskContent, color: color),
                        );
                      }
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
                value: project.tasklist.isEmpty
                    ? 0
                    : (successTasks > 0)
                        ? taskSize / successTasks * 0.1
                        : 0,
                backgroundColor: CustomColors.white,
                color: CustomColors.yellow,
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// View Binding Task Card
  Widget _taskCard(int pid, int tid,
      {required String title, required Color color}) {
    return InkWell(
      onTap: () {
        if (tid > -1) {
          Get.to(TaskPage(
            uid: _userId,
            pid: '$pid',
            tid: '$tid',
          ));
        } else {
          Get.to(ProjectPage(
            uid: _userId,
            pid: '$pid',
            pageType: PROJECT_PAGE_TYPE.ALL,
          ));
        }
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
                  style: const TextStyle(color: CustomColors.white),
                  overflow: TextOverflow.ellipsis,
                  textAlign: tid > -1 ? TextAlign.start : TextAlign.center,
                ),
              ),
              Visibility(
                visible: tid > -1,
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: CustomColors.white,
                ),
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
        Get.to(AddOrEditProject(uid: _userId));
      },
      child: const Icon(
        Icons.add,
        color: CustomColors.white,
      ),
      backgroundColor: CustomColors.deepPurple,
    );
  }
}
