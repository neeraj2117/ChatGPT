import 'package:ChatGPT/screens/chat_screen.dart';
import 'package:ChatGPT/services/ui_helper.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      // Show circular progress indicator
      setState(() {
        isLoading = true;
      });
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
        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully logged in!"),
            duration: Duration(seconds: 3),
          ),
        );

        // Wait for 2 seconds
        await Future.delayed(Duration(seconds: 2));
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        return UiHelper.CustomAlertBox(context, e.code.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(
          delay: const Duration(milliseconds: 900),
          duration: const Duration(milliseconds: 1000),
          child: Text(
            "SignUp Page",
            style: GoogleFonts.montserrat(
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        leading: FadeInDown(
          delay: const Duration(milliseconds: 900),
          duration: const Duration(milliseconds: 900),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          FadeInDown(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 900),
            child: Image.asset('assets/images/signup.png'),
          ),
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
          isLoading
              ? CircularProgressIndicator()
              : UiHelper.CustomButton(() {
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                }, 'SignUp'),
          const SizedBox(
            height: 15,
          ),
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 900),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account ?',
                    style: TextStyle(
                      color: Color(0xFF835DF1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
