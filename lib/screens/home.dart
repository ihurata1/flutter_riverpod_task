// ignore_for_file: unused_local_variable, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:root/components/app_container.dart';
import 'package:root/components/loading.dart';
import 'package:root/constants/controller.dart';
import 'package:root/constants/navigator/page_route_effect.dart';
import 'package:root/constants/styles.dart';
import 'package:root/helpers/device_info.dart';
import 'package:root/helpers/navigator/navigator.dart';
import 'package:root/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(controller).getData();
    super.initState();
  }

  onTapLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", "");
    AppNavigator.pushAndRemoveUntil(screen: LoginScreen(), effect: AppRouteEffect.leftToRight);
  }

  Widget _card(index) {
    var watch = ref.watch(controller);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(watch.users[index].avatar ?? ""),
        ),
        title: Text(
          "${watch.users[index].firstName ?? ""} ${watch.users[index].lastName ?? ""}",
          style: AppTextStyle.titleStyle,
        ),
        subtitle: Text(
          "${watch.users[index].email ?? ""}",
          style: AppTextStyle.subTitleStyle,
        ),
      ),
    );
  }

  List<Widget> get _users {
    var watch = ref.watch(controller);
    List<Widget> tempList = [];
    for (int i = 0; i < watch.users.length; i++) {
      tempList.add(_card(i));
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(controller);
    var watch = ref.watch(controller);
    return AppContainer(
      child: AppLoading(
        isLoading: watch.isLoading,
        child: Container(
          padding: EdgeInsets.only(top: DeviceInfo.height(2)),
          child: Column(
            children: [
              Text(
                "Kullanıcılar",
                style: AppTextStyle.headerStyle,
              ),
              Container(height: DeviceInfo.height(3)),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      padding: EdgeInsets.only(top: DeviceInfo.height(3)),
                      child: ListView(children: _users))),
              GestureDetector(
                onTap: onTapLogOut,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: DeviceInfo.height(2)),
                  height: DeviceInfo.height(4),
                  width: DeviceInfo.height(20),
                  decoration: BoxDecoration(color: Colors.red.shade300, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Çıkıs Yap",
                      style: AppTextStyle.titleStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
