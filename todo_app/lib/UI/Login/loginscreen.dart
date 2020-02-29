import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/bloc/blocs/user_bloc_provider.dart';
import 'package:todo_app/models/classes/user.dart';
import 'package:todo_app/models/global.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyColor,
      body: Center(
        child: widget.newUser ? getSignupPage() : getSigninPage(),
      ),
    );
  }
  Widget getSigninPage() {
    TextEditingController usernameText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Welcome!", style: bigLightBlueTitle,),
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: usernameText,
                    autofocus: false,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: darkGreyColor
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Username",
                      contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7)
                      )
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    obscureText: true,
                    controller: passwordText,
                    autofocus: false,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: darkGreyColor
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7)
                      )
                    ),
                  ),
                ),
                FlatButton(
                  child: Text("Sign in", style: redBigBoldText),
                  onPressed: () {
                    if (usernameText.text != null || passwordText.text != null) {
                      bloc.signinUser(usernameText.text, passwordText.text, "").then((_) {
                        widget.login();
                      });
                    }
                  },
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("Don't have an account yet?", style: redText,),
                FlatButton(
                  child: Text("Signup now", style: redBoldText),
                  onPressed: () {
                    
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget getSignupPage() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
            )
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: "Username",
            )
          ),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
              hintText: "First name",
            )
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            )
          ),
          FlatButton(
            color: Colors.amber,
            child: Text("Sign up"),
            onPressed: () {
              if (usernameController.text != null || passwordController.text != null || emailController.text != null) {
                bloc.registerUser(
                  usernameController.text,
                  firstNameController.text?? "",
                  "",
                  emailController.text,
                  passwordController.text
                ).then((_) {
                  widget.login();
                });
              }
            },
          )
        ],
      ),
    );
  }
}