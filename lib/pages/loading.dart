import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  void loadHome() async {
    //simulates an async call im wait on
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context,'/home');
    });
  }

  @override
  void initState() {
    super.initState();
    loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitSpinningLines(
        color: Colors.indigoAccent,
        size: 50.0,
      )),
    );
  }
}
