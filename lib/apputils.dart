class AppUtils{
  static String imagesDirectory  = 'assets/';
  static String homePage  = '/home';
  static String taskPage  = '/taskPage';
  static final double pagePadding  = 24.0;
  static final double floatButtonRadius  = 20.0;



/*
      * '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),*/
}



class TaskTableUtils{
  static String dataBaseName  = 'task_database.db';
  static String tableName  = 'task_table';
  static String id  = 'id';
  static String taskTitle  = 'taskTitle';
  static String taskDisc  = 'taskDisc';
}


class TodoTableUtils{
  static String dataBaseName  = 'todo_database.db';
  static String tableName  = 'todo_table';
  static String id  = 'id';
  static String taskId  = 'taskId';
  static String todoTitle  = 'todoTitle';
  static String isDone  = 'isDone';
}