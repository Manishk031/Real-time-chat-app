import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {

  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  // sign user in
    Future<UserCredential>signInWithEmailPassword(String email, password) async{
      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // save user info if it doesn't already exits
        _firestore.collection("Users").doc(userCredential.user!.uid).set(
            {
              'uid': userCredential.user!.uid,
              'email': email,
            }
        );
        return userCredential;
      } on FirebaseAuthException catch (e){
        throw Exception(e.code);
      }
    }

    // sign up
   Future<UserCredential> signUpWithEmailPassword(String email, password) async{
      try{
         // create user
        UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
        );

        // save user info in a separate doc
        _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
        );

        return userCredential;
      } on FirebaseAuthException catch (e){
        throw Exception(e.code);
      }
      }

   // sign out

       Future<void> signOut() async{
      return await _auth.signOut();
       }

       // deleted a  account
Future<void> deleteAccount() async{
    User? user = getCurrentUser();

    if(user != null){
      //deleted the user's data from firestore
      await _firestore.collection('Users').doc(user.uid).delete();

      //deleted the users data from firestore
      await user.delete();
    }
}

   // errors
    }