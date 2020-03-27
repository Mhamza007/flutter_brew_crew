import 'package:flutter/material.dart';
import 'package:flutter_brew_crew/model/brew.dart';
import 'package:flutter_brew_crew/screens/home/preference_form.dart';
import 'package:flutter_brew_crew/services/auth.dart';
import 'package:flutter_brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showPreferenceSPannel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: PreferenceForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('SignOut'),
            ),
            FlatButton.icon(
              onPressed: () => _showPreferenceSPannel(),
              icon: Icon(Icons.settings),
              label: Text('Brew Preference'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
