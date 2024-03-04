import 'package:flutter/material.dart';
import 'package:sqflite_app/contact_model.dart';
import 'package:sqflite_app/database_helper.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add New Contact',
                style: TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText: _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(height: 20.0,),
              TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateContact ? 'Contact Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(height: 20.0,),
              TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    errorText: _validateDescription ? 'Description Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(height: 20.0,),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15),
                      ),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        var newContact = Contact(
                          id: null, 
                          name: _userNameController.text, 
                          contactNo: _userContactController.text, 
                          description: _userDescriptionController.text,
                        );
                        if (_validateName == false &&
                            _validateContact == false &&
                            _validateDescription == false) {
                          await _databaseHelper.insertContact(newContact);
                         Navigator.pop(context,);
                        }
                      },
                      child: const Text('Save Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}