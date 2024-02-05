import 'package:ChatGPT/screens/chat_screen.dart';
import 'package:ChatGPT/screens/signup.dart';
import 'package:ChatGPT/services/ui_helper.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;

  // login(String email, String password) async {
  //   if (email == "" && password == "") {
  //     return UiHelper.CustomAlertBox(context, "Enter required fields");
  //   } else {
  //     UserCredential? usercredential;
  //     try {
  //       usercredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);
  //       // ignore: use_build_context_synchronously
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Successfully logged in!"),
  //           duration: Duration(seconds: 1),
  //         ),
  //       );
  //       // ignore: use_build_context_synchronously
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const ChatScreen(),
  //         ),
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       // ignore: use_build_context_synchronously
  //       return UiHelper.CustomAlertBox(context, e.code.toString());
  //     }
  //   }
  // }

  login(String email, String password) async {
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
            .signInWithEmailAndPassword(email: email, password: password);

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully logged in!"),
            duration: Duration(seconds: 5),
          ),
        );

        // Wait for 2 seconds
        await Future.delayed(Duration(seconds: 2));

        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      } on FirebaseAuthException catch (e) {
        // Show error alert
        UiHelper.CustomAlertBox(context, e.code.toString());
      } finally {
        // Hide circular progress indicator
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
            "Login Page",
            style: GoogleFonts.montserrat(
              fontSize: 29,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        // leading: FadeInDown(
        //   delay: const Duration(milliseconds: 900),
        //   duration: const Duration(milliseconds: 900),
        //   child: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
      ),
      body: Column(
        children: [
          FadeInDown(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 900),
            child: Lottie.asset("assets/images/login.json", height: 370),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 330.0),
            child: FadeInDown(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 800),
              child: const Text(
                'Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
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
          Padding(
            padding: const EdgeInsets.only(right: 300.0),
            child: FadeInDown(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          UiHelper.CustomPasswordField(
            passwordController,
            'Enter your password',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Color(0xFF835DF1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 70,
          ),
          isLoading
              ? CircularProgressIndicator()
              : UiHelper.CustomButton(() {
                  login(
                    emailController.text.toString(),
                    passwordController.text.toString(),
                  );
                }, 'Login'),
          const SizedBox(
            height: 10,
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
                child: FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      color: Color(0xFF835DF1),
                      fontWeight: FontWeight.w500,
                    ),
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
