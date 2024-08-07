import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:todo_app/controllers/registration_controller.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/utils/themes/colorsp.dart';
import 'package:todo_app/view/screens/signin.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final RegistrationController registrationController =
        Get.put(RegistrationController());
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return SingleChildScrollView(
            child: Container(
              color: kSmokeWhite,
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: size.height * 0.38,
                      width: size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images/1.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            "Register to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              height: 1.2,
                              color: kBlueAccent,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, -1),
                                  blurRadius: 3,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 38),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextField(
                              controller: _emailController,
                              onChanged: (value) =>
                                  registrationController.email.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                filled: true,
                                fillColor: kSmokeWhite,
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextField(
                              controller: _passwordController,
                              onChanged: (value) =>
                                  registrationController.password.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                filled: true,
                                fillColor: kSmokeWhite,
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150, // Set the width to the desired size
                                height:
                                    50, // Set the height to the desired size
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kBlueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    shadowColor: Colors.black12,
                                    elevation: 20,
                                  ),
                                  onPressed: () {
                                    registrationController.email.value =
                                        _emailController.text;
                                    registrationController.password.value =
                                        _passwordController.text;
                                    AuthService().Regin(
                                        email:
                                            registrationController.email.value,
                                        password: registrationController
                                            .password.value,
                                        context: context);
                                    print('Register button pressed');
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              //const SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: size.height * 0.08),
                          RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                color: kTextColorSecondary,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => const SignIn());
                                    },
                                ),
                                const TextSpan(
                                  text: " here!",
                                  style: TextStyle(
                                    color: kTextColorSecondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
