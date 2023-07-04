import 'package:codecampapp/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log Out',
    content: 'Are you sure you want to Log Out',
    optionsBuilder: () => {
      'Cancel': false,
      'Log Out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
