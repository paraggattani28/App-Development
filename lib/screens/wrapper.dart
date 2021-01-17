import 'package:flutter/material.dart';
import 'package:project3/models/user.dart';
import 'package:project3/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:project3/screens/Home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
