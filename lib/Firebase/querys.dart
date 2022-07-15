import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Utils/constants.dart';

class QuerysService{

  final _fireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserByID({required String id}) async{
    return await _fireStore.collection(REFERENCE_USERS).doc(id).get();
  }
  /*

  Future<QuerySnapshot> getMyStoryList(String id) async{
    return _fireStore.collection(REFERENCE_STORY).where('userID', isEqualTo: id).get();
  }

  Future<QuerySnapshot> getMyLastMessages(String idUser) async{
    return _fireStore.collection(REFERENCE_USERS).doc(idUser).collection(SUBREFERENCE_LAST_MESSAGES).orderBy('createdAt', descending: true).get();
  }

  Future<QuerySnapshot> getOnlyMyLastMessage(String idUser) async{
    return _fireStore.collection(REFERENCE_USERS).doc(idUser).collection(SUBREFERENCE_LAST_MESSAGES).where('checkForBadge', isEqualTo: true).orderBy('createdAt', descending: true).limit(1).get();
  }

  Future<QuerySnapshot> getAllMyHighLights(String userID) async{
    return _fireStore.collection(REFERENCE_HIGHLIGHT).where('userID', isEqualTo: userID).get();
  }*/

  Future<bool> deleteDocumentInsideOtherCollection({required String reference, required String subreference, required String idDocument, required String idSubdocument}) async {
    bool error = false;
    return await _fireStore.collection(reference).doc(idDocument).collection(subreference).doc(idSubdocument).delete().catchError((onError){
      error = true;
    }).then((onValue){
      return error;
    });
  }

  Future<bool> SaveGeneralInfo({required String reference, required String id, required Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).set(collectionValues, setOptions).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }

  Future<bool> SaveGeneralInfoInsideDocument({required String reference, required String subreference, required String id, required String subId, required Map<String, dynamic> collectionValues}) async {
    bool error = false;
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).collection(subreference).doc(subId).set(collectionValues, setOptions).catchError((onError){
      error = true;
      return true;
    }).then((onValue){
      if(!error){
        error = false;
        return error;
      }
      else{
        error = true;
        return error;
      }
    });
  }

  Future<String> uploadFile({required File file, required String id, required String reference}) async {

    final Reference storageReference = FirebaseStorage.instance.ref().child(reference).child(id);
    final UploadTask uploadTask = storageReference.putFile(file);
    var dowurl = await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    String url = dowurl.toString();
    return url;
  }
/*
  Stream<QuerySnapshot> getOrdersFinishedByIdStream(String id) {
    return _fireStore.collection(REFERENCE_ORDERS).where('courierAssignatedId', isEqualTo: id).where('status', isEqualTo: 2).snapshots();
  }*/

}