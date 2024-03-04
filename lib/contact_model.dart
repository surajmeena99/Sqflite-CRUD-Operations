class Contact {
  int? id;
  String name;
  String contactNo;
  String description;

  Contact({required this.id, required this.name, required this.contactNo, required this.description});

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      contactNo: map['contactNo'],
      description: map['description'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contactNo': contactNo,
      'description': description,
    };
  }
}
