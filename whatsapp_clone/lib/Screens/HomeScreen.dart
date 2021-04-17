import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/Pages/CameraPage.dart';
import 'package:whatsapp_clone/Pages/ChatPage.dart';
import 'package:whatsapp_clone/Pages/StatusPage.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.chatModels, this.sourceChat}) : super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  final int _cameraTapIndex = 0;
  double _appBarTop = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    _controller.animation.addListener(_handleAppBarAnimation);
  }

  double _getappBarHeight(BuildContext context) {
    final double kTabHeight = 46.0;
    final double kTextAndIconTabHeight = 72.0;
    final double inicatorHeight = 2.0;

    return kToolbarHeight +
        kTabHeight +
        inicatorHeight +
        MediaQuery.of(context).padding.top;
  }

  _handleAppBarAnimation() {
    // This animation calculation will only work if camera tab index == 0
    if (_controller.animation.value <= 1.0 && _cameraTapIndex == 0) {
      final value = _controller.animation.value;
      final appBarHeight = _getappBarHeight(context);

      setState(() {
        _appBarTop = -(1 - value) * appBarHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final marginTopRaw = _appBarTop +
        _getappBarHeight(context) -
        MediaQuery.of(context).padding.top;
    final marginTop = marginTopRaw > 0 ? marginTopRaw : 0.0;

    double orjWidth = MediaQuery.of(context).size.width;
    double cameraWidth = orjWidth / 24;
    double yourWidth = (orjWidth - cameraWidth) / 5;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: marginTop >= 48 ? marginTop : 0,
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(marginTop),
          child: marginTop >= 48
              ? TabBar(
                  isScrollable: true,
                  controller: _controller,
                  indicatorColor: Colors.white,
                  labelPadding: EdgeInsets.symmetric(
                      horizontal:
                          (orjWidth - (cameraWidth + yourWidth * 3)) / 8),
                  tabs: [
                    WillPopScope(
                      // ignore: missing_return
                      onWillPop: () {
                        // shift to the right-handed-side tap;
                        _controller.animateTo(_cameraTapIndex + 1);
                      },
                      child: Container(
                        child: Tab(
                          icon: Icon(Icons.camera_alt),
                        ),
                        width: cameraWidth,
                      ),
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
                )
              : Container(),
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        CameraPage(),
        ChatPage(
          chatModels: widget.chatModels,
          sourceModel: widget.sourceChat,
        ),
        StatusPage(),
        Text("Call"),
      ]),
    );
  }
}
