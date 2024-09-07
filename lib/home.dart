import 'package:chatbot/Component/icone.dart';
import 'package:chatbot/Component/message.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions:  const [
          SizedBox(width: 20,),
          Text("Revo Bot",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold
          ),),
          Spacer(),
        ],
      ),
    body:Column(
      children: [
        Container(
          height: screenHeight *0.77,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                message(content: "idk", type: "recieve"),
                message(content: "idk", type: "send"),
                message(content: "idk", type: "recieve"),
                message(content: "idk", type: "send"),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
        
        Row(
          children: [
            const messageType(iconName: Icons.mic),
            const SizedBox(width: 10,),
            const messageType(iconName: Icons.file_open_rounded),
            const SizedBox(width: 10,),
            Container(
              width: screenWidth - (screenWidth*0.12*2+20+10),
              height: 50,
              padding: EdgeInsets.only(left: 7,right: 7),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(30)
              ),
              child: const TextField(
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  border:InputBorder.none,
                  hintText: "Wirte here you question"
                ),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.normal
                ),
              ),
            )
          ],
        )
      ],
    ),
    );
  }
}