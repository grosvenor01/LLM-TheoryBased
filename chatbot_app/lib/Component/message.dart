import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class message extends StatelessWidget {
  final content;
  final type;
  const message({required this.content, required this.type, super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if(type == "recieve"){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: screenWidth*0.1,
            width: screenWidth*0.1,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: DecorationImage(image: AssetImage("image.png") , fit: BoxFit.fill)
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:const Color.fromARGB(255, 75, 75, 75),
            ),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: screenWidth * 0.05,),
        ],
      );
    }
    else{
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: screenWidth*0.05,),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(139, 16, 0, 156)),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: screenWidth*0.1,
            width: screenWidth*0.1,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: DecorationImage(image: AssetImage("image2.png") , fit: BoxFit.fill)
            ),
          ),
        ],
      );
    }
    
  }
}
