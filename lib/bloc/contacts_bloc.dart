import 'package:bloc/bloc.dart';
import 'package:contactapp/services/contact_service.dart';
import 'package:meta/meta.dart';
import 'package:contactapp/models/contact.dart';
import 'package:equatable/equatable.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactService contactService = ContactService();

  ContactsBloc() : super(ContactsInitial()) {

    on<FetchContact>(
      (event, emit) async {
        emit(ContactLoading());

        try {
          //get contacts from firestore
          List<Contact> contacts = await contactService.fetchContact();
          emit(ContactLoaded(contacts: contacts));
        } catch (e) {
          throw Exception(e);
        }
      },
    );

    on<AddContact>((event, emit) async {
      emit(ContactLoading());

      try {
        //add contacts to firestore
        await contactService.addContact(event.contact);
        List<Contact> updatedContacts = await contactService.fetchContact();//update contact list
        emit(ContactLoaded(contacts: updatedContacts));
      } catch (_) {
        emit(ContactError());
      }
    });

    on<DeleteContact>((event, emit) async {
      emit(ContactLoading());
      try {
        //delete contact from firestore
        await contactService.deleteContact(event.contactId);
        List<Contact> updatedContacts = await contactService.fetchContact();//update contact list
        emit(ContactLoaded(contacts: updatedContacts));
      } catch (_) {
        emit(ContactError());
      }
    });
  }
}
