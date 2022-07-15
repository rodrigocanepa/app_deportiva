

import 'package:app_deportiva/Firebase/querys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user_model.dart';

class FetchData{

  Future<UserModel?> getUserByID({required String id}) async{

    UserModel userModel;
    final messages = await QuerysService().getUserByID(id: id);
    dynamic miInfo = messages;
    try{
      userModel = UserModel.fromMap(miInfo.data().cast<String, dynamic>());
      return userModel;
    } catch(e){
      print('error get getUserByID: ' + e.toString());
      return null;
    }
  }

/*
  Future<List<NotificationModel>> getNotificationsList(String id) async {

    List<NotificationModel> notifications = [];

    final messages = await QuerysService().getNotificationsInPost(id);
    dynamic miInfo = messages.docs;
    notifications = (miInfo as List).map((i) => NotificationModel.fromMap(i.data().cast<String, dynamic>())).toList();

    return notifications;
  }
*/

}