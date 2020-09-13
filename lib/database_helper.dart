import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/apputils.dart';
import 'package:todo/models/TaskModel.dart';
import 'package:todo/models/todoModel.dart';

class DatabaseHelper{

  Future<Database> database() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), TaskTableUtils.dataBaseName),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute("CREATE TABLE ${TaskTableUtils.tableName}(${TaskTableUtils.id} INTEGER PRIMARY KEY, ${TaskTableUtils.taskTitle} TEXT, ${TaskTableUtils.taskDisc} TEXT)");
        await db.execute("CREATE TABLE ${TodoTableUtils.tableName}(${TodoTableUtils.id} INTEGER PRIMARY KEY, ${TodoTableUtils.taskId} INTEGER, ${TodoTableUtils.todoTitle} TEXT, ${TodoTableUtils.isDone} INTEGER)");
        return db;

      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 4,
    );
  }



  Future<int> insertTask(Task task) async {
    int taskId = -1;
    // Get a reference to the database.
    final Database db = await database();

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      TaskTableUtils.tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,//when a conflict happened what should do
    ).then((value) =>
      taskId = value
    );
    return taskId;
  }


  Future<void> updateTask(int id,String title,String description) async {
    final Database db = await database();

    await db.rawUpdate(" UPDATE ${TaskTableUtils.tableName} SET ${TaskTableUtils.taskTitle} = '$title' ,  ${TaskTableUtils.taskDisc} = '$description' WHERE ${TaskTableUtils.id} = $id " );
  }



  Future<void> insertTodo(TodoModel todoModel) async {
    // Get a reference to the database.
    final Database db = await database();

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      TodoTableUtils.tableName,
      todoModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,//when a conflict happened what should do
    );
  }


  Future<void> updateTodo(int id,int isDone) async {
    final Database db = await database();

    await db.rawUpdate(" UPDATE ${TodoTableUtils.tableName} SET ${TodoTableUtils.isDone} = $isDone  WHERE ${TodoTableUtils.id} = $id " );
  }


  Future<void> deleteTask(int id) async {
    final Database db = await database();

    await db.rawDelete(" DELETE FROM ${TaskTableUtils.tableName} WHERE ${TaskTableUtils.id} = $id " );
  }


  Future<void> deleteTodo(int taskId) async {
    final Database db = await database();

    await db.rawDelete(" DELETE FROM ${TodoTableUtils.tableName} WHERE ${TodoTableUtils.taskId} = $taskId " );
  }






  Future<List<TodoModel>> getAllTodos(int taskId) async {
    // Get a reference to the database.
    final Database db = await database();

    // Query the table for all The todoo.
    final List<Map<String, dynamic>> maps = await db.query('${TodoTableUtils.tableName} WHERE ${TodoTableUtils.taskId} = $taskId');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return TodoModel(
        id: maps[i][TodoTableUtils.id],
        taskId: maps[i][TodoTableUtils.taskId],
        title: maps[i][TodoTableUtils.todoTitle],
        isDone: maps[i][TodoTableUtils.isDone],
      );
    });
  }





  // A method that retrieves all the dogs from the tasks table.
  Future<List<Task>> getAllTasks() async {
    // Get a reference to the database.
    final Database db = await database();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(TaskTableUtils.tableName);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i][TaskTableUtils.id],
        title: maps[i][TaskTableUtils.taskTitle],
        description: maps[i][TaskTableUtils.taskDisc],
      );
    });
  }



}