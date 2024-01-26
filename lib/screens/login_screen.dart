import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(     // Genera el efecto scroll
      child: Column(
        children: [
          const SizedBox(height: 250),       // Le da espacio hacia abajo
          CardContainer(                    // * Se le pasa por parametro un child
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),
              ChangeNotifierProvider( // utiliza el provider y llama al loginForm dentro
                create: (_) => LoginFormProvider(),
                child: _LoginForm(),
              )
            ],
          )),

          const SizedBox(height: 50),
          const Text('Crear una nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50)
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(                                  // Input para ingresar el mail
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,     // Abre teclado con @
            decoration: InputDecorations.authInputDecoration(
                hintText: 'alguien@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =                            //Patron para email y contraseña
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no es un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(                                    // Input para la contraseña
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe ser mayor a 5 caracteres';
              }),
          const SizedBox(height: 30),
          MaterialButton(                                         // Se crea el boton de inicio
            onPressed: loginForm.isLoading ? null : () async {
                    FocusScope.of(context).unfocus();                 // Quita el teclado una vez se apreta el boton
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2)); //Simula tiempo de espera
                    loginForm.isLoading = false;
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, 'home');
                  },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ]));
  }
}
