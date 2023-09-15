import 'package:flutter/material.dart';
import 'package:visiontalk/auth/login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.network(
                  "https://img.freepik.com/free-vector/welcome-word-flat-cartoon-people-characters_81522-4207.jpg"),
              const Spacer(),
              const Text(
                "Welcome to VisionTalk",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginPage())));
                  },
                  icon: const Icon(Icons.login_rounded),
                  label: const Text("Get Started")),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}