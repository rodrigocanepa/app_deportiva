import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Firebase/authentication.dart';
import '../Firebase/fetch_data.dart';
import '../Firebase/querys.dart';
import '../Models/user_model.dart';
import '../UI/Screens/Auth/login_screen.dart';
import '../UI/Screens/main_screen.dart';
import '../Utils/constants.dart';
import '../Utils/navigation_utils.dart';

class AuthProvider extends ChangeNotifier{

  UserModel? userModel;
  String error = "";
  bool loading = false;

  setUser(UserModel userModel){
    this.userModel = userModel;
    notifyListeners();
  }

  checkIfUserIsLogin() async{

    try{
      loading = true;
      notifyListeners();
      //give a delay for loading
      await Future.delayed(const Duration(milliseconds: 100));

      var user = await Authentication().getCurrentUser();
      print('user logged in');
      if (user != null) {
        UserModel? userModel = await FetchData().getUserByID(id: user.uid);
        if(userModel != null){
          print('user registrered in database');
          this.userModel = userModel;
          loading = false;
          notifyListeners();
        } else{
          print('user is not in database');
          this.userModel = null;
          loading = false;
          notifyListeners();
        }
      }else{
        loading = false;
        notifyListeners();
      }

    } catch(e){
      print('error trying to check if user is login and registrered');
      loading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  loginWithEmailAndPassword({required String email, required String password, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    var auth = await Authentication().logingUser(email: email, password: password);
    if(auth.succes){
      User? user = await Authentication().getCurrentUser();
      if(user != null){
        userModel = await FetchData().getUserByID(id: user.uid);
        if(userModel != null){
          NavigationUtils().pushAndRemovePage(context, const MainScreen());
          loading = false;
          notifyListeners();
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User not found, please verify your credential"),
              duration: Duration(seconds: 3),
            ),
          );
          loading = false;
          notifyListeners();
        }
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An error ocurred during authentication process"),
            duration: Duration(seconds: 3),
          ),
        );
        loading = false;
        notifyListeners();
      }
    } else{
      loading = false;
      error = auth.errorMessage!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          duration: Duration(seconds: 3),
        ),
      );
      notifyListeners();
    }
  }

  registerUserWithEmailAndPassword({required UserModel userModel, required String password, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    var auth = await Authentication().createUser(email: userModel.email, password: password);
    if(auth.succes){
      User? user = await Authentication().getCurrentUser();
      if(user != null){
        userModel.id = user.uid;
        loading = false;
        notifyListeners();
        bool err =  await QuerysService().SaveGeneralInfo(
            reference: REFERENCE_USERS,
            id: user.uid,
            collectionValues: userModel.toMap()
        );
        if(err){
          error = 'An error ocurred, please try again';
          loading = false;
          notifyListeners();
        } else{
          this.userModel = userModel;
          NavigationUtils().pushAndRemovePage(context, MainScreen());
          notifyListeners();
        }
      } else{
        error = "Ha ocurrido un error en el registro";
        loading = false;
        notifyListeners();
      }
    } else{
      error = auth.errorMessage!;
      loading = false;
      notifyListeners();
    }
  }

  logout(BuildContext context) async{
    error = '';
    loading = true;
    notifyListeners();

    bool errorBool = await Authentication().singOut();
    if(errorBool){
      error = 'An error ocurred, please try again';
      loading = false;
      notifyListeners();
    } else{
      print('sign out successfully');
      userModel = null;
      loading = false;
      notifyListeners();
      NavigationUtils().pushAndRemovePage(context, LoginScreen());
    }
  }

  /*
  editInfo({required String username, required String bio, required String name, required String id, required BuildContext context, required bool isEditing}) async{
    loading = true;
    notifyListeners();

    final messages = await QuerysService().getUserByUsername(username);
    dynamic miInfo = messages.docs;
    List<UserModel> auxList = [];

    // we need to check if the username is already used or not
    try{
      auxList = (miInfo as List).map((i) => UserModel.fromMap(i.data().cast<String, dynamic>())).toList();
    } catch(e){
      print(e);
    }

    if(auxList.isNotEmpty){
      if(auxList[0].id != id){
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Your username is already used by another account"),
            backgroundColor: Colors.red.shade700,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
    }
    // *********************************************************

    // now we are going to save the info in the user document
    bool error = await QuerysService().SaveGeneralInfo(
        reference: REFERENCE_USERS,
        id: id,
        collectionValues: {
          'name': name,
          'username': username,
          'bio': bio,
          'updatedAt': DateTime.now()
        }
    );

    loading = false;
    notifyListeners();

    if(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("There was an error, please try again"),
          backgroundColor: Colors.red.shade700,
          duration: Duration(seconds: 2),
        ),
      );
    } else{
      userModel!.username = username;
      userModel!.bio = bio;
      userModel!.name = name;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile edited sucessfully", style: TextStyle(color: Colors.white)),
          backgroundColor: TEXT_GREEN,
          duration: Duration(seconds: 2),
        ),
      );
      if(!isEditing){
        NavigationUtils().pushAndRemovePage(context, const MainScreen());
      }
    }
  }
*/
}
