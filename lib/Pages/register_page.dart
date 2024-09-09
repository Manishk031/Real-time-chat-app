import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../componenets/my_button.dart';
import '../componenets/my_textfield.dart';
import '../services/auth/auth_services.dart';

class RegisterPage extends StatelessWidget{

  //email and pw controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;


   RegisterPage ({super.key,required this.onTap});

   // register
  void register(BuildContext context){
    final auth =AuthServices();

    // password match == create user
    if(_pwController.text == _confirmController.text){
      try{
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text,);
      }catch(e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );

      }
    }
    // password don't match -> tell user to fix
    else{
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
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
              "Let's create account for you",
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

            // confirm password

            MyTextField(
              hintText: " Confirm Password",
              obscureText: true,
              controller: _confirmController,
            ),
            const SizedBox(height: 25),

            // login button

            MyButton(
                text: "Register",
                onTap: () => register(context),
            ),
            const SizedBox(height: 10),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now ",
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