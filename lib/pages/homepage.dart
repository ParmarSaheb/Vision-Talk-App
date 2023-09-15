import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiontalk/controller/getx_controller.dart';
import 'package:visiontalk/pages/location_page.dart';
import 'package:visiontalk/utils/myText.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final loginController = Get.put(LoginController());
  CollectionReference users = FirebaseFirestore.instance.collection('userInfo');

  String getUserId() {
    try {
      String getUid;
      final auth = FirebaseAuth.instance;
      getUid = auth.currentUser!.uid;
      return getUid;
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
    return '';
  }

  String name = "";
  String email = "";
  String mobile = "";

  String img =
      'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: users.doc(getUserId()).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            name = data['username'] ?? "Unknown User";
            email = data['email'] ?? "unknown email";
            mobile = data['mobile'] ?? "unknown mobile";
          }
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 184, 255, 238),
            body: Center(
              child: Column(
                children: [
                  myText("User Profile",
                      textColor: const Color.fromARGB(255, 0, 77, 69),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 48,
                      child: ClipOval(
                          child: Image.network(
                        img,
                      )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  myText("Name : $name"),
                  const SizedBox(height: 10),
                  myText("Email : $email"),
                  const SizedBox(height: 10),
                  myText("Mobile : $mobile"),

                  //
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Get.to(const Scaffold(
                        body: Location(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: Get.height * 0.42,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_XE5lix1HmGW5nv_kh45eipjJkQB963s_A6hSb1Ir09aB1llikoZktg7AjaQBEheq_6M&usqp=CAU",
                                ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
