import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plnr_api_integration_pagination/models/user_data.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.userItem});

  Datum userItem;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: widget.userItem.avatar,
              child: Image.network(widget.userItem.avatar)),
          ),
          Text("${widget.userItem.firstName} ${widget.userItem.lastName}",)
        ],
      ),
    );
  }
}
