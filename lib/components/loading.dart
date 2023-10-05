// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  bool? isLoading;
  Widget child;
  AppLoading({super.key, this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      return Center(child: CircularProgressIndicator(color: Colors.black));
    } else if (isLoading == false) {
      return Center(child: Text("Veriler Çekilemedi"));
    } else {
      return child;
    }
  }
}
