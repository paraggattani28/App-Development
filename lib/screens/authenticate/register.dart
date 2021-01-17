import 'package:flutter/material.dart';
import 'package:project3/screens/authenticate/sign_in.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/shared/loading.dart';
import 'package:project3/screens/home/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayName = TextEditingController();

  bool loading = false;
  String email = '';
  String mobile = '';
  String address = '';
  String password = '';
  String error = '';
  String username = '';
  String imageLink = null;
  bool register = false;

  bool _isSuccess;
  String _userEmail;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/logo.png'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Text(
                          'Stay.fit ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\"Dont stop till you drop!\"',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Register Now !!',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Email address' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          validator: (val) => val.length < 8
                              ? 'Enter a password 8+ characters long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter a valid user name' : null,
                          onChanged: (val) {
                            setState(() => username = val);
                          },
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          validator: (val) => val.length < 10
                              ? 'Enter a mobile 10+ digits long'
                              : null,
                          onChanged: (val) {
                            setState(() => mobile = val);
                          },
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter a valid address' : null,
                          onChanged: (val) {
                            setState(() => address = val);
                          },
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        new Container(
                          width: double.infinity,
                          height: 55,
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print(username);
                                print(address);
                                print(mobile);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email,
                                        password,
                                        mobile,
                                        address,
                                        username,
                                        imageLink,
                                        register);
                                if (result == null) {
                                  setState(() => error = 'Not Signed Up');
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                }
                              }
                            },
                            color: Colors.pinkAccent,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already have an account ?',
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                            SizedBox(width: 5.0),
                            FlatButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignIn(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
