import 'package:flutter/material.dart';
import 'package:insta_chat/components/rounded_button.dart';
import 'package:insta_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
      backgroundColor: Colors.lightBlue,
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
                      text: ["Register"],
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
                            //Do something with the user input.
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Enter your email"),
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
                            //Do something with the user input.
                            password = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: "Enter your password"),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Center(
                          child: RoundedButton(
                            title: "Register",
                            color: Colors.blueAccent,
                            onPressed: () async {
                              emailTextController.clear();
                              passTextController.clear();
                              setState(() {
                                showSpinner = true;
                              });

                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                if (newUser != null) {
                                  Navigator.pushNamed(context, ChatScreen.id);
                                }

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
