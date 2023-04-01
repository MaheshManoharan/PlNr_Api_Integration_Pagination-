import 'dart:math';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  const UserAvatar({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var generatedColor = Random().nextInt(Colors.primaries.length);
    Colors.primaries[generatedColor];

    return CircleAvatar(
      radius: 56,
      backgroundColor:
          Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: CircleAvatar(
        radius: 52,
        backgroundImage: Image.network(imageUrl).image,
      ),
    );
  }
}
