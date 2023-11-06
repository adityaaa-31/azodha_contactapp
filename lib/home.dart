import 'package:contactapp/bloc/contacts_bloc.dart';
import 'package:contactapp/pages/add_contact_page.dart';
import 'package:contactapp/pages/view_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContactsBloc contactBloc = ContactsBloc();
  @override
  void initState() {
    super.initState();
    contactBloc.add(FetchContact());
  }

  Future<void> refreshContacts() async {
    contactBloc.add(FetchContact());
  }

  @override
  Widget build(BuildContext context) {
    Future navigateToAddContactPage() async {
      await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: addContactPage(contactsBloc: contactBloc),
            );
          },
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Contacts'),
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   systemNavigationBarColor: Theme.of(context).colorScheme.background,
          // ),
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddContactPage,
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: refreshContacts,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BlocConsumer<ContactsBloc, ContactsState>(
              listener: (context, state) {},
              bloc: contactBloc,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case ContactLoading:
                    return const Center(child: CircularProgressIndicator());

                  case ContactLoaded:
                    final success = state as ContactLoaded;
                    if (success.contacts.isEmpty) {
                      return const Center(
                        child: Text("No contacts"),
                      );
                    }
                    return ListView.builder(
                      itemCount: success.contacts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => viewContactPage(
                                    contact: success.contacts[index],
                                    contactsBloc: contactBloc,
                                  ),
                                ));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.amberAccent,
                            child: Text(
                              success.contacts[index].firstName[0]
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          title: Text(success.contacts[index].firstName),
                        );
                      },
                    );

                  case ContactError:
                    return const Center(
                      child: Text("Error while fetching contacts"),
                    );
                  default:
                    return const Center(
                      child: Text("Can't Fetch Contacts"),
                    );
                }
              },
            ),
          ),
        ));
  }
}
