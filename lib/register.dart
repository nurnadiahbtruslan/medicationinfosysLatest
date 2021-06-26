import 'package:medicationinfosys/login.dart';
import 'package:medicationinfosys/loading.dart';
import 'package:flutter/material.dart';
import 'package:medicationinfosys/auth.dart';
import 'package:medicationinfosys/constant.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
            backgroundColor: Colors.orange[100],
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.amber,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  )),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Medinfo",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Email'),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                SizedBox(height: 15.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Password'),
                                  obscureText: true,
                                  validator: (val) => val.length < 6
                                      ? 'Enter a password 6+ chars long'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                                SizedBox(height: 15.0),
                                RaisedButton(
                                    color: Colors.yellow[800],
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .registerWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'please supply a valid email';
                                            loading = false;
                                          });
                                        }
                                      }
                                    }),
                                SizedBox(height: 12.0),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Text('Already have an account ?'),
                            FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                'Log In',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                //signup screen
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignIn()));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))
                      ],
                    ),
                  ]),
            ),
          );
  }
}