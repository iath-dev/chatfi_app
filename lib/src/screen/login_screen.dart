import 'package:flutter/material.dart';
import 'package:real_time_mobile_app/src/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: const SafeArea(
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(), child: _Content()),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .9,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppLogo(title: 'Bienvenido'),
          _Form(),
          LoginLabels(
              title: 'Registrarse!',
              subtitle: 'No tienes cuenta...',
              path: 'register'),
          Text('Términos y condiciones',
              style: TextStyle(fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    super.key,
  });

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(children: [
        TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: _customInputDecoration(Icons.alternate_email, 'Email')),
        const SizedBox(height: 30),
        TextField(
          obscureText: true,
          decoration: _customInputDecoration(Icons.lock_open, 'Password'),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {},
          icon: loading
              ? const SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.login),
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          label: const Text('Ingresar'),
        )
      ]),
    );
  }

  InputDecoration _customInputDecoration(IconData icon, String hint) {
    return InputDecoration(
        suffixIcon: Icon(icon),
        labelText: hint,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }
}
