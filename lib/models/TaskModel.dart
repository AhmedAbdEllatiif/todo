import 'package:sqflite/sqflite.dart';
import 'package:todo/apputils.dart';
import 'package:todo/database_helper.dart';

class Task{
  final int id;
  final String title;
  final String description;

  Task({this.id, this.title,this.description});


  Map<String,dynamic> toMap(){
    return{
      TaskTableUtils.id :  id,
      TaskTableUtils.taskTitle : title??"untitled Task",
      TaskTableUtils.taskDisc : description??'no description yet',
    };
  }





}