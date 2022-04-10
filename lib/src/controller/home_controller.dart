import 'package:get/get.dart';
import 'package:scp/src/json_object/home/home_project_obj.dart';

enum PROJECT_TYPE { MY, ANOTHER, ALL }

class HomeController extends GetxController {
  List<ProjectObject> myProjects = [];
  List<ProjectObject> anotherProjects = [];

  add(ProjectObject project, {required PROJECT_TYPE projectType}) {
    if (projectType == PROJECT_TYPE.MY) {
      myProjects.add(project);
    } else if (projectType == PROJECT_TYPE.ANOTHER) {
      anotherProjects.add(project);
    }
    update();
  }

  clear({required PROJECT_TYPE projectType}) {
    if (projectType == PROJECT_TYPE.MY) {
      myProjects.clear();
    } else if (projectType == PROJECT_TYPE.ANOTHER) {
      anotherProjects.clear();
    } else {
      myProjects.clear();
      anotherProjects.clear();
    }
    update();
  }
}
