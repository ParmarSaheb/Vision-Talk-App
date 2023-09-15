import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:visiontalk/auth/verify_phone_page.dart';
import 'package:visiontalk/route_generator.dart';

class PasswordVisibilityController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isConPassVisible = true.obs;

  void toggleVisibility() {
    if (isPasswordVisible.value == false) {
      isPasswordVisible.value = true;
    } else {
      isPasswordVisible.value = false;
    }
  }

  void toggleConPassVisibility() {
    if (isConPassVisible.value == false) {
      isConPassVisible.value = true;
    } else {
      isConPassVisible.value = false;
    }
  }
}

class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
  RxBool logoutLoading = false.obs;

  Future<void> login({required String email, required String password}) async {
    bool navigat = true;
    loading.value = true;

    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        loading.value = false;
      });
    } catch (e) {
      Get.snackbar("Login Error", "Could not proceed..!");
      loading.value = false;
      navigat = false;
      // print("LOGIN ERROR --------------- $e");
    }
    if (navigat) {
      Get.offNamed(RouteGenerator.authStream);
    }
  }

  Future<void> logout() async {
    try {
      logoutLoading.value = true;
      await _auth.signOut().whenComplete(() {
        logoutLoading.value = false;
        Get.offNamed(RouteGenerator.authStream);
      });
    } catch (e) {
      Get.snackbar("Logout Error", "Cant proceed next due to some error..!");
      logoutLoading.value = false;
    }
  }
}

class BottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void onItemSelected(index) {
    selectedIndex.value = index;
  }
}

class SignUpController extends GetxController {
  RxBool loading = false.obs;
  RxBool loading2 = false.obs;
  RxBool loading3 = false.obs;
  final _auth = FirebaseAuth.instance;

  Future<void> verifyPhone({
    required String username,
    required String email,
    required String mobile,
    required String password,
  }) async {
    loading2.value = true;
    const code = "+91";
    final mobileNo = code + mobile;

    await _auth.verifyPhoneNumber(
      phoneNumber: mobileNo,
      verificationCompleted: (_) {
        loading2.value = false;
      },
      verificationFailed: (e) {
        Get.snackbar("Verification Failed", "$e");
        // print("VerificationFailed : $e");
        loading2.value = false;
      },
      codeSent: (String verificationId, int? token) {
        Get.to(VerifyPhone(
          verificationId: verificationId,
          phoneNo: mobileNo,
          email: email,
          password: password,
          username: username,
        ));
        loading2.value = false;
      },
      codeAutoRetrievalTimeout: (e) {
        //Get.snackbar("Timeout", "CodeAutoRetrievalTimeout.. try again..!");
        loading2.value = false;
      },
    );
  }

  Future<void> verifyOtp(
      {verificationId, sms, phoneNo, username, email, password}) async {
    loading3.value = true;
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: sms);

    try {
      await _auth.signInWithCredential(credential);
      await signUp(
          username: username,
          email: email,
          mobile: phoneNo,
          password: password);
      Get.offNamed(RouteGenerator.authStream);
      loading3.value = false;
      // print("$credential");
    } catch (e) {
      Get.snackbar("Error", "Can't verify mobile");
      loading3.value = false;
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      loading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await addUser(
          username: username, email: email, mobile: mobile, password: password);
    } catch (e) {
      loading.value = false;
      Get.snackbar("SignUp error", "Cant create user due to : $e");
    }
  }

  Future<void> addUser({
    required String username,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userInfo = firestore.collection("userInfo");
      final getUserId = _auth.currentUser!.uid;
      await userInfo.doc(getUserId).set({
        "username": username,
        "email": email,
        "mobile": mobile,
        "password": password,
      });
    } catch (e) {
      Get.snackbar("AddUser Error", "Cant add user due to : $e");
    }
  }
}
