class TaskObject {
  final int taskId;
  final int projectinuserId;
  final String taskContent;
  final String taskOwner;
  final String taskRequester;
  final int taskComplete;
  final int taskAccept;
  final String taskRequesttime;
  final String taskDeadline;
  final String taskCreatetime;

  TaskObject(
      this.taskId,
      this.projectinuserId,
      this.taskContent,
      this.taskOwner,
      this.taskRequester,
      this.taskComplete,
      this.taskAccept,
      this.taskRequesttime,
      this.taskDeadline,
      this.taskCreatetime);

  factory TaskObject.fromJson(Map<String, dynamic> json) {
    return TaskObject(
      json['taskId'],
      json['projectinuserId'],
      json['taskContent'],
      json['taskOwner'],
      json['taskRequester'],
      json['taskComplete'],
      json['taskAccept'],
      json['taskRequesttime'],
      json['taskDeadline'],
      json['taskCreatetime'],
    );
  }
}
