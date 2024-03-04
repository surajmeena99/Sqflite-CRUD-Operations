import 'package:flutter/material.dart';
import 'package:sqflite_app/contact_model.dart';
import 'package:sqflite_app/database_helper.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key, required this.user});
  
  final Contact user;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  int? _userID;

  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;

    @override
  void initState() {
    super.initState();
    setState(() {
      _userID = widget.user.id;
      _userNameController.text=widget.user.name;
      _userContactController.text=widget.user.contactNo;
      _userDescriptionController.text=widget.user.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit New User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                    _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    errorText: _validateDescription
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
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
                        if (_validateName == false &&
                            _validateContact == false &&
                            _validateDescription == false) {
                          
                          var user = Contact(
                            id: _userID, 
                            name: _userNameController.text, 
                            contactNo: _userContactController.text, 
                            description: _userDescriptionController.text,
                            );
                          await _databaseHelper.updateContact(user);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Update Details')),
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