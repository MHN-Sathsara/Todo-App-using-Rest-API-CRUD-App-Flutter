import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:todo_app/controllers/sign_in_controller.dart';
import 'package:todo_app/utils/themes/colorsp.dart';
import 'package:todo_app/view/screens/password_reset_page.dart.dart';
import 'package:todo_app/view/screens/registration_page.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SignInController controller = Get.put(SignInController());

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
                          image: AssetImage('assets/images/2.jpg'),
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
                            "Please Sign In to continue",
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
                          const SizedBox(height: 10),
                          // CustomTextFeild(
                          //   controller: _emailController,
                          //   hintText: 'Email',
                          //   keyboardType: TextInputType.emailAddress,
                          //   prefixIcon: SvgPicture.asset(
                          //     'assets/icons/email-icon.svg',
                          //     fit: BoxFit.scaleDown,
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          // CustomTextFeild(
                          //   controller: _passController,
                          //   hintText: 'Password',
                          //   keyboardType: TextInputType.emailAddress,
                          //   prefixIcon: SvgPicture.asset(
                          //     'assets/icons/pass-icon.svg',
                          //     fit: BoxFit.scaleDown,
                          //   ),
                          //   suffixIcon: SvgPicture.asset(
                          //     'assets/icons/eye-icon.svg',
                          //     fit: BoxFit.scaleDown,
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextField(
                              onChanged: (value) =>
                                  controller.email.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextField(
                              onChanged: (value) =>
                                  controller.password.value = value,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          RichText(
                            text: TextSpan(
                              text: "Forgot Password? ",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => PasswordResetPage());
                                },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                    Get.to(() => const SignIn());
                                    print('Sign in button pressed');
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              //const SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: size.height * 0.06),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(
                                color: kTextColorSecondary,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: "Click here ",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => const RegistrationPage());
                                    },
                                ),
                                const TextSpan(
                                  text: "to Register !",
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
