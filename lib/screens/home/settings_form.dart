import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value.isEmpty ? 'Please enter name' : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars
                        .map(
                          (sugar) => DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _currentSugars = value),
                  ),
                  Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      onChanged: (value) =>
                          setState(() => _currentStrength = value.round())),
                  RaisedButton(
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xffd28e0c),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentSugars ?? userData.sugars,
                              _currentStrength ?? userData.strength);
                        }
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
