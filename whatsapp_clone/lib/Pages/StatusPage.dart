import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/StatusPageCustomUI/OtherStatus.dart';
import 'package:whatsapp_clone/CustomUI/StatusPageCustomUI/OwnStatusCard.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: Icon(Icons.camera_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // SizedBox(
          //   height: 10,
          // ),
          OwnStatusCard(),
          label("Recent updates"),
          OtherStatus(
            name: "Sakshi",
            imageName: "assets/3.png",
            time: "Today at 01:12 pm",
          ),
          OtherStatus(
            name: "Debanshu",
            imageName: "assets/1.png",
            time: "Today at 01:12 pm",
          ),
          OtherStatus(
            name: "D Mutt",
            imageName: "assets/2.png",
            time: "Today at 01:12 pm",
          ),
          OtherStatus(
            name: "Anu",
            imageName: "assets/4.png",
            time: "Today at 01:12 pm",
          ),
          OtherStatus(
            name: "Sakshi",
            imageName: "assets/3.png",
            time: "Today at 01:12 pm",
          ),
          SizedBox(
            height: 10,
          ),
          label("View updates"),
          OtherStatus(
            name: "Anu",
            imageName: "assets/4.png",
            time: "Today at 01:12 pm",
          ),
          OtherStatus(
            name: "Sakshi",
            imageName: "assets/3.png",
            time: "Today at 01:12 pm",
          ),
        ],
      )),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 7,
        ),
        child: Text(
          labelName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
