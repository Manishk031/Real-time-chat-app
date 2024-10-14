
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat/models/message.dart';

class ChatServices {
  // GET INSTANCE OF FIRESTORE & AUTH
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GET USERS STREAM (LIST OF USERS EMAIL AND IDS)
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Go through each individual user
        final Map<String, dynamic> user = doc.data();
        // Return user data (e.g., email and ID)
        return user;
      }).toList();
    });
  }

  // GET ALL USERS STREAM EXCEPT BLOCKED USERS
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked(){
    final currentUser = _auth.currentUser;
    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {

      // GET BLOCKED USERS IDS
      final blockedUsersIds = snapshot.docs.map((doc) => doc.id).toList();

      // GET ALL USERS
      final usersSnapshot = await _firestore.collection('Users').get();

      // RETURN AS STREAM LIST, EXCLUDING CURRENT USER AND BLOCKED USERS.
     final userData = await Future.wait(
       // get all docs
         usersSnapshot.docs
         // excluding current user and blocked users
             .where((doc) =>
              doc.data()['email']!=currentUser.email &&
             !blockedUsersIds.contains(doc.id))
              .map((doc) async{
                // look at each users
                final userData = doc.data();
                // and their chat rooms
                final chatRoomID = [currentUser.uid, doc.id]..sort();
                //count the number of unread message
                final unreadMessageSnapshot = await _firestore
                .collection("chat_rooms")
                .doc(chatRoomID.join('_'))
                .collection("messages")
                .where('received ID', isEqualTo: currentUser.uid)
                .where('isRead',isEqualTo: false)
                .get();

                userData['unreadCount'] = unreadMessageSnapshot.docs.length;
                return userData;
         }).toList(),
          );
     return userData;
      });
  }


  // SEND MESSAGES
  Future<void> sendMessage(String receiverID, String message) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
      isRead: false,
    );

    // Construct chat room ID for two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // Sort the IDs (this ensures the chatRoomID is the same for any two people)
    String chatRoomID = ids.join('_');

    // Add new message to the database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // Construct a chat room ID for the 2 users
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

  // MARK MESSAGES AS READ
  Future<void> markMessagesAsRead(String receiverId) async{

    // get current user id
    final currentUserID = _auth.currentUser!.uid;

    // get chat room
    List<String> ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    // get unread message
    final unreadMessageQuery = _firestore.collection("chat_rooms")
        .doc(chatRoomID).collection("message")
        .where('receivedID', isEqualTo: currentUserID)
        .where('isRead', isEqualTo: false);

    final unreadMessageSnapshot = await unreadMessageQuery.get();

    // go through each message and mark as read

    for (var doc in unreadMessageSnapshot.docs){
      await doc.reference.update({'isRead': true});
    }
  }

  // REPORT USERS
  Future<void> reportUser(String messageId, String userId) async{
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy' : currentUser!.uid,
      'messageId' : messageId,
      'messageOwnerId' : userId,
      'timestamp' : FieldValue.serverTimestamp(),
    };
    await _firestore.collection('Report').add(report);
  }

  //BLOCKED USER
  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
     // This will notify listeners of changes
  }

  //UNBLOCKED USER
  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();// This will notify listeners of changes
  }

  //GET BLOCKED USERS STREAM
 Stream<List<Map<String, dynamic>>> getBlockedUserStream(String userId){
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('BLockedUsers')
        .snapshots()
        .asyncMap((snapshot) async{

          //get list of blocked user ids
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(
        blockedUserIds
        .map((id) => _firestore.collection('Users').doc(id).get()),
      );

      // return as a list
      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
 }
}
