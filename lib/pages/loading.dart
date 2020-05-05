import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0xFFf2f6f8),
      statusBarIconBrightness: Brightness.dark,
    ));
   return Container(
      color: const Color(0xFFf2f6f8),
//      backgroundColor: const Color(0xFFf2f6f8),
      child: Center(
        child: SpinKitDoubleBounce(
          color: const Color(0xFFFA5252),
          size: 100.0,
        ),
      ),
    );
  }
}