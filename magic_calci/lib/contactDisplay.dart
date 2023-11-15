// ignore_for_file: camel_case_types

//import 'dart:html';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class m extends StatelessWidget {
  const m({super.key});

  @override
  Widget build(BuildContext context) {
    return const contactDisplay();
  }
}

class contactDisplay extends StatefulWidget {
  const contactDisplay({super.key});

  @override
  State<contactDisplay> createState() => contactDisplayState();
}

class contactDisplayState extends State<contactDisplay> {
  List<Contact> cont = [];
  bool isLoading = true;
  var output = '';
  @override
  void initState() {
    loadContacts();
  }

  Future<void> loadContacts() async {
    if (await Permission.contacts.request().isGranted) {
      fetchContacts();
    } else {
      print("no permission");
      await Permission.contacts.request();
    }
  }

  void fetchContacts() async {
    cont = await ContactsService.getContacts();

    setState(() {
      isLoading = false;
    });
  }

  void trim(String op) {
    String newop = "";
    int i = 0;
    op.trim();
    int cur = op.length - 1;
    while (i < 10) {
      if (op[cur].contains(RegExp(r'[0-9]'))) {
        newop = op[cur] + newop;
        print(newop);
        i++;
      }
      cur--;
    }
    output = newop;
    print(newop);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select contact'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: cont.length,
              itemBuilder: (context, index) {
                final c = cont[index];
                return ListTile(
                  title: Text(c.displayName ?? ''),
                  subtitle: Text(c.phones!.isEmpty
                      ? 'no'
                      : c.phones?.first.value ?? 'none'),
                  onTap: () {
                    setState(() {
                      output = c.phones?.first.value ?? 'none';
                    });
                    trim(output);

                    print(output);
                    Navigator.pop(context, output);
                  },
                );
              },
            ),
    );
  }
}
