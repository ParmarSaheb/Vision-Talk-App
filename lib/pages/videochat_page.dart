import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:get/get.dart';
import 'package:visiontalk/controller/getx_controller.dart';
import 'package:visiontalk/pages/signaling.dart';
import 'package:visiontalk/pages/videocall.dart';
import 'package:visiontalk/utils/mytext.dart';

class VideoChat extends StatefulWidget {
  const VideoChat({super.key});

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  Signaling signaling = Signaling();
  final _localRenderer = webrtc.RTCVideoRenderer();
  final _remoteRenderer = webrtc.RTCVideoRenderer();
  String? roomId;
  final textEditingController = TextEditingController(text: '');

  // final _localVideoRenderer = webrtc.RTCVideoRenderer();
  final loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              height: Get.height * 0.59,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://assets-v2.lottiefiles.com/a/32f336b4-1152-11ee-bf09-6f281d25ea50/QIcZL1PdgW.gif",
                      ))),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () async {
                  await signaling.openUserMedia(
                      _localRenderer, _remoteRenderer);
                  roomId = await signaling.createRoom(_remoteRenderer);
                  textEditingController.text = roomId!;
                  setState(() {});
                  Get.off(VideoCall(
                      remoteRenderer: _remoteRenderer,
                      localRenderer: _localRenderer,
                      textEditingController: textEditingController));
                },
                child: myText(
                  "Generate Caller ID",
                  textColor: Colors.white,
                  fontsize: 20,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Form(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () async {
                    await signaling.openUserMedia(
                        _localRenderer, _remoteRenderer);
                    Get.defaultDialog(
                      title: "Enter/Paste ID",
                      content: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (id) {
                                if (id!.isEmpty) {
                                  return "Enter ID..!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: textEditingController,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      signaling.joinRoom(
                                        textEditingController.text.trim(),
                                        _remoteRenderer,
                                      );
                                      Get.off(
                                        VideoCall(
                                            remoteRenderer: _remoteRenderer,
                                            localRenderer: _localRenderer,
                                            textEditingController:
                                                textEditingController),
                                      );
                                    }
                                  },
                                  child: myText("Ok")),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: myText(
                    "Join by Caller ID",
                    textColor: Colors.white,
                    fontsize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
                onPressed: () {
                  Get.defaultDialog(
                      confirm: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: myText("Got it",
                              textColor: Colors.teal,
                              fontweight: FontWeight.bold)),
                      title: "User Guide",
                      titlePadding: EdgeInsets.only(top: 10, bottom: 20),
                      content: SingleChildScrollView(
                        child: Container(
                          child: myText("""
  -> First 'Generate caller id'
  -> Allow the permissions
  -> Copy the 'ID' displayed in above box
  -> Share this 'ID' to receiver 
  -> Ask him to click 'Join by caller id'
  -> Paste this 'ID' to dialog box
  -> You are now connected..!
                      
                      """, fontsize: 17),
                        ),
                      ));
                },
                child: myText("How to use ?", textColor: Colors.purple)),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
