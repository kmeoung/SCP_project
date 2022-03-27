class AllRoutes {
  static String PID = 'pid';
  static String TID = 'tid';

  static String ARGS_PID = ':' + PID;
  static String ARGS_TID = ':' + TID;

  static String HOME = '/';
  static String TEAM = HOME + 'team';
  static String _project = HOME + 'project';
  static String PROJECT_ADD = _project + '/add';
  static String _projectDetail = _project + '/' + ARGS_PID;
  static String PROJECT_ALL = _projectDetail + '/all';
  static String PROJECT_MY = _projectDetail + '/my';
  static String PROJECT_RECEIVETASK = _projectDetail + '/receiveTask';
  static String PROJECT_SENDTASK = _projectDetail + '/sendTask';
  static String PROJECT_EDIT = _projectDetail + '/edit';

  static String _task = _projectDetail + '/task';
  static String TASK = _task + '/' + ARGS_TID;
  static String TASK_ADD = _task + '/new/add';
  static String TASK_EDIT = TASK + '/edit';
}
