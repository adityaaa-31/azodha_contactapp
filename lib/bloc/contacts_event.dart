part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class AddContact extends ContactsEvent {
  final Contact contact;

  AddContact(this.contact);

  List<Object> get props => [contact];
}

class DeleteContact extends ContactsEvent {
  final String contactId;

  DeleteContact(this.contactId);
  List<Object> get props => [contactId];
}

class FetchContact extends ContactsEvent {}
