import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Please Verify Your Email"),
        TextButton(
            onPressed: () async {
              try {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              } catch (e) {
                print(e.toString());
              }
            },
            child: const Text("Send Email Verification"))
      ]),
    );
  }
}
