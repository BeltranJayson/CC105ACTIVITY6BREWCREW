import 'package:coffeebrewcrew/models/brew.dart';
import 'package:coffeebrewcrew/screens/home/settings_form.dart';
import 'package:coffeebrewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeebrewcrew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffeebrewcrew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60.0),
          child: SettingsForm(),
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
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed:() async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label:Text('logout'),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label:Text('Settings')
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Asset/images/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: BrewList()),
      ),
    );
  }
}
