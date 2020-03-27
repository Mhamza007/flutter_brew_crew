import 'package:flutter/material.dart';
import 'package:flutter_brew_crew/screens/authenticate/authenticate.dart';
import 'package:flutter_brew_crew/screens/home/home.dart';
import 'package:flutter_brew_crew/model/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // retuen either home or authenticate widget
    return user!= null ? Home() : Authenticate();
    // if(user == null) {
    //   return Authenticate();
    // } else {
    //   return 
    //   Home();
    // }
  }
}