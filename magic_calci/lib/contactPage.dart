// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'contactDisplay.dart';

class Contactpage extends StatefulWidget {
  const Contactpage({
    super.key,
  });

  @override
  State<Contactpage> createState() => ContactpageState();
}

class ContactpageState extends State<Contactpage> {
  String output = '';
  void getpermission() async {
    var status = Permission.contacts.request();
    if (await status.isGranted) {
      print("Contact permission granted");
    }
  }

  Future<List<Contact>> getContact() async {
    Iterable<Contact> c = await ContactsService.getContacts();
    return c.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 12,
            height: 12,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEEEEEE),
              ),
              onPressed: () {
                getpermission();
              },
              child: Text(
                "Get Premission to contacts",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF393E46),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEEEEEE),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => contactDisplay(),
                  ),
                ).then(
                  (value) {
                    output = value ?? 'none';
                    print(value);
                  },
                );
              },
              child: Text(
                "Get a contact number",
                style: TextStyle(
                  color: Color(0xFF393E46),
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF00ADB5),
              ),
              onPressed: () {
                Navigator.pop(context, output);
              },
              child: Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFF393E46),
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF222831),
      appBar: AppBar(
        title: Text("Contact Page"),
        backgroundColor: Color(0xFF393E46),
      ),
    );
  }
}
