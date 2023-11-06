class Contact {
  final String id;
  final String firstName;
  final String phoneNumber;
  final String email;
  final String address;
  Contact({
    required this.id,
    required this.firstName,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      firstName: map['name'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': firstName,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
    };
  }
}
