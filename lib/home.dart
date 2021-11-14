import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSingIn = GoogleSignIn();
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    googleSingIn.onCurrentUserChanged.listen((account) {
      if(account != null){
        print('user sign in!: $account');
        setState(() {
          isAuth = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
  login(){
    googleSingIn.signIn();
  }
  logout(){
    googleSingIn.signOut();
  }

  Widget buildAuthScreen() {
    return Text("Authenticated");
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Theme.of(context).canvasColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Splash Screen',
              style: TextStyle(
                  color: Colors.white, fontSize: 90, fontFamily: 'Signatra'),
            ),
            GestureDetector(
              onTap: () => login(),
              child: Container(
                width: 330.0,
                height: 80.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/google-signin-button.png'),
                    fit: BoxFit.cover,
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
