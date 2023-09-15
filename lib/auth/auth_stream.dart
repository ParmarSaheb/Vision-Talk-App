import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:visiontalk/route_generator.dart';

class AuthStream extends StatefulWidget {
  const AuthStream({super.key});

  @override
  State<AuthStream> createState() => _AuthStreamState();
}

class _AuthStreamState extends State<AuthStream> {

// bool isNet = false;
//   Map _source = {ConnectivityResult.none: false};
//   final NetworkConnectivity _netConnectivity = NetworkConnectivity.instance;

//   @override
//   void initState() {
//     _netConnectivity.initialise();
//     _netConnectivity.myStream.listen((source) {
//       _source = source;
//       // 1.
//           isNet =
//               _source.values.toList()[0] ;
//       setState(() {});
//       print("+++++++++++++++++$isNet=========================");
//       }
//     );
//     super.initState();
//   }


// @override
//   void dispose() {
//         _netConnectivity.disposeStream();
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    return 
    // !isNet? NoInternet(isNet: isNet,):
    WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Scaffold(
                  backgroundColor: Color.fromARGB(255, 215, 255, 246),
                  body: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )));
            }
            final user = snapshot.data;
            if (user != null) {
              // print("user is logged in");
              // print(user);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Get.offNamed(RouteGenerator.profilePage);
              });
              return Container(
                color: Colors.teal,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              );
            } else {
              // print("user is not logged in");
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Get.offNamed(RouteGenerator.loginPage);
              });

              return Container(
                color: Colors.teal,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              );
            }
          }),
    );
  }
}