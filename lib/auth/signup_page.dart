import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiontalk/controller/getx_controller.dart';
import 'package:visiontalk/route_generator.dart';
import 'package:visiontalk/utils/mytext.dart';
import 'package:visiontalk/utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

   final loginController = Get.put(LoginController());
  final signUpController = Get.put(SignUpController());
  final passvisibController = Get.put(PasswordVisibilityController());

  final _formKey = GlobalKey<FormState>();
  final _unameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String username = '';
  String email = '';
  String mobile = '';
  String password = '';
  String confirmPass = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils().appBar(loginController:loginController ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  myText(
                    "User SignUp",
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (uname) {
                      if (uname!.isEmpty) {
                        return "Username is required..";
                      } else {
                        return null;
                      }
                    },
                    controller: _unameController,
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3))),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Email is required..";
                      } else if (!email.contains('@')) {
                        return "Enter valid email...";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3))),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (mobile) {
                      if (mobile!.isEmpty) {
                        return "Mobile No. is required..";
                      } else if (mobile.length != 10) {
                        return "Enter valid mobile no...";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    controller: _mobileController,
                    decoration: InputDecoration(
                        prefix: const Text(
                          "+91 ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter 10 digit mobile",
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3))),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => TextFormField(
                        validator: (pass) {
                          if (pass!.isEmpty) {
                            return "Password is required..";
                          } else if (pass.length < 8) {
                            return "Password must be 8 char long..";
                          } else {
                            return null;
                          }
                        },
                        obscureText:
                            passvisibController.isPasswordVisible.value,
                        controller: _passController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  passvisibController.toggleVisibility(),
                              icon: passvisibController.isPasswordVisible.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            hintText: "Password",
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(3))),
                      )),
                  const SizedBox(height: 10),
                  Obx(() => TextFormField(
                        validator: (confirmPass) {
                          if (confirmPass!.isEmpty) {
                            return "Enter same password..";
                          } else if (confirmPass !=
                              _passController.text.toString()) {
                            return "Password doesn't match..";
                          } else {
                            return null;
                          }
                        },
                        obscureText: passvisibController.isConPassVisible.value,
                        controller: _confirmPassController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  passvisibController.toggleConPassVisibility(),
                              icon: passvisibController.isConPassVisible.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            hintText: "Confirm Password",
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(3))),
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              username =
                                  _unameController.text.toString().trim();
                              email = _emailController.text.toString().trim();
                              mobile = _mobileController.text.toString().trim();
                              password = _passController.text.toString().trim();
                              confirmPass =
                                  _confirmPassController.text.toString().trim();
                              // signUpController.signUp(
                              //     username: username,
                              //     email: email,
                              //     mobile: mobile,
                              //     password: password);
                              signUpController.verifyPhone(
                                username: username,
                                email: email,
                                mobile: mobile,
                                password: password,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.all(10)),
                          child: signUpController.loading2.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : myText("Sign Up",
                                  textColor: Colors.white, fontsize: 20)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed(
                        RouteGenerator.loginPage,
                      );
                    },
                    child: myText("Already have an account? Login",
                        textColor: Colors.teal, fontsize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
