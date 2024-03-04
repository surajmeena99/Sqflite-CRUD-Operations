import 'package:flutter/material.dart';
import 'package:sqflite_app/add_contact.dart';
import 'package:sqflite_app/edit_contact.dart';
import 'package:sqflite_app/view_details.dart';
import 'contact_model.dart';
import 'database_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  late Future<List<Contact>> _contactList;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData () async{
     _contactList = _databaseHelper.getAllContacts();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _deleteConfirmationDialog(Contact contact) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this contact?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _databaseHelper.deleteContact(contact.id!);
                setState(() {}); // Refresh the UI
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contactList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final contacts = snapshot.data;  //...
            return ListView.builder(
              itemCount: contacts!.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: ValueKey(contacts[index].id),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete_forever),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _databaseHelper.deleteContact(contacts[index].id!);
                      _databaseHelper.getAllContacts();
                      contacts.remove(contacts[index]);
                    });
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewDetails(user: contacts[index],))
                      );
                    },
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].contactNo),
                    leading: const Icon(Icons.person),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditContact(user: contacts[index],))
                          ).then((data) {
                            if (data != null) {
                               _databaseHelper.getAllContacts();
                              _showSuccessSnackBar('User Detail Updated Success');
                            }
                          });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteConfirmationDialog(contacts[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddContact())
          ).then((data) {
            if (data != null) {
              _databaseHelper.getAllContacts();
              _showSuccessSnackBar('Contact Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
