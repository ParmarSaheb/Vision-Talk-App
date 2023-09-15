import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiontalk/controller/getx_controller.dart';
import 'package:visiontalk/route_generator.dart';
import 'package:visiontalk/utils/myText.dart';
import 'package:visiontalk/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //getx controllers
  final pvController = Get.put(PasswordVisibilityController());
  final loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String email = '';
  String password = '';

  @override 
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Utils().appBar(autoLeading: false,loginController: loginController),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox.shrink(),

                    // image
                    Container(
                      height: 320,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-135.jpg?w=360",
                              ))),
                    ),
                    const SizedBox(height: 10),
                    myText(
                      "User Login",
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // email field
                    TextFormField(
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Email field is required..";
                        } else if (!email.contains('@')) {
                          return "Enter valid email...";
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(3))),
                    ),
                    const SizedBox(height: 20),

                    // password field
                    Obx(() => TextFormField(
                          validator: (password) {
                            if (password!.isEmpty) {
                              return "Enter new password..";
                            } else if (password.length < 8) {
                              return "Password must be 8 char long..";
                            } else {
                              return null;
                            }
                          },
                          obscureText: pvController.isPasswordVisible.value,
                          controller: _passController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () =>
                                      pvController.toggleVisibility(),
                                  icon: pvController.isPasswordVisible.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              hintText: "Password",
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(3))),
                        )),
                    const SizedBox(height: 25),

                    //login button
                    Obx(
                      () => SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              email = _emailController.text.toString().trim();
                              password = _passController.text.toString().trim();
                              loginController.login(
                                  email: email, password: password);
                            }
                          },
                          icon: loginController.loading.value
                              ? const SizedBox()
                              : const Icon(
                                  Icons.login_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                          label: loginController.loading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : myText(
                                  "Login",
                                  fontsize: 20,
                                  textColor: Colors.white,
                                ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.all(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    //signup redirection
                    TextButton(
                      onPressed: () {
                        Get.offAndToNamed(RouteGenerator.signUpPage);
                      },
                      child: myText("Dont have an account? SignUp",
                          textColor: Colors.teal, fontsize: 15),
                    ),
                    const SizedBox(height: 30),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
