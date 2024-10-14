import 'package:flutter/material.dart';

class UserTile extends StatelessWidget{
  final String text;
  final void Function()? onTap;
  final int unreadMessageCount;

  const UserTile({
  super.key,
  required this.text,
  required this.onTap,
  this.unreadMessageCount = 0,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                // icon
                const Icon(Icons.person),
                const SizedBox(width: 20),


                // user name
                Text(text),
              ],
            ),
            // unread message count
             unreadMessageCount > 0
            ? Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                        unreadMessageCount.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight:FontWeight.bold
                    ),
                    ),
              ),
            )
                 :Container(),
          ],
        ),
      ),
    );
  }
}