import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/CustomCard.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Anu",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Sogaye lagta hai"),
    ChatModel(
        name: "Sakshi",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Party karooo"),
    ChatModel(
        name: "Lassan",
        icon: "groups.svg",
        isGroup: true,
        time: "10:00 pm",
        currentMessage: "Party karooo"),
    ChatModel(
        name: "Debanshu",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Enjoy"),
    ChatModel(
        name: "D Mutt",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Kaisa Hai bhai tum"),
    ChatModel(
        name: "Friends",
        icon: "groups.svg",
        isGroup: true,
        time: "4:00 am",
        currentMessage: "Helloooooo"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(chatModel: chats[index]),
      ),
    );
  }
}
