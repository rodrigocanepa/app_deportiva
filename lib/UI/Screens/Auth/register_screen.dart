import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../Models/user_model.dart';
import '../../../Provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _protectPassword = true;
  // late significa que lo voy a inicializar en unos momentos pero estoy seguro de que lo utilizaré solo si ya está inicilizado
  late AuthProvider authProvider;

  /// hacer esta pantalla: https://image.winudf.com/v2/image/Y29tLkxvZ2luQXBwLkxvZ2luQXBwX3NjcmVlbl8wXzE1MzI4NTgxNTRfMDUz/screen-0.jpg?fakeurl=1&type=.jpg
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
              const Center(
                child: Text(
                  "REGISTRATE AQUÍ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0
                  ),
                ),
              ),
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
                  primary: Colors.grey
              ),
              onPressed: (){
                // ESTO SIRVE PARA QUITAR LA PANTALLA ACTUAL
                // PUSH -> PARA LANZAR UNA NUEVA PANTALLA
                // POP -> PARA QUITAR LA PANTALLA
                Navigator.of(context).pop();
              },
              child: const Text(
                'Volver al login',
                style: TextStyle(
                    color: Colors.white
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade800
              ),
              onPressed: (){
                UserModel userModel = UserModel(
                    id: "",
                    name: "Juan Perez",
                    email: _controllerEmail.text.trim(),
                    createdAt: DateTime.now()
                );
                authProvider.registerUserWithEmailAndPassword(userModel: userModel, password: _controllerPassword.text.trim(), context: context);
              },
              child: const Text(
                'Registrarme',
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
