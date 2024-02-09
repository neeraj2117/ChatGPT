import 'package:ChatGPT/screens/login.dart';
import 'package:ChatGPT/screens/signup.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FadeInDown(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 800),
            child: Center(
              child: Container(
                height: 480,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50.0)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/first.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 25),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'ChatGPT Clone Application',
                    style: GoogleFonts.poorStory(
                        fontSize: 55, fontWeight: FontWeight.w700, height: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 10),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 900),
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'This is a chatbot application made by Neeraj \nby using Flutter, Dart and Firebase..',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 1100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 1100),
                      duration: const Duration(milliseconds: 1100),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Color(0xFF835DF1),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
