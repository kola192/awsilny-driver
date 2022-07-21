import 'package:awsilny_driver/screens/home/earnings.dart';
import 'package:awsilny_driver/screens/home/home.dart';
import 'package:awsilny_driver/screens/home/orders/orders.dart';
import 'package:awsilny_driver/screens/home/profile.dart';
import 'package:awsilny_driver/services/auth.dart';
import 'package:awsilny_driver/shared/colors.dart';
import 'package:flutter/material.dart';

final AuthService _auth = AuthService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  bool loading = false;
  String title = 'الرئيسية';

  final pages = [
    const HomePage(),
    const EarnigsTabPage(),
    const Orders(),
    const ProfilePage(),
  ];

  void signOutFunction() async {
    setState(() {
      loading = true;
    });
    final res = await _auth.signOut();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: AppColor.lightColor,
            ),
            onPressed: signOutFunction,
            icon: const Icon(Icons.logout),
            label: Text('خروج', style: TextStyle(color: AppColor.lightColor)),
          ),
        ],
      ),
      body: pages[pageIndex],
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColor.appBarColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  title = 'الرئيسية';
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.home_filled,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  title = 'الطلبات';
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.local_taxi_rounded,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.local_taxi_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  title = 'الأرباح';
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.work_outline_outlined,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.work_outline_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
