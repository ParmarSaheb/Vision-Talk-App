import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visiontalk/pages/profile_page.dart';
import 'package:visiontalk/pages/signaling.dart';
import 'package:visiontalk/utils/mytext.dart';

class VideoCall extends StatefulWidget {
  final RTCVideoRenderer _remoteRenderer;
  final RTCVideoRenderer _localRenderer;
  final TextEditingController textEditingController;
  const VideoCall({
    required RTCVideoRenderer remoteRenderer,
    required RTCVideoRenderer localRenderer,
    required this.textEditingController,
    super.key,
  })  : _localRenderer = localRenderer,
        _remoteRenderer = remoteRenderer;

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  final Signaling signaling = Signaling();


  @override
  void initState() {
    widget._localRenderer.initialize();
    widget._remoteRenderer.initialize();
    signaling.onAddRemoteStream = ((stream) {
      widget._remoteRenderer.srcObject = stream;
      setState(() {});
    });
    super.initState();
  }
  
  @override
  void dispose() async {
    widget._localRenderer.dispose();
    widget._remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 255, 244),
      appBar: AppBar(
        title: myText("VisionTalk"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(
                        prefix: myText("ID: ",
                            fontweight: FontWeight.bold, fontsize: 17)),
                    controller: widget.textEditingController,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
              child: Stack(
            children: [
              
              RTCVideoView(widget._remoteRenderer),
              Positioned(
                  top: 20,
                  right: 20,
                  height: Get.height * 0.24,
                  width: Get.height * 0.15,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: RTCVideoView(widget._localRenderer, mirror: true)
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      signaling.hangUp(widget._localRenderer);
                      Get.off(const ProfilePage());
                    },
                    icon: const Icon(
                      Icons.call_end_sharp,
                      color: Colors.white,
                    ),
                    label: myText("Hang Up", textColor: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 64, 64),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
