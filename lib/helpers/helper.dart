import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHelper {
  static initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
