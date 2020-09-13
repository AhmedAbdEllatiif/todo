import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'apputils.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String description;

  TaskCardWidget({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Text(
            title ?? "(Unnamed Task)", //title== null ? "Un Titled" : title
            style: TextStyle(
                color: Color(0xFF211551),
                fontWeight: FontWeight.bold,
                fontSize: 22.0),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            description ?? "No Description Added",
            //description== null ? "No Description Added" : description
            style: TextStyle(
                color: Color(0xFF86829D),
                fontSize: 16.0,
                height: 1.5 //space between every line
                ),
          ),
        )
      ]),
    );
  }
}






class CustomFloatingActionButton extends StatelessWidget {

  final String icon;
  final int backgroundColor;
  final double radius;
  final double paddingRight;
  final double paddingBottom;
  final VoidCallback  onClicked;

  CustomFloatingActionButton({this.backgroundColor,this.radius,this.icon,this.paddingRight,this.paddingBottom,this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: paddingBottom??24.0,
      right: paddingRight??0.0,
      child: GestureDetector(
        onTap: this.onClicked,
        child: Container(
          width: 60.0,
          height: 60.0,
          child: Image(
            image: AssetImage('${AppUtils.imagesDirectory}$icon'),
          ),
          decoration: BoxDecoration(
              color: Color(backgroundColor??0xFF7349FE),
              borderRadius: BorderRadius.circular(radius??20.0)),
        ),
      ),
    );
  }
}



class TodoWidget extends StatelessWidget {

  final String text;
  final bool isDone;
  TodoWidget({this.text,@required this.isDone});


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
        padding: EdgeInsets.fromLTRB(
            AppUtils.pagePadding,
          0.0,
          AppUtils.pagePadding,
          15.0
        ),
        child: Row(
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                  color: isDone? Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone ? null : Border.all(
                    color: Color(0xFF86829D),
                    width: 1.5
              )
              ) ,

              child: Image(
                image: AssetImage('${AppUtils.imagesDirectory}check_icon.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 0.0
              ),
                child: Text(
                    text??'Todo item',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isDone? Color(0xFF211551) : Color(0xFF86829D),
                    fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

