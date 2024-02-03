import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/screens/chat_screen.dart';
import 'package:gpt_flutter/screens/signup.dart';
import 'package:gpt_flutter/services/ui_helper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  login(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      UserCredential? usercredential;

      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully logged in!"),
            duration: Duration(seconds: 1),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        return UiHelper.CustomAlertBox(context, e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/logo.png'),
          const SizedBox(
            height: 60,
          ),
          UiHelper.CustomTextField(
            emailController,
            'Enter your email',
            Icons.email,
            false,
          ),
          const SizedBox(
            height: 20,
          ),
          UiHelper.CustomPasswordField(
            passwordController,
            'Enter your password',
          ),
          const SizedBox(
            height: 70,
          ),
          UiHelper.CustomButton(() {
            login(
              emailController.text.toString(),
              passwordController.text.toString(),
            );
          }, 'Login'),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: Text(
                  'Dont have an account?',
                  style: TextStyle(
                      color: Colors.blue[400], fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
