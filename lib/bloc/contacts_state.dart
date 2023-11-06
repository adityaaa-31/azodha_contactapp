part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}


class ContactLoading extends ContactsState {}

class ContactLoaded extends ContactsState {
  final List<Contact> contacts;

  ContactLoaded({required this.contacts});
}

class ContactError extends ContactsState {}


