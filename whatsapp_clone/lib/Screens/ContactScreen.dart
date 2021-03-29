import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/ButtonCard.dart';
import 'package:whatsapp_clone/CustomUI/CustomContactCard.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/Screens/NewGroupSelectScreen.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<ChatModel> contacts = [
    ChatModel(name: "Anu Agarwal", status: "Hey! there using Whatapps"),
    ChatModel(name: "Debanshu Datta", status: "Hey! there using Whatapps"),
    ChatModel(name: "Debanshu Mutt", status: "Hey! there using Whatapps"),
    ChatModel(name: "Sakshi Gupta", status: "Hey! there using Whatapps"),
    ChatModel(name: "Arpit Mishra", status: "Hey! there using Whatapps"),
    ChatModel(name: "Ashutosh Verma", status: "Hey! there using Whatapps"),
    ChatModel(name: "Ayush Bhargav", status: "Hey! there using Whatapps"),
    ChatModel(name: "Akash Rnajan", status: "Hey! there using Whatapps"),
    ChatModel(name: "Anu Agarwal", status: "Hey! there using Whatapps"),
    ChatModel(name: "Sakshi Gupta", status: "Hey! there using Whatapps"),
    ChatModel(name: "Arpit Mishra", status: "Hey! there using Whatapps"),
    ChatModel(name: "Ashutosh Verma", status: "Hey! there using Whatapps"),
    ChatModel(name: "Ayush Bhargav", status: "Hey! there using Whatapps"),
    ChatModel(name: "Akash Rnajan", status: "Hey! there using Whatapps"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selected Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "277 contacts",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Invite Friend"),
                value: "Invite Friend",
              ),
              PopupMenuItem(
                child: Text("Contacts"),
                value: "Contacts",
              ),
              PopupMenuItem(
                child: Text("Refresh"),
                value: "Refresh",
              ),
              PopupMenuItem(
                child: Text("Help"),
                value: "Help",
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => NewGroupSelectScreen()));
              },
              child: ButtonCard(
                icon: Icons.group,
                name: "New Group",
              ),
            );
          } else if (index == 1) {
            return ButtonCard(icon: Icons.person_add, name: "New Contact");
          } else {
            return CustomContactCard(contact: contacts[index - 2]);
          }
        },
      ),
    );
  }
}
