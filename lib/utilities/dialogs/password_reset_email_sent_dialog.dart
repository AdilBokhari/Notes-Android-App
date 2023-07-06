import 'package:codecampapp/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'Password Reset Mail Sent',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
