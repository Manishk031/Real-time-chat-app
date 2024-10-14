import 'package:flutter/material.dart';
import '../Pages/setting_page.dart';
import '../services/auth/auth_services.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  // logout
  void logout(BuildContext context){
    final auth = AuthServices();
    auth.signOut();

    // then navigation to initial route (Auth Gate / login Register page
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (route) => false);


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
            // app logo
            Center(
             child: Padding(
              padding: const EdgeInsets.only(
                left: 120.0,
                right: 120,
                top: 120,
                bottom: 60,
              ),
               child: Image.asset(
                 'lib/images/message.png',
                 color: Theme.of(context).colorScheme.primary,
               ),
               ),
            ),

            // divider line
            Divider(
              color:  Theme.of(context).colorScheme.secondary,
              indent: 25,
              endIndent: 25,
            ),

            // home list  title
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10),
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
          leading: const Icon(Icons.logout),
          onTap: () => logout(context),
        ),
        ),
      ],
    ),
  );

  }
}