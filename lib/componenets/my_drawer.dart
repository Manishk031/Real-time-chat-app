import 'package:flutter/material.dart';

import '../Pages/setting_page.dart';
import '../auth/auth_services.dart';
import '../services/auth/auth_services.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});
  void logout(){
    //get auth services
    final auth = AuthServices();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
  return Drawer(
    backgroundColor: Theme.of(context).colorScheme.background,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.message,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            // home list  title
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListTile(
                title: const Text("H O M E"),
                leading: const Icon(Icons.home),
                onTap: (){
                  // pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),


            //setting   list title
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("S E T T I N G"),
                leading: const Icon(Icons.settings),
                onTap: () {
                  // pop the drawer
                  Navigator.pop(context);

                  // navigation to setting page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(),
                  ));
                },
              ),

            ),
          ],
        ),

        // logout list title
        Padding(padding:
        const EdgeInsets.only(left: 25.0,bottom: 25),
        child: ListTile(
          title: const Text("L O G O U T"),
          leading: Icon(Icons.logout),
          onTap: logout,
        ),
        ),
      ],
    ),
  );

  }
}