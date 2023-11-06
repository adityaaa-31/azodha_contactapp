import 'package:contactapp/bloc/contacts_bloc.dart';
import 'package:contactapp/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class addContactPage extends StatefulWidget {
  final ContactsBloc contactsBloc;

  const addContactPage({super.key, required this.contactsBloc});

  @override
  State<addContactPage> createState() => _addContactPageState();
}

class _addContactPageState extends State<addContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void saveContact() {
      final firstName = firstNameController.text.trim();
      final email = emailController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();
      final address = addressController.text.trim();

      String uuid = const Uuid().v4();

      final newContact = Contact(
        id: uuid,
        firstName: '$firstName ',
        phoneNumber: phoneNumber,
        address: '$address ',
        email: email,
      );
      widget.contactsBloc.add(AddContact(newContact));
      Fluttertoast.showToast(
          msg: "Contact Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add contact"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ContactsBloc(),
          child: BlocProvider(
            create: (context) => ContactsBloc(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 18.0, left: 18.0),
                          child: Text(
                            'Enter Your Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    //color: Colors.black12,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: firstNameController,
                      key: ValueKey('Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      // controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          labelText: "Full Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    //color: Colors.black12,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: emailController,
                      key: ValueKey('Email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    //color: Colors.black12,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      key: ValueKey('Phone'),
                      validator: (value) {
                        if (value!.length < 10) {
                          return 'Invalid Phone Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: addressController,
                      key: const ValueKey('Addres'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.house_rounded),
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    //color: Colors.black,
                    margin: EdgeInsets.only(left: 15, right: 15),
      
                    child: SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            saveContact();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.blueAccent
                        ),
                        child: const Text(
                          "Add Contact",
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
