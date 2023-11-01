import'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? username;
  String? email;
  String? password;
  String? image;
  DateTime? birthDate;
  DateTime? time;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.image,
      this.birthDate,
      this.time});

  UserModel fromJson(DocumentSnapshot doc) {
    var json = doc.data as Map<String, dynamic>?;
    return UserModel(
      id: doc.id,
      username: json?['username'],
      email: json?['email'],
      password: json?['password'],
      image: json?['image'],
      birthDate: (json?['birthDate'] as Timestamp?)?.toDate(),
      time: (json?['time'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> get toJson => {
    'id': id,
    'username': username,
    'email': email,
    'password': password,
    'image': image,
    'birthDate': birthDate,
    'time': time,
  };
}