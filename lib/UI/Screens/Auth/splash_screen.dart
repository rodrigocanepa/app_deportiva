import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/auth_provider.dart';
import '../../../Utils/navigation_utils.dart';
import '../main_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  loadTimer() async{
    await Future.delayed(const Duration(seconds: 1));
    var auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.checkIfUserIsLogin();
    auth = Provider.of<AuthProvider>(context, listen: false);
    if(auth.userModel != null){
      NavigationUtils().pushReplacementPage(context, MainScreen());
    }else{
      NavigationUtils().pushReplacementPage(context, LoginScreen());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Loading..."
        ),
      ),
    );
  }
}
