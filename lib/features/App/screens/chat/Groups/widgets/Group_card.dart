
import 'package:flutter/material.dart';
import 'package:graduateproject/features/App/screens/chat/utill/date_time.dart';
import '../../models/group_model.dart';
import '../Group_screen.dart';

class Group_Card extends StatelessWidget {
  const Group_Card({super.key, required this.chatGroup});
  final ChatGroup chatGroup;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
          context, MaterialPageRoute(
          builder: (context) => Group_screen(
            chatGroup: chatGroup,
          ),
        ),
        ),
        leading: CircleAvatar(
          child: Text(chatGroup.name.characters.first),
        ),
        title: Text(chatGroup.name),
        subtitle: Text(chatGroup.lastMessage == "" ?"No Messages For Now" : chatGroup.lastMessage ,maxLines: 1,),
        trailing: Text(myDateTime.dateAndTime(chatGroup.lastMessageTime)),
      ),
    );
  }
}
