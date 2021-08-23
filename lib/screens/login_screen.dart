import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_chat/components/rounded_button.dart';
import 'package:insta_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueAccent,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 100, 0, 5),
                child: Row(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 50.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    TypewriterAnimatedTextKit(
                      text: ["Login"],
                      textStyle: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      TextField(
                        controller: emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Your email id"),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      TextField(
                        controller: passTextController,
                        obscureText: true,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Your password"),
                      ),
                      Align(
                        alignment: Alignment(1.15, 0),
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: RoundedButton(
                          title: "Log in",
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            try {
                              setState(() {
                                showSpinner = true;
                              });
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, ChatScreen.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                            emailTextController.clear();
                            passTextController.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
