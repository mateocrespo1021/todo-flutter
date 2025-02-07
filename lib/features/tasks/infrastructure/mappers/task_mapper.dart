import 'package:todotasks/features/tasks/domain/domain.dart';

class TaskMapper {
  static jsonToEntity(Map<String, dynamic> json) => Task(
      id: json['id'],
      title: json['title'],
      isCompleted: bool.parse(['isCompleted'].toString()),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']);
}
