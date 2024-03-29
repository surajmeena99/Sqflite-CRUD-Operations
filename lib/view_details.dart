import 'package:flutter/material.dart';
import 'package:sqflite_app/contact_model.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({super.key, required this.user});

  final Contact user;

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Selected User Details"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Full Details",
                style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blueGrey,fontSize: 20),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text('Name',
                      style: TextStyle(color: Colors.teal,fontSize: 16,fontWeight: FontWeight.w600)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(widget.user.name, style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text('Contact',
                      style: TextStyle(color: Colors.teal,fontSize: 16,fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.user.contactNo, style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description',
                      style: TextStyle(color: Colors.teal,fontSize: 16,fontWeight: FontWeight.w600)
                  ),
                  const SizedBox(height: 20,),
                  Text(widget.user.description, style: const TextStyle(fontSize: 16)),
                ],
              )
            ],
          ),
        ));
  }
}