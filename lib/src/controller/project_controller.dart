import 'package:get/get.dart';
import 'package:scp/src/json_object/home/home_project_obj.dart';
import 'package:scp/src/json_object/task_obj.dart';

class ProjectController extends GetxController {
  List<TaskObject> tasks = [];

  add(TaskObject task) {
    tasks.add(task);
    update();
  }

  clear() {
    tasks.clear();
    update();
  }
}
