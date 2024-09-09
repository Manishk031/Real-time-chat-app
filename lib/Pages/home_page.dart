import 'dart:js';

import 'package:flutter/material.dart';
import 'package:real_time_chat/auth/auth_services.dart';
import 'package:real_time_chat/componenets/my_drawer.dart';
import 'package:real_time_chat/services/auth/auth_services.dart';
import 'package:real_time_chat/services/chat/chat_services.dart';

import '../componenets/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget{
   HomePage ({super.key});


  // chat & auth services

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar:  AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

     // build a list of users except fot the current logged in user
     Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatServices.getUsersStream(),
        builder: (context, snapshot){
          // error
          if(snapshot.hasError){
            return const Text("Error");
          }


          // loading

          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Text("Loading..");
          }

          //list
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context))
                .toList(),
          );

        },
    );
    }

    // build individual list title for user
     Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    // display all user except current user.

       if(userData["email"]!= _authServices.getCurrentUser()!. email){

         return UserTile(
           text: userData["email"],
           onTap: () {
             // tapped on a user -> go to chat page
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) =>  ChatPage(
                   receiverEmail: userData["email"],
                   receiverID:  userData["uid"],
                 ),
               ),
             );
           },
         );
       }else{
          return Container();
       }
     }
}