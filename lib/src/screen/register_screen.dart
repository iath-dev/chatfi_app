import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_mobile_app/src/services/auth_service.dart';
import 'package:real_time_mobile_app/src/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.grey.shade50,
      body: SafeArea(
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
          AppLogo(title: 'Crear cuenta'),
          _Form(),
          LoginLabels(
              title: 'Iniciar sesión!',
              subtitle: 'Ya tienes cuenta',
              path: 'login'),
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(children: [
        TextField(
            decoration: _customInputDecoration(Icons.person, 'Nombre'),
            controller: nameController),
        const SizedBox(height: 20),
        TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _customInputDecoration(Icons.alternate_email, 'Email')),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: _customInputDecoration(Icons.lock_open, 'Password'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          child: loading
              ? const SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Crear'),
        )
      ]),
    );
  }

  void _submitForm() async {
    setState(() {
      loading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);

    final res = await authService.register(
        nameController.text, emailController.text, passwordController.text);

    nameController.clear();
    emailController.clear();
    passwordController.clear();

    setState(() {
      loading = false;
    });

    FocusScope.of(context).unfocus();

    if (res) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Información invalida')));
    }
  }

  InputDecoration _customInputDecoration(IconData icon, String hint) {
    return InputDecoration(
        suffixIcon: Icon(icon),
        labelText: hint,
        filled: true,
        // fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }
}
