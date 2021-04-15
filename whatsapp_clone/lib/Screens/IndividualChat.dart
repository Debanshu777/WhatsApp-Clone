import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/CustomUI/OwnMessageCard.dart';
import 'package:whatsapp_clone/CustomUI/ReplyMessageCard.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChat extends StatefulWidget {
  const IndividualChat({Key key, this.chatModel, this.sourceModel})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceModel;
  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  IO.Socket socket;
  bool sendButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.1.102:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
    socket.emit("signIn", widget.sourceModel.id);
  }

  void sendMessage(String message, int sourceID, int targetID) {
    socket.emit("message", {
      "message": message,
      "sourceID": sourceID,
      "targetID": targetID,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/whatsapp_bg.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back),
                  CircleAvatar(
                    radius: 20,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup
                          ? "assets/groups.svg"
                          : "assets/person.svg",
                      color: Colors.white,
                      height: 36,
                      width: 36,
                    ),
                    backgroundColor: Colors.blueGrey[200],
                  )
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Last Seen Today at 4:am",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.videocam),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {},
              ),
              PopupMenuButton<String>(onSelected: (value) {
                print(value);
              }, itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      child: Text("View Contact"), value: "View Contact"),
                  PopupMenuItem(
                      child: Text("Media, links, and docs"),
                      value: "Media, links, and docs"),
                  PopupMenuItem(child: Text("Search"), value: "Search"),
                  PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification"),
                  PopupMenuItem(child: Text("Wallpaper"), value: "Wallpaper"),
                ];
              })
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                        OwnMessageCard(),
                        ReplyMessageCard(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: _controller,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        icon: Icon(Icons.emoji_emotions),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(5)),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 8, right: 5, left: 2),
                              child: CircleAvatar(
                                radius: 25,
                                child: IconButton(
                                  icon: sendButton
                                      ? Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        ),
                                  onPressed: () {
                                    if (sendButton) {
                                      sendMessage(
                                          _controller.text,
                                          widget.sourceModel.id,
                                          widget.chatModel.id);
                                      _controller.clear();
                                    }
                                  },
                                ),
                                backgroundColor: Color(0xFF128C7E),
                              ),
                            ),
                          ],
                        ),
                        show ? emojiSelect() : Container(),
                      ],
                    ),
                  )
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        print(emoji);
        setState(() {
          _controller.text = _controller.text + emoji.emoji;
        });
      },
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 278,
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.all(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomSheetIconCreation(
                        Icons.insert_drive_file, Colors.indigo, "Document"),
                    SizedBox(width: 40),
                    bottomSheetIconCreation(
                        Icons.camera_alt, Colors.pink, "Camera"),
                    SizedBox(width: 40),
                    bottomSheetIconCreation(
                        Icons.insert_photo, Colors.purple, "Gallery"),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomSheetIconCreation(
                        Icons.headset, Colors.orange, "Audio"),
                    SizedBox(width: 40),
                    bottomSheetIconCreation(
                        Icons.location_pin, Colors.teal, "Location"),
                    SizedBox(width: 40),
                    bottomSheetIconCreation(
                        Icons.person, Colors.blue, "Contact"),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget bottomSheetIconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
