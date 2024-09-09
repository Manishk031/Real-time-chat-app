import 'package:flutter/material.dart';
import 'package:real_time_chat/auth/auth_services.dart';
import 'package:real_time_chat/componenets/my_button.dart';
import 'package:real_time_chat/componenets/my_textfield.dart';

class LoginPage extends StatelessWidget{

  //email and pw controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to go to register page
   final void Function()? onTap;

   LoginPage ({super.key,
     required this.onTap});

   // login method

  void login(BuildContext context) async{
    //auth services
     final authService = AuthServices();

     // try login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }
    //catch any error

    catch (e){
      showDialog(
            context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     // logo

                     Icon(
                       Icons.message,
                       size: 50,
                       color: Theme.of(context).colorScheme.primary,
                     ),
                     const SizedBox(height: 50),

                     // message to see every one

                     Text(
                       "welcome back, you've been missed!",
                       style: TextStyle(
                         fontSize: 16,
                         color: Theme.of(context).colorScheme.primary,
                       ),
                     ),
                     const SizedBox(height: 25),

                     // email id text
                     
                     MyTextField(
                         hintText: "Email",
                         obscureText: false,
                         controller: _emailController,
                     ),
                     const SizedBox(height: 10),

                     // password text

                     MyTextField(
                       hintText: "Password",
                       obscureText: true,
                       controller: _pwController,
                     ),
                     const SizedBox(height: 25),

                     // login button

                     MyButton(
                         text: "Login",
                         onTap: () => login(context),
                     ),
                     const SizedBox(height: 10),

                     //register now
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Not a member?",
                         style: TextStyle(color: Theme.of(context).colorScheme.primary),
                         ),
                         GestureDetector(
                           onTap: onTap,
                           child: Text("Register now ",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                               color: Theme.of(context).colorScheme.primary
                           ),
                           ),
                         ),
                       ],
                     ),
                   ],
        ),
      ),
    );
  }
}