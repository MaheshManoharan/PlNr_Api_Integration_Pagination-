import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  const UserAvatar({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 52,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 59,
        backgroundImage: Image.network(imageUrl).image,
      ),
    );
  }
}