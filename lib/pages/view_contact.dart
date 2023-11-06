import 'package:contactapp/bloc/contacts_bloc.dart';
import 'package:contactapp/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class viewContactPage extends StatefulWidget {
  final Contact contact;
  final ContactsBloc contactsBloc;
  const viewContactPage(
      {super.key, required this.contact, required this.contactsBloc});

  @override
  State<viewContactPage> createState() => _viewContactPageState();
}

class _viewContactPageState extends State<viewContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              widget.contactsBloc.add(DeleteContact(widget.contact.id));
              Fluttertoast.showToast(
                  msg: "Contact Deleted",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
              Navigator.pop(context);
            },
            child: Icon(Icons.delete),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.blueAccent,
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.amberAccent,
                radius: 100,
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                widget.contact.firstName,
                style: TextStyle(fontSize: 30),
              ),
              Text(widget.contact.email, style: TextStyle(fontSize: 30)),
              Text(widget.contact.phoneNumber, style: TextStyle(fontSize: 30)),
              Text(widget.contact.address, style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
