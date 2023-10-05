import 'package:flutter/material.dart';
import 'package:root/constants/navigator/page_route_effect.dart';
import 'package:root/helpers/navigator/navigator.dart';
import 'package:root/models/user/login/response.dart';
import 'package:root/models/user/response.dart';
import 'package:root/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/service.dart';

class Controller extends ChangeNotifier {
  bool? isLoading;

  List<UserResponseModelData> users = [];

  UserLoginResponseModel? authenticatedUser;

  void getData() {
    Service.fetch().then((value) {
      if (value != null) {
        users = value.data!;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void login(email, password) async {
    authenticatedUser = await Service.postEmailAndPassword(email, password);
    if (authenticatedUser != null) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("token", authenticatedUser!.token.toString());
    }
    AppNavigator.push(screen: HomeScreen(), effect: AppRouteEffect.fade);
  }
}
