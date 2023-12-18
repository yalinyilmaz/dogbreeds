import 'dart:io';

import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      onDragDown: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: ListView(children: [
          const ListTile(
              leading: Icon(
                Icons.info,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Help",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(
                Icons.arrow_upward,
                size: 20,
              )),
          const ListTile(
              leading: Icon(Icons.star, size: 30, color: Colors.black),
              title: Text("Rate Us",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_upward)),
          const ListTile(
              leading: Icon(Icons.ios_share, size: 30, color: Colors.black),
              title: Text("Share With Friends",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_upward)),
          const ListTile(
              leading: Icon(Icons.business, size: 30, color: Colors.black),
              title: Text("Terms of Use",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_upward)),
          const ListTile(
              leading: Icon(Icons.verified_user_outlined,
                  size: 30, color: Colors.black),
              title: Text("Privacy Policy",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_upward)),
          ListTile(
              leading: const Icon(Icons.system_security_update,
                  size: 30, color: Colors.black),
              title: const Text("Version",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              trailing: Text(
                Platform.isAndroid
                    ? "Android ${Platform.version.substring(0, 5)}"
                    : Platform.isIOS
                        ? "iOS ${Platform.operatingSystemVersion.substring(0, 12)}"
                        : "Not Available",
              )),
        ]),
      ),
    );
  }
}

class DraggableSheet extends StatelessWidget {
  final Widget child;
  final VoidCallback onDragDown;

  const DraggableSheet(
      {super.key, required this.child, required this.onDragDown});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) {
        onDragDown();
      },
      child: child,
    );
  }
}
