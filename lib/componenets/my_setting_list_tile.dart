import'package:flutter/material.dart';

class MySettingListTile extends StatelessWidget{
  final String title;
  final  Widget action;
  final Color color;
  final Color textColor;
  const MySettingListTile({super.key,
    required this.title,
    required this.action,
    required this.color,
    required this.textColor
  });


  @override
  Widget build(BuildContext context) {
   return Container(
     decoration: BoxDecoration(
       color: color,
       borderRadius: BorderRadius.circular(12),
     ),
     margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         // title
         Text(
           "Dark Mode",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             color: textColor,
           ),
         ),

         // action
         action

       ],
     ),
   );
  }
}