import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_mobile_app/src/services/services.dart';
import 'package:real_time_mobile_app/src/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(children: [
        TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _customInputDecoration(Icons.alternate_email, 'Email')),
        const SizedBox(height: 30),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: _customInputDecoration(Icons.lock_open, 'Password'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: !loading ? _submitForm : null,
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          child: loading
              ? const SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Ingresar'),
        )
      ]),
    );
  }

  _submitForm() async {
    setState(() {
      loading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final res =
        await authService.login(emailController.text, passwordController.text);

    emailController.clear();
    passwordController.clear();

    setState(() {
      loading = false;
    });

    FocusScope.of(context).unfocus();

    if (res) {
      socketService.connect();
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        // fillColor: Colors.white,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }
}
