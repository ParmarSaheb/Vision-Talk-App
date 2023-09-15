import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visiontalk/controller/getx_controller.dart';
import 'package:visiontalk/utils/myText.dart';

class Utils {
  AppBar appBar(
      {required LoginController loginController, autoLeading = true}) {
    final loginController0 = loginController;
    return AppBar(
      automaticallyImplyLeading: autoLeading,
      title: myText("VisionTalk", textColor: Colors.white),
      // backgroundColor: Get.theme.colorScheme.inversePrimary,
      // elevation: 0.2,

      backgroundColor: const Color.fromARGB(255, 1, 128, 128),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Share this app",
                  middleText: "Cant share as App is not in play store.",
                );
              },
              icon: const Icon(
                Icons.share,
                size: 25,
                color: Colors.white,
              )),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: "Logout..?",
                  backgroundColor: Colors.tealAccent,
                  titleStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                  titlePadding: const EdgeInsets.only(top: 18, bottom: 10),
                  middleText: "Are you sure to logout..?",
                  middleTextStyle: GoogleFonts.poppins(),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: myText("No",
                          fontweight: FontWeight.bold, textColor: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();

                        loginController0.logout();
                      },
                      child: myText(
                        "Yes",
                        fontweight: FontWeight.bold,
                        textColor: Colors.green,
                      ),
                    ),
                  ],
                );
              },
            ))
      ],
    );
  }
}
