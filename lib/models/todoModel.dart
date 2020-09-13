import 'package:todo/apputils.dart';

class TodoModel{

   int id;
   int taskId;
   int isDone;
   String title;

   TodoModel({this.id,this.taskId, this.isDone, this.title});


   Map<String,dynamic> toMap(){
     return {
       TodoTableUtils.id : id,
       TodoTableUtils.taskId : taskId,
       TodoTableUtils.todoTitle : title??"Enter todo item...",
       TodoTableUtils.isDone : isDone??0,
     };
   }
}