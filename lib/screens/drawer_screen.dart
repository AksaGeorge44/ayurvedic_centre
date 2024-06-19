import 'dart:io';

import 'package:ayurvedic_centre/screens/branch_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:  ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("A"),
              
              accountEmail: Text("a@gmail.com")),

          ListTile(
            title: Text("Branch List"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BranchScreen()));
            },
          ),
          ListTile(
            title: Text("Treatment List"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BranchScreen()));

            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: (){
              exit(0);
              },
          ),
        ],
      ),
    );
  }
}
