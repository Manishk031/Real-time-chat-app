import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_time_chat/models/message.dart';
class ChatServices{

  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
/*
     List<Map>String.dynamic>=
     {
     'email': test@hgmail.com,
     'id': ..
     },
      {
       'email': test@hgmail.com,
       'id': ..
       },
      */

    Stream<List<Map<String,dynamic>>> getUsersStream(){
      return _firestore.collection("Users").snapshots().map((snapshot) {
        return snapshot.docs.map((doc){
          //go through each individual user
          final user  =  doc.data();

          //return user
          return user;
        }).toList();
      });
    }

  //send message
    Future<void>sendMessage(String receiverID, message) async{

      // get current user info
      final String currentUserID = _auth.currentUser!.uid;
      final String currentUserEmail = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

      // create a new message

      Message newMessage = Message(
          senderID: currentUserID,
          senderEmail: currentUserEmail,
          receiverID: receiverID,
          message: message,
          timestamp: timestamp
      );

      // construct chat roomID for two user (sorted to ensure uniqueness)

      List<String> ids = [currentUserID, receiverID];
      ids.sort(); // sort the ids(this ensure the chatroomID is the same for any 2 people)
      String chatRoomID = ids.join('_');

      // add new message to database
      await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
    }

      //get message

    Stream<QuerySnapshot> getMessages(String userID, otherUserID){
      //construct a chatRoom ID for the 2 user
      List<String> ids = [userID, otherUserID];
      ids.sort();
      String chatRoomID = ids.join('_');

      return _firestore
          .collection("chat_rooms")
          .doc(chatRoomID)
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots();
    }

}