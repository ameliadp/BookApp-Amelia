import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/app/data/database.dart';
import 'package:firebase_app/app/integrations/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class BookModel {
  String? id;
  String? title;
  String? category;
  int? page;
  int? readPage;
  String? image;
  DateTime? time;

  BookModel(
      {this.id, this.title, this.category, this.page, this.image, this.time});

  BookModel.fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic>? json = snapshot.data() as Map<String, dynamic>?;
    id = snapshot.id;
    title = json?['title'];
    category = json?['category'];
    page = json?['page'];
    readPage = json?['readPage'];
    image = json?['image'];
    time = (json?['time'] as Timestamp).toDate();
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'title': title,
        'category': category,
        'page': page,
        'readPage': readPage,
        'image': image,
        'time': time,
      };

  Database db = Database(
      collectionReference: firebaseFirestore.collection(bookCollection),
      storageReference: firebaseStorage.ref(bookCollection));

  Future<BookModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Future delete(String idbook) async {
    (idbook == null)
        ? toast('Error invalid ID')
        : await db.delete(idbook!, url: image);
  }

  Stream<List<BookModel>> streamList({int? limit}) async* {
    var query = db.collectionReference.orderBy('time', descending: true);
    if (limit is int) {
      query = query.limit(limit);
    }
    yield* query.snapshots().map((query) {
      List<BookModel> list = [];
      for (var doc in query.docs) {
        list.add(
          BookModel.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
