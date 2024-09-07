import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class message extends StatelessWidget {
  final content;
  final type;
  const message({
    required this.content,
    required this.type,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      
      margin: type == "recieve" ? EdgeInsets.only(right: screenWidth*0.1 , top:10) : EdgeInsets.only(left: screenWidth*0.1,top: 10),
      width: screenWidth*0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: type == "recieve" ? const Color.fromARGB(255, 75, 75, 75) : const Color.fromARGB(139, 16, 0, 156)
      ),
      child: const Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididuntut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}
