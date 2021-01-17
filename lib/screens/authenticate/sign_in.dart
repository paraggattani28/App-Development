import 'package:flutter/material.dart';
import 'package:project3/screens/authenticate/register.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/shared/loading.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:project3/screens/home/home.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                          Wrap(
                            children: <Widget>[
                              SignInButton(
                                Buttons.Facebook,
                                mini: true,
                                onPressed: () {},
                              ),
                              SignInButton(
                                Buttons.LinkedIn,
                                mini: true,
                                onPressed: () {},
                              ),
                              SignInButtonBuilder(
                                icon: Icons.email,
                                text: "Ignored for mini button",
                                mini: true,
                                onPressed: () {},
                                backgroundColor: Colors.cyan,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Username or email',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              labelText: 'Username or email',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your Email address' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            validator: (val) => val.length < 8
                                ? 'Enter a password 8+ characters long'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await _auth.resetPassword(email);
                              }
                              error =
                                  'Reset password link has been sent to your email!';
                            },
                            textColor: Colors.blueAccent,
                            child: Text('Forgot Password',
                                style: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(height: 10.0),
                          new Container(
                            width: double.infinity,
                            height: 55,
                            padding: const EdgeInsets.only(top: 15.0),
                            child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Colors.pinkAccent,
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(
                                      () {
                                        error = 'Coludn\'t Sign In';
                                        loading = false;
                                      },
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                    print(email);
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New to Stay.fit ?',
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                              SizedBox(width: 5.0),
                              FlatButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Register',
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
            ),
          );
  }
}
