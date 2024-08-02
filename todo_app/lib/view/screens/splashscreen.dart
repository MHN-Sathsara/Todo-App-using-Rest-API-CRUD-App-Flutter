import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils/themes/colorsp.dart';
import 'package:todo_app/view/screens/signin.dart';

class MySplashscreen extends StatelessWidget {
  const MySplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kSmokeWhite,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.53,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/3.jpg'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.6,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Your Day, Your Way",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        height: 1.2,
                        color: kBlueAccent,
                        shadows: [
                          Shadow(
                            offset: Offset(0, -1),
                            blurRadius: 10,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Suspendisse potenti. In faucibus massa arcu, ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: kTextColorSecondary,
                      ),
                    ),
                    SizedBox(height: size.height * 0.10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kBlueAccent.withOpacity(0.9),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
                            children: [
                              Container(
                                height: size.height * 0.08,
                                width: size.width / 2.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => const (),
                                    );
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kBlueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const SignIn(),
                                  );
                                },
                                child: const Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
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
  }
}
