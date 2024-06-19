import 'package:flutter/material.dart';

class EmptyListImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/empty_list.png', height: 200),
          SizedBox(height: 20),
          Text(
            'No Patients Found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
