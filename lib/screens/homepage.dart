import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/apputils.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screens/taskpage.dart';
import 'package:todo/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F6),
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(AppUtils.pagePadding,
              AppUtils.pagePadding, AppUtils.pagePadding, 0.0),
          child: Stack(
            // put views above each other
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0),
                    child: Image(
                      image: AssetImage('${AppUtils.imagesDirectory}logo.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getAllTasks(),
                      builder: (context, snapshot){
                        return ScrollConfiguration(
                          behavior: MyScrollBehavior(),
                          child: ListView.builder(
                            itemCount: listSize(snapshot.data.length),
                              itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                 onClicked(snapshot.data.length, snapshot, index);
                                },
                                child: _taskCardWidget(snapshot, index),
                              );
                              },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              CustomFloatingActionButton(
                startColor: 0xFF7349FE,
                endColor: 0xFF643FD8,
                radius: AppUtils.floatButtonRadius,
                icon: 'add_icon.png',
                onClicked: () async{
                  onClicked(0,null,null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  String getTheTitle(String title){
   return title.trim() == "" ? "(Unnamed Task)" : title;
  }

  String getTheDesc(String desc){
    return desc.trim() == "" ? "No Description Added" : desc;
  }

  int listSize(int size){
    return size <= 0 ? 1 : size;
  }

  TaskCardWidget _taskCardWidget(snapshot,index){
    if(snapshot.data.length <= 0){
      return  TaskCardWidget(
        title: 'Get Started',
        description: 'Hello User! Welcome to WHAT_TODO app, this is a default task that you can edit or delete to start using the app.',
      );
    }
    return TaskCardWidget(
      title: getTheTitle(snapshot.data[index].title),
      description: getTheDesc(snapshot.data[index].description),
    );
  }

  void onClicked(int length,snapshot,index) async{
    if(length <= 0){
      {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskPage(task: null)),
        ).then((value) {
          setState(() {}); //only set the state again
        });
    }
  }else{
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskPage(
                task : snapshot.data[index])
        ),
      ).then((value) {
        setState(() {}); //only set the state again
      });
    }
}
}


