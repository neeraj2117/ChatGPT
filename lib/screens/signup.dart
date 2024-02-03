import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/screens/chat_screen.dart';
import 'package:gpt_flutter/services/ui_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      UserCredential? usercredential;

      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(),
                ),
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
          "SignUp Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/signup.png'),
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
            height: 10,
          ),
          const SizedBox(
            height: 70,
          ),
          UiHelper.CustomButton(() {
            signUp(emailController.text.toString(),
                passwordController.text.toString());
          }, 'SignUp'),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
