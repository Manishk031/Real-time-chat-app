import 'package:flutter/material.dart';
import 'package:real_time_chat/componenets/user_tile.dart';
import 'package:real_time_chat/main.dart';
import 'package:real_time_chat/services/auth/auth_services.dart';
import 'package:real_time_chat/services/chat/chat_services.dart';

class BlockedUserPage extends StatelessWidget{
   BlockedUserPage({super.key});

  // Chat & Auth services
  final ChatServices chatServices = ChatServices();
  final AuthServices authServices = AuthServices();

  // SHOW CONFIRM UNBLOCKED BOX
   void _showUnblocked(BuildContext context, String userId){
     showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: const Text("Unblock User"),
           content: const Text("Are you sure you want to unblock this user?"),
           actions: [
             //cancel button
             TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text("Cancel"),
             ),
             //unblocked button
             TextButton(
               onPressed: () {
                 chatServices.unblockUser(userId);
                 Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text("User unblocked")));
               },
               child: const Text("Cancel"),
             ),
           ],
         ),
     );
   }

  @override
  Widget build(BuildContext context) {
    // GET CURRENT USERS ID
    String userId = authServices.getCurrentUser()!.uid;

    //UI
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOCKED USERS"),
        actions:[],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatServices.getBlockedUserStream(userId),
        builder: (context, snapshot){

          if(snapshot.hasError){
            return const Center(
              child: Text("Error loading.."),
            );
          }
          // loading..
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final blockedUsers = snapshot.data??[];

          // no users
          if(blockedUsers.isEmpty){
            return const Center(child: Text("No blocked users"),);
          }
          // loading complete
          return ListView.builder(
            itemCount: blockedUsers.length ,
            itemBuilder:(context, index){

            final user = blockedUsers[index];
            return UserTile(text: user["email"],
                onTap: () => _showUnblocked(context, user['uid']),
            );
          },);
        },
      ),
    );
  }
}
