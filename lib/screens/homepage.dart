import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/apputils.dart';
import 'package:todo/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    child: ListView(
                      children: [
                        TaskCardWidget(
                          title: "Get Started",
                          description:
                              "Hello User! Welcome to WHAT_TODO app, this is a default task that you can edit or delete to start using the app.",
                        ),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                      ],
                    ),
                  ),
                ],
              ),
              CustomFloatingActionButton(
                backgroundColor: 0xFF7349FE,
                radius: AppUtils.floatButtonRadius,
                icon: 'add_icon.png',
                onClicked: () {
                  Navigator.pushNamed(context, AppUtils.taskPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
