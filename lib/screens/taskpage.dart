import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/apputils.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/models/TaskModel.dart';
import 'package:todo/models/todoModel.dart';
import 'package:todo/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  TaskPage({@required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String title = "";
  String description = "";
  int taskId = -1;
  WidgetsHelper widgetsHelper = WidgetsHelper();
  bool contentVisibility = false;

  FocusNode titleFocus;
  FocusNode descriptionFocus;
  FocusNode todoFocus;

  TextEditingController titleController;
  TextEditingController descriptionController;


  @override
  void initState() {
    super.initState();

    titleFocus = FocusNode();
    descriptionFocus = FocusNode();
    todoFocus = FocusNode();

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    if (widget.task != null) {
      title = widget.task.title;
      description = widget.task.description;
      taskId = widget.task.id;
      contentVisibility = true;
      if(title.trim() == ""){
        title = "Unnamed Task";
      }
      if(description.trim() == ""){
        description = "No Description Added";
      }
      titleController = TextEditingController(text: title);
      descriptionController = TextEditingController(text: description);

    }else{
      titleController = TextEditingController();
      descriptionController = TextEditingController();
    }


  }


  @override
  void dispose() {
    titleFocus.dispose();
    descriptionFocus.dispose();
    todoFocus.dispose();


    titleController.dispose();
    descriptionController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: AppUtils.pagePadding),
                    child: Row(
                      children: [
                        InkWell(
                          //To show ripple with icon clicked
                          onTap: () {
                            if(taskId != -1){
                              databaseHelper.updateTask(taskId,titleController.text,descriptionController.text);
                            }
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image(
                                  image: AssetImage(
                                      '${AppUtils.imagesDirectory}back_arrow_icon.png'))),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
                          child: TextField(
                            focusNode: titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  Task task = Task(title: value);
                                 taskId =  await databaseHelper.insertTask(task);

                                  print("New Task Added");
                                  setState(() {
                                    contentVisibility = true;
                                    title = value;
                                  });
                                } else {
                                  databaseHelper.updateTask(taskId,value,descriptionController.text);
                                  print("update the task");
                                }
                              }
                              descriptionFocus.requestFocus();
                            },
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: "Enter Task Title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF211551)),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: contentVisibility,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: AppUtils.pagePadding),
                      child: TextField(
                        focusNode: descriptionFocus,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            hintText: 'Enter Description For Task',
                            border: InputBorder.none),
                        onSubmitted: (value){
                          if(value != null){
                            if(taskId != -1){
                              databaseHelper.updateTask(taskId,titleController.text,value);
                            }
                          }
                          todoFocus.requestFocus();
                        },
                      ),
                    ),
                  ),

                  FutureBuilder(
                      initialData: [],
                     future: databaseHelper.getAllTodos(taskId),
                      builder: (context, snapshot) {
                       return Visibility(
                         visible: contentVisibility,
                         child: Expanded(
                           child: ScrollConfiguration(
                             behavior: MyScrollBehavior(),
                             child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        //Switch it to done
                                        updateTodoItem(snapshot,index);

                                        setState(() {
                                          if(taskId != -1){
                                            databaseHelper.updateTask(taskId,titleController.text,descriptionController.text);
                                          }
                                        });
                                      },
                                      child: TodoWidget(
                                        text: snapshot.data[index].title,
                                        isDone: snapshot.data[index].isDone == 0? false:true,
                                      ),
                                    );
                                  },
                              ),
                           ),
                         ),
                       );
                      },
                  ),
                  Visibility(
                    visible: contentVisibility,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: AppUtils.pagePadding),
                      child: Row(
                        children: [
                          widgetsHelper.checkedIcon(false),
                             Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  focusNode: todoFocus,
                                  onSubmitted: (value) async {
                                    if (value != "") {
                                      if (taskId != -1) {
                                        TodoModel todoModel = TodoModel(
                                            title: value,
                                            isDone: 0,
                                            taskId: taskId
                                        );
                                        await databaseHelper.insertTodo(todoModel);
                                        print("New Todo Added");
                                        setState(() {

                                        });
                                      }
                                    }
                                  },
                                decoration: InputDecoration(
                                  hintText:"Enter Todo item...." ,
                                  border: InputBorder.none
                                ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Visibility(
            visible: contentVisibility,
            child: CustomFloatingActionButton(
              startColor: 0xFFFE3577,
              endColor: 0xFFFE3577,
              radius: AppUtils.floatButtonRadius,
              icon: 'delete_icon.png',
              paddingRight: 24.0,
              onClicked: () async {
                if(taskId != null){
               await databaseHelper.deleteTask(taskId);
               await databaseHelper.deleteTodo(taskId);
               Navigator.pop(context);
                }
              },
            ),
          )
        ]),
      ),
    );
  }

  void updateTodoItem(snapshot,index){
    snapshot.data[index].isDone == 0 ? databaseHelper.updateTodo(snapshot.data[index].id,1)
        : databaseHelper.updateTodo(snapshot.data[index].id,0);

  }
}
