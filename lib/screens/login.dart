// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root/components/app_container.dart';
import 'package:root/constants/controller.dart';
import 'package:root/constants/styles.dart';
import 'package:root/helpers/device_info.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isPasswordVisible = false;
  bool emailValidationError = false;
  bool passworValidationError = false;

  onTapLogin() {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);

    if (emailValid) {
      setState(() {
        emailValidationError = false;
      });
      if (validatePassword(passwordController.text) == null) {
        setState(() {
          passworValidationError = false;
        });
        ref.read(controller).login(emailController.text, passwordController.text);
      } else {
        setState(() {
          passworValidationError = true;
        });
      }
    } else {
      setState(() {
        emailValidationError = true;
      });
    }
  }

  String? validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (value.length < 6) {
        return 'Şifre en az 6 karakter olmalı!';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: DeviceInfo.width(4)),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Login",
                  style: AppTextStyle.headerStyle,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email", errorText: emailValidationError ? "E-mail hatalı" : null),
                  ),
                  Container(height: DeviceInfo.height(4)),
                  TextField(
                    controller: passwordController,
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: GestureDetector(
                          child: Icon(
                            Icons.remove_red_eye,
                            color: isPasswordVisible ? Colors.black : Colors.grey,
                          ),
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        errorText: passworValidationError ? validatePassword(passwordController.text) : null),
                  ),
                  Container(height: DeviceInfo.height(4)),
                  GestureDetector(
                    onTap: onTapLogin,
                    child: Container(
                      height: DeviceInfo.height(4),
                      width: DeviceInfo.height(20),
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Giris Yap",
                          style: AppTextStyle.titleStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
