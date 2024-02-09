import 'package:ChatGPT/screens/chat_screen.dart';
import 'package:ChatGPT/screens/signup.dart';
import 'package:ChatGPT/services/ui_helper.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool isLoading = false;

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  /// rive controller and input
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  login(String email, String password) async {
    if (email == "" && password == "") {
      trigFail?.change(true);
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
        trigSuccess?.change(true);

        // Show success snackbar
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully logged in!"),
            duration: Duration(seconds: 5),
          ),
        );

        // Wait for 2 seconds
        await Future.delayed(const Duration(seconds: 2));

        // Navigate to home screen
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      } on FirebaseAuthException catch (e) {
        // Show error alert
        // ignore: use_build_context_synchronously
        trigFail?.change(true);
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
    print("Build Called Again");
    return Scaffold(
      // backgroundColor: Color(0xFFD6E2EA),
      appBar: AppBar(
        // backgroundColor: Color(0xFFD6E2EA),
        title: FadeInDown(
          delay: const Duration(milliseconds: 900),
          duration: const Duration(milliseconds: 1000),
          child: Text(
            "Login Page",
            style: GoogleFonts.montserrat(
              fontSize: 29, fontWeight: FontWeight.w600,
              //  color: Colors.black
            ),
          ),
        ),
        centerTitle: true,
        leading: FadeInDown(
          delay: const Duration(milliseconds: 900),
          duration: const Duration(milliseconds: 900),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              // color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: 400,
              child: FadeInDown(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1100),
                child: RiveAnimation.asset(
                  "assets/images/login-teddy.riv",
                  fit: BoxFit.fitHeight,
                  stateMachines: const ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                        artboard, "Login Machine");
                    if (controller == null) return;

                    artboard.forEachComponent(
                      (child) {
                        if (child is Shape) {
                          final Shape shape = child;
                          // shape.fills.first.paint.color = Colors.white;
                          (shape.fills.first.children[0] as SolidColor)
                              .colorValue = (Colors.black).value;
                        }
                      },
                    );

                    artboard.addController(controller!);
                    isChecking = controller?.findInput("isChecking");
                    numLook = controller?.findInput("numLook");
                    isHandsUp = controller?.findInput("isHandsUp");
                    trigSuccess = controller?.findInput("trigSuccess");
                    trigFail = controller?.findInput("trigFail");
                  },
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16,
                //     vertical: 8,
                //   ),
                //   child: TextField(
                //     focusNode: emailFocusNode,
                //     controller: emailController,
                //     decoration: const InputDecoration(
                //       border: InputBorder.none,
                //       hintText: "Email",
                //     ),
                //     style: Theme.of(context).textTheme.bodyMedium,
                //     onChanged: (value) {
                //       numLook?.change(value.length.toDouble());
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 290.0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 700),
                    child: TextField(
                      focusNode: emailFocusNode,
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      },
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        suffixIcon: const Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16,
                //     vertical: 8,
                //   ),
                //   child: TextField(
                //     focusNode: passwordFocusNode,
                //     controller: passwordController,
                //     decoration: const InputDecoration(
                //       border: InputBorder.none,
                //       hintText: "Password",
                //     ),
                //     obscureText: true,
                //     style: Theme.of(context).textTheme.bodyMedium,
                //     onChanged: (value) {},
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(right: 260.0),
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 800),
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
                FadeInDown(
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 700),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: TextField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
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
                const SizedBox(height: 60),

                isLoading
                    ? const CircularProgressIndicator()
                    :
                    // UiHelper.CustomButton(
                    //     () {
                    //       login(
                    //         emailController.text.toString(),
                    //         passwordController.text.toString(),
                    //       );
                    //     },
                    //     'Login',
                    //   ),
                    SizedBox(
                        height: 50,
                        width: 300,
                        child: FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: ElevatedButton(
                            onPressed: () {
                              login(emailController.text.toString(),
                                  passwordController.text.toString());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
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
            )
          ],
        ),
      ),
    );
  }
}
