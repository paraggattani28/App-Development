import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project3/models/user.dart';
import 'package:project3/services/database.dart';
import 'package:project3/screens/constants.dart';

class EditForm extends StatefulWidget {
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  String _currentName;
  String _currentMob;
  String _currentEmail;
  String _currentImage;
  String _currentAddress;
  bool _currentRegister;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update User Details',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.username,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your username' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.mobile,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your mobile number' : null,
                    onChanged: (val) => setState(() => _currentMob = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.address,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your address' : null,
                    onChanged: (val) => setState(() => _currentAddress = val),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pinkAccent,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentEmail ?? snapshot.data.email,
                            _currentMob ?? snapshot.data.mobile,
                            _currentAddress ?? snapshot.data.address,
                            _currentName ?? snapshot.data.username,
                            _currentImage ?? snapshot.data.imageLink,
                            _currentRegister ?? snapshot.data.register,
                          );
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          }
        });
  }
}
