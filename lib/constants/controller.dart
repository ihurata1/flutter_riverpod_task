import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root/controllers/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

final controller = ChangeNotifierProvider((ref) => Controller());
