import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiontalk/restart_app.dart';
import 'package:visiontalk/utils/mytext.dart';

class NoInternet extends StatefulWidget {
  // final bool isNet;
  const NoInternet({super.key });

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.tealAccent,
              Color.fromARGB(255, 133, 216, 255),
              Color.fromARGB(255, 240, 158, 255),
            ])),
            child:  Center(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myText("No Internet",
                              fontsize: Get.width * 0.12,
                              textColor: Colors.black),
                          SizedBox(
                            width: Get.width * 0.8,
                            height: 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 0, 133, 119)),
                                onPressed: () {
                                  RestartWidget.restartApp(context);
                                },
                                child: myText("Refresh",
                                    fontweight: FontWeight.bold,
                                    textColor: Colors.white,
                                    fontsize: Get.width * 0.07)),
                          )
                        ],
                      ),
                    )),
            ),
          );
  }
}