import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/componenets/my_setting_list_tile.dart';
import 'package:real_time_chat/services/auth/auth_services.dart';
import 'package:real_time_chat/themes/theme_provider.dart';

import 'blocked_users.dart';


class SettingPage extends StatelessWidget{
  const SettingPage({super.key});

  //confirm user wants to deleted account

   void userWantsToDeletedAccount(BuildContext context) async{
     //store the user decision in this boolean
     bool confirm = await showDialog(
         context: context,
         builder: (context){
           return AlertDialog(
             title: const Text("Confirm Deleted"),
             content: const Text(
               "This will delete your account permanently. Are you sure want to proceed?"
             ),
           actions:[
             MaterialButton(
                 onPressed: () => Navigator.of(context).pop(false),
                 color: Theme.of(context).colorScheme.inversePrimary,
                 child:Text(
                     'Cancel',
                 style: TextStyle(
                   color: Theme.of(context).colorScheme.background),
                 ),
           ),

             // confirm button-------
             MaterialButton(
               onPressed: () => Navigator.of(context).pop(true),
               color: Theme.of(context).colorScheme.inversePrimary,
               child:Text(
                 'Deleted',
                 style: TextStyle(
                     color: Theme.of(context).colorScheme.background),
               ),
             ),
           ],
           );
         },
     )??
     false;
     // if the user confirmed, proceed with deletion

     if(confirm){
       try{
         Navigator.pop(context);
         await AuthServices().deleteAccount();
       }catch(e){
         //handle
       }
     }
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [

              // Dark mode toggle
              MySettingListTile(
              title: "Dark Mode",
              action: CupertinoSwitch(
                onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
              ),
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.inversePrimary,
        ),

              //Blocked User
              MySettingListTile(
                  title: "Blocked User",
                  action:  IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlockedUserPage())),
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).colorScheme.primary,
                ),
              ),
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.inversePrimary,
              ),

              // deleted button
              MySettingListTile(
                  title: "Deleted account",
                  action: IconButton(
                      onPressed: () => userWantsToDeletedAccount(context),
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  ),
                  color: Colors.red.shade500,
                textColor: Theme.of(context).colorScheme.tertiary,
              )

            ],
          ),
        ),
      ),
    );

  }
}