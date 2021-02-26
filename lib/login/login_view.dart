import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapi/auth/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController.to;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(backgroundColor: Colors.grey),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  semanticsLabel: 'Journapi Logo',
                  width: 150,
                  height: 150,
                ),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      minLines: 2,
                      maxLines: 3,
                      style: TextStyle(fontFamily: 'JetBrainsMono'),
                      controller: authController.tokenEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please insert API key';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff63b3ed),
                      ),
                      onPressed: () {
                        if (!formKey.currentState.validate()) {
                          return;
                        }
                        String token =
                            authController.tokenEditingController.text.trim();

                        authController.validateToken(token).then((bool isOK) {
                          if (!isOK) {
                            Get.snackbar(
                              'Registration failed',
                              'Please check API Key!',
                              icon: Icon(Icons.warning, color: Colors.white),
                              backgroundColor: Colors.red.withOpacity(0.8),
                              colorText: Colors.white,
                              barBlur: 0.0,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        });
                      },
                      child: Text(
                        'Register API Key',
                        style: TextStyle(fontFamily: 'JetBrainsMono'),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'How to find API Key?',
                        style: TextStyle(fontFamily: 'JetBrainsMono'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
