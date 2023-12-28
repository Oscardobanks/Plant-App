import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String photoUrl;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.photoUrl,
  });

  toJson() {
    return {
      'Id': id,
      'FullName': fullName,
      'Email': email,
      'Password': password,
      'PhotoUrl': photoUrl,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data['FullName'],
      email: data['Email'],
      password: data['Password'], 
      photoUrl: data['PhotoUrl'],
    );
  }
}
