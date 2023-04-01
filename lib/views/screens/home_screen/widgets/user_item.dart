import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../models/user_data.dart';
import 'user_avatar.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    Key? key,
    required this.userItem,
  }) : super(key: key);

  final Datum userItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        10,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 49, 91, 231),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                userItem.id.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          UserAvatar(imageUrl: userItem.avatar),
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            alignment: Alignment.centerLeft,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 1200),
              child: Text(
                "${userItem.firstName} ${userItem.lastName}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff4c53a5),
                  fontWeight: FontWeight.bold,
                ),),
                builder: (context, value, child) 
                {
                  return Transform.translate(offset: Offset(value * 100, 0.0), child: child,);
                },
              ),
            ),
          
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              userItem.email,
              style: TextStyle(fontSize: 15, color: Color(0xff4c53a5)),
            ),
          )
        ],
      ),
    );
  }
}
