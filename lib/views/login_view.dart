import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                          hintText: "Enter your Email Here"),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "Enter your Password Here"),
                    ),
                    TextButton(
                        onPressed: () async {
                          var email = _email.text;
                          var password = _password.text;

                          try {
                            var credentials = FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User? user) {
                              if (user == null) {
                                print("User not signed In");
                              } else {
                                print('User is signed in!');
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/home/", (_) => false);
                              }
                            });
                            print("Credentials $credentials");
                          } on FirebaseAuthException catch (e) {
                            print("Error ${e.message}");
                          }
                        },
                        child: const Text("Login")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/register/", (route) => false);
                        },
                        child: const Text("Not Registered Yet? Register Here"))
                  ],
                );

              default:
                return const Text("Loading");
            }
          },
        ));
  }
}
