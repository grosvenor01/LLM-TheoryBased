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
      backgroundColor: Color(0xFF1A1A1A), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C2C), // Slightly lighter AppBar
        title: const Text(
          "Revo Bot",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  message(content: "Hello! How can I assist you today?",type: "recieve"),
                  SizedBox(width: 10,),
                  message(content: "I need help with my order.", type: "send"),
                  SizedBox(width: 10,),
                  message(content: "Sure! Can you provide your order number?",type: "recieve"),
                  SizedBox(width: 10,),
                  message(content: "It's 12345.", type: "send"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: screenWidth*0.8, // Full width for the input field
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF2C2C2C), // Background color for input
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade600),
                  ),
                  constraints: const BoxConstraints(
                    maxHeight: 100, // Set a max height
                  ),
                  child: TextField(
                    onChanged: (value) {
                      print(value);
                    },
                    textAlign: TextAlign.left,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Write here your question",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Implement send action
                    print("Send message");
                  },
                  icon: Icon(Icons.send),
                  color: Colors.blueAccent,
                  iconSize: 30,
                  padding: EdgeInsets.only(left: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
