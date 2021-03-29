import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/ButtonCard.dart';
import 'package:whatsapp_clone/CustomUI/CustomAvatarCard.dart';
import 'package:whatsapp_clone/CustomUI/CustomContactCard.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';

class NewGroupSelectScreen extends StatefulWidget {
  @override
  _NewGroupSelectScreenState createState() => _NewGroupSelectScreenState();
}

class _NewGroupSelectScreenState extends State<NewGroupSelectScreen> {
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
  List<ChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add Participants",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  if (contacts[index - 1].select == false) {
                    setState(() {
                      contacts[index - 1].select = true;
                      groups.add(contacts[index - 1]);
                    });
                  } else {
                    setState(() {
                      contacts[index - 1].select = false;
                      groups.remove(contacts[index - 1]);
                    });
                  }
                },
                child: CustomContactCard(contact: contacts[index - 1]),
              );
            },
          ),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: contacts.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    contacts[index].select = false;
                                    groups.remove(contacts[index]);
                                  });
                                },
                                child: CustomAvatarCard(
                                  contact: contacts[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
