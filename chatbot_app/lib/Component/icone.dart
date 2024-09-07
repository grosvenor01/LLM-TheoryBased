import 'package:flutter/material.dart';

class messageType extends StatelessWidget {
  final iconName;
  const messageType({required this.iconName, super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth*0.12,
      width: screenWidth*0.12,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 128, 128, 128),
      ),
      child: Icon(
        iconName,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
