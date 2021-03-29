import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Pages/CameraPage.dart';
import 'package:whatsapp_clone/Pages/ChatPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    double orjWidth = MediaQuery.of(context).size.width;
    double cameraWidth = orjWidth / 24;
    double yourWidth = (orjWidth - cameraWidth) / 4;

    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(child: Text("New Group"), value: "New Group"),
              PopupMenuItem(
                  child: Text("New Broadcast"), value: "New Broadcast"),
              PopupMenuItem(child: Text("Whatsapp Web"), value: "Whatsapp Web"),
              PopupMenuItem(
                  child: Text("Stared Message"), value: "Stared Message"),
              PopupMenuItem(child: Text("Settings"), value: "Settings"),
            ];
          })
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _controller,
          indicatorColor: Colors.white,
          labelPadding: EdgeInsets.symmetric(
              horizontal: (orjWidth - (cameraWidth + yourWidth * 3)) / 7),
          tabs: [
            Container(
              child: Tab(
                icon: Icon(Icons.camera_alt),
              ),
              width: cameraWidth,
            ),
            Container(
              child: Tab(
                text: "CHATS",
              ),
              width: yourWidth,
            ),
            Container(
              child: Tab(
                text: "STATUS",
              ),
              width: yourWidth,
            ),
            Container(
              child: Tab(
                text: "CALLS",
              ),
              width: yourWidth,
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        CameraPage(),
        ChatPage(),
        Text("Status"),
        Text("Call"),
      ]),
    );
  }
}
