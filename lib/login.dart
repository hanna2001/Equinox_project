import 'package:equinox_project/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email, password;
  String text = 'Sign in';
  String textAlt = 'Sign up';
  String textAltAdd = 'Don\'t have an account?';
  String buttonText = 'Login';
  bool signup;

  @override
  Widget build(BuildContext context) {
    if(signup==null)
      setState(() {
        signup=true;
      });

    return Scaffold(
        appBar: AppBar(
          title:  Text(
            'Mayday',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/icon.png',
                  width: 80,
                  height: 80,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(

                    cursorColor: Colors.black,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value){
                      setState(() {
                        email = value.trim();
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    cursorColor: Colors.black,
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    onChanged: (value){
                      setState(() {
                        password = value.trim();
                      });
                    },
                  ),
                ),
                // ignore: deprecated_member_use

                Container(
                    height: 60,
                    width: 360,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      textColor: Colors.white,
                      color: Colors.amber,
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                       try {
                         if (signup)
                           auth.signInWithEmailAndPassword(
                               email: email, password: password);
                         else
                           auth.createUserWithEmailAndPassword(
                               email: email, password: password);
                       } catch(err){
                            print(err) ;
                       }
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(textAltAdd),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Colors.indigo,
                      child: Text(
                        textAlt,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          if (signup) {
                            text = 'Sign up';
                            textAlt = 'Sign in';
                            textAltAdd = 'Already have an account? ';
                            buttonText = 'Register';
                            signup = false;
                          } else {
                            text = 'Sign in';
                            textAlt = 'Sign up';
                            textAltAdd = 'Don\'t have an account? ';
                            buttonText = 'Login';
                            signup = true;
                          }
                        });
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
