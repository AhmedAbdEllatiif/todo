import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/apputils.dart';
import 'package:todo/widgets.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: AppUtils.pagePadding),
                      child: Row(
                        children: [
                          InkWell( //To show ripple with icon clicked
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Image(
                                    image: AssetImage('${AppUtils.imagesDirectory}back_arrow_icon.png')
                                )
                            ),
                          ),
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20.0,0.0,5.0,0.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Enter Task Title",
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF211551)
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,horizontal: AppUtils.pagePadding),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter Description For Task',
                            border: InputBorder.none
                        ),
                      ),
                    ),

                    TodoWidget(isDone: true),
                    TodoWidget(text: 'Ahmed is Awesome',isDone: false)
                  ],
                )
            ),

            CustomFloatingActionButton(
                backgroundColor: 0xFFFE3577,
                radius: AppUtils.floatButtonRadius,
                icon: 'delete_icon.png',
                paddingRight: 24.0,
                onClicked: (){},
            )
          ]
        ),
      ),
    );
  }
}
