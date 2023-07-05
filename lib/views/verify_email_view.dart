import 'package:codecampapp/services/auth/bloc/auth_bloc.dart';
import 'package:codecampapp/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: const Text("Didn't Receive? Resend."),
          ),
          TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Back to Login Page"))
        ],
      ),
    );
  }
}
