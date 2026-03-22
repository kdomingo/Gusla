import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../util/strings.dart';

mixin LocationResolutionMixin {
  void showResolutionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(Strings.locationPermissionTitle),
          content: Text(Strings.locationPermissionMessage),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(Strings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                AppSettings.openAppSettings();
              },
              child: Text(Strings.openSettings),
            ),
          ],
        );
      },
    );
  }
}
