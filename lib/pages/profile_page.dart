import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiontalk/controller/getx_controller.dart';
import 'package:visiontalk/pages/homepage.dart';
import 'package:visiontalk/pages/location_page.dart';
import 'package:visiontalk/pages/videochat_page.dart';
import 'package:visiontalk/utils/myText.dart';
import 'package:visiontalk/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bottomBarController = Get.put(BottomBarController());
  final loginController = Get.put(LoginController());

  final List<Widget> _pages = [
    const Home(),
    const Location(),
    const VideoChat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: Utils()
              .appBar(autoLeading: false, loginController: loginController,),
          body: _pages[bottomBarController.selectedIndex.value],
          bottomNavigationBar: myBottomBar()),
    );
  }

  BottomNavyBar myBottomBar() {
    return BottomNavyBar(
      animationDuration: const Duration(milliseconds: 300),
      itemCornerRadius: 15,
      curve: Curves.easeIn,
      backgroundColor: Colors.white60,
      selectedIndex: bottomBarController.selectedIndex.value,
      onItemSelected: (index) => bottomBarController.onItemSelected(index),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      iconSize: 30,
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: myText("Home", fontsize: 13),
          activeColor: Colors.teal,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.map_rounded),
          title: myText("Location", fontsize: 13),
          activeColor: Colors.orange,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.video_chat_outlined),
          title: myText("VChat", fontsize: 13),
          activeColor: Colors.purpleAccent,
        ),
      ],
    );
  }
}
