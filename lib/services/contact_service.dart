import 'dart:async';
// import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/models/contact.dart';

class ContactService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Contact>> fetchContact() async {
    QuerySnapshot snapshot = await firestore.collection('contacts').get();

    List<Contact> contacts = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Contact.fromMap(data);
    }).toList();

    return contacts;
  }

  Future<void> addContact(Contact contact) async {
    try {
      await firestore.collection('contacts').add(contact.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      QuerySnapshot snapshot = await firestore.collection('contacts').where('id', isEqualTo: id).get();
      if(snapshot.docs.isEmpty) print('Cannot delete $id');
      final doc = snapshot.docs.first;
      await doc.reference.delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
