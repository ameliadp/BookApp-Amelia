import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/app/data/database.dart';
import 'package:get/get.dart';
import 'package:firebase_app/app/integrations/firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class ReadModel {
  String? id;
  String? bookId;
  int? prePage;
  int? newPage;
  DateTime? time;

  ReadModel({this.id, this.bookId, this.prePage, this.newPage, this.time});

  ReadModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>;
    id = doc.id;
    bookId = json['bookId'];
    prePage = json['prePage'];
    newPage = json['newPage'];
    time = (json['time'] as Timestamp).toDate();
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'bookId': bookId,
        'prePage': prePage,
        'newPage': newPage,
        'time': time,
      };

  Database get db => Database(
      collectionReference: firebaseFirestore
          .collection(bookCollection)
          .doc(bookId)
          .collection(readCollection),
      storageReference:
          firebaseStorage.ref(bookCollection).child(readCollection));

  Future<ReadModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    return this;
  }

  Future delete() async {
    if (id.isEmptyOrNull) {
      Get.snackbar('Error', 'Invalid document Id');
      return;
    }
    return await db.delete(id!);
  }

  Stream<List<ReadModel>> streamList() async* {
    yield* db.collectionReference
        .orderBy('time', descending: true)
        .snapshots()
        .map((query) {
      List<ReadModel> list = [];
      for (var doc in query.docs) {
        list.add(
          ReadModel.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }

  Stream<List<ReadModel>> streamAllList() async* {
    yield* firebaseFirestore
        .collectionGroup(readCollection)
        .snapshots()
        .map((query) {
      List<ReadModel> list = [];
      for (var doc in query.docs) {
        list.add(
          ReadModel.fromJson(
            doc,
          ),
        );
      }
      print('List length ${list.length}');
      return list;
    });
  }

  Stream<List<ReadModel>> streamListFromBook() async* {
    yield* firebaseFirestore
        .collection(bookCollection)
        .doc(bookId)
        .collection(readCollection)
        .snapshots()
        .map((query) {
      List<ReadModel> list = [];
      for (var doc in query.docs) {
        print(doc.reference);
        print(doc.data());
        list.add(
          ReadModel.fromJson(
            doc,
          ),
        );
      }
      print('List length ${list.length}');
      return list;
    });
  }
}
