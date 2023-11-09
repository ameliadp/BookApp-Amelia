import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/app/data/database.dart';
import 'package:firebase_app/app/integrations/firestore.dart';

class UserModel {
  String? id;
  String? username;
  String? email;
  String? password;
  String? image;
  String? gender;
  DateTime? birthDate;
  DateTime? time;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.image,
      this.gender,
      this.birthDate,
      this.time});

  UserModel fromJson(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>?;
    return UserModel(
      id: doc.id,
      username: json?['username'],
      email: json?['email'],
      password: json?['password'],
      image: json?['image'],
      gender: json?['gender'],
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
        'gender': gender,
        'birthDate': birthDate,
        'time': time,
      };

  Database db = Database(
      collectionReference: firebaseFirestore.collection(usersCollection),
      storageReference: firebaseStorage.ref(usersCollection));

  Future<UserModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Stream<UserModel> streamList(String id) async* {
    yield* db.collectionReference.doc(id).snapshots().map((event) {
      print('even id = ${event.id}');
      return fromJson(event);
    });
  }

  Stream<List<UserModel>> allStreamList() async* {
    yield* db.collectionReference.snapshots().map((query) {
      List<UserModel> list = [];
      for (var doc in query.docs) {
        list.add(
          UserModel().fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
