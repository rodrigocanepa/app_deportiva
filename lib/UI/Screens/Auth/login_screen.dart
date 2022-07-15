import 'package:app_deportiva/UI/Screens/Auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../Provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  bool _protectPassword = true;
  late AuthProvider authProvider;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {

    authProvider = Provider.of<AuthProvider>(context, listen: true);
    return LoadingOverlay(
      isLoading: authProvider.loading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(),
              const SizedBox(height: 20.0),
              _formulary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.blue.shade800,
    );
  }

  Widget _formulary(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue.shade200,
                ),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  //textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0
                  ),
                  decoration: const InputDecoration(
                    hintText: "Correo electrónico",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                    ),
                    border: InputBorder.none,
                    //icon: Icon(Icons.person)
                  )
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue.shade200,
                ),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: _controllerPassword,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _protectPassword, // con esta propiedad volvemos el texto a asteriscos
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0
                        ),
                        decoration: const InputDecoration(
                          hintText: "Contraseña",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0
                          ),
                          border: InputBorder.none,
                          //icon: Icon(Icons.person)
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _protectPassword = !_protectPassword;
                      });
                    },
                    child: Icon(
                        _protectPassword ? Icons.remove_red_eye : Icons.remove_red_eye_outlined
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade800
              ),
              onPressed: (){
                if(_controllerEmail.text.trim().isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tu correo está vacío"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return;
                }
                if(_controllerPassword.text.trim().length < 6){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tu contraseña debe ser por lo menos de 6 caracteres"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return;
                }
                authProvider.loginWithEmailAndPassword(
                    email: _controllerEmail.text.trim(),
                    password: _controllerPassword.text.trim(),
                    context: context
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white
                ),
              )
          ),
        ),
        SizedBox(height: 25.0),
        Center(
          child: Text(
              '¿Olvidaste tu contraseña?'
          ),
        ),
        SizedBox(height: 25.0),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Text(
                ' o '
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 50.0, left: 20.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade800
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen ()
                    )
                );
              },
              child: const Text(
                'Registrate aquí',
                style: TextStyle(
                    color: Colors.white
                ),
              )
          ),
        ),
      ],
    );
  }
}
