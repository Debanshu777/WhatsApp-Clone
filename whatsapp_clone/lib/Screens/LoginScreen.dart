import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/ButtonCard.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
        id: 1,
        name: "Anu",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Sogaye lagta hai"),
    ChatModel(
        id: 2,
        name: "Sakshi",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Party karooo"),
    ChatModel(
        id: 3,
        name: "Debanshu",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Enjoy"),
    ChatModel(
        id: 4,
        name: "D Mutt",
        icon: "person.svg",
        isGroup: false,
        time: "4:00 am",
        currentMessage: "Kaisa Hai bhai tum"),
    // ChatModel(
    //     name: "Friends",
    //     icon: "groups.svg",
    //     isGroup: true,
    //     time: "4:00 am",
    //     currentMessage: "Helloooooo"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => HomeScreen(
                          chatModels: chatModels,
                        )));
          },
          child: ButtonCard(
            name: chatModels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
