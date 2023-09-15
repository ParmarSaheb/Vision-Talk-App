import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:visiontalk/auth/auth_stream.dart';
import 'package:visiontalk/connectivity/no_internet_page.dart';

class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({Key? key}) : super(key: key);
  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isNet = false;

  @override
  void initState() {
   
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen(
      (source) {
        _source = source;
        isNet = _source.values.toList()[0];
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isNet
        ? const AuthStream()
        : const NoInternet(
            
          );
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    if (isOnline) {
      _controller.sink.add({result: isOnline});
    }
  }

  void disposeStream() => _controller.close();
}
