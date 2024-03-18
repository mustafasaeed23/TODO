import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/tasks.dart';

CollectionReference<TasksData> getTasksCollecton() {
  return FirebaseFirestore.instance
      .collection("tasks")
      .withConverter<TasksData>(
          fromFirestore: (snapshot, sp) => TasksData.fromJson(snapshot.data()!),
          toFirestore: (task, sp) => task.toJson());
}

Future<void> addTasksToFirebaseFirestore(TasksData task) {
  var collection = getTasksCollecton();
  var docRef = collection.doc();
  task.id = docRef.id;
  return docRef.set(task);
}

Stream<QuerySnapshot<TasksData>> getTasksFromFirestroe(DateTime dateTime) {
  return getTasksCollecton().
  where("date",isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch).snapshots();
}
Future<void> deleteTasksFromFirestore(String id)async {
  await getTasksCollecton().doc(id).delete();
}

Future<void> EditTasksFromFirestore(TasksData task)async{
  await getTasksCollecton().doc(task.id).update(task.toJson());
}
