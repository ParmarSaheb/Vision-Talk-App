import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiontalk/controller/getx_controller.dart';

class VerifyPhone extends StatefulWidget {
  final String verificationId;
  final String phoneNo;
  final String username;
  final String email;
  final String password;
  const VerifyPhone(
      {super.key,
      required this.verificationId,
      required this.phoneNo,
      required this.username,
      required this.email,
      required this.password});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final signUpController = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();
  final _verifyPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox.shrink(),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-135.jpg?w=360",
                          ))),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  style: const TextStyle(letterSpacing: 6, fontSize: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter OTP to verify ..";
                    } else {
                      return null;
                    }
                  },
                  controller: _verifyPhoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "000000",
                    helperText: "Enter 6 digit code..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      gapPadding: 5,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await signUpController.verifyOtp(
                            verificationId: widget.verificationId,
                            sms: _verifyPhoneController.text.toString().trim(),
                            phoneNo: widget.phoneNo,
                            email: widget.email,
                            password: widget.password,
                            username: widget.username,
                          );
                        }
                      },
                      icon: signUpController.loading3.value
                          ? const SizedBox()
                          : const Icon(Icons.check),
                      label: signUpController.loading3.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Verify"),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15)),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
