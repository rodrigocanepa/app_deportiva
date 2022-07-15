import 'package:app_deportiva/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade800
            ),
            onPressed: (){
              authProvider.logout(context);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white
              ),
            )
        ),
      ),
    );
  }
}
