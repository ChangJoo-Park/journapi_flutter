import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapi/auth/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journapi/widgets/animated_logo.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController.to;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color(0xfff7fafc),
            title: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  semanticsLabel: 'Journapi Logo',
                  width: 30,
                  height: 30,
                ),
                Text(
                  'Journapi',
                  style: TextStyle(
                    fontFamily: 'JetBrainsMono',
                    color: Colors.grey.shade800,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 64),
                AnimatedLogo(),
                SizedBox(height: 16),
                Container(
                    child: Text(
                  'The techie bullet journal',
                  style: TextStyle(
                    fontFamily: 'JetBrainsMono',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4a5568),
                  ),
                ))
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
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
                          primary: Color(0xff63b3ed), elevation: 0),
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
                        style: TextStyle(
                          fontFamily: 'JetBrainsMono',
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        launch('https://journapi.app/');
                      },
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
