import 'package:codecampapp/constants/routes.dart';
import 'package:codecampapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text("Email verification sent. Verify to login."),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerifcation();
            },
            child: const Text("Didn't Receive? Resend."),
          ),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Back to Login Page"))
        ],
      ),
    );
  }
}
