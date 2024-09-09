import 'package:chatbot/Component/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class messageT {
  var content;
  var messageType;
  messageT(this.content, this.messageType);
}

class _HomeState extends State<Home> {
  var response;
  var question = "";
  List messages = [];
  Future<void> botcall() async {
    const url = "http://localhost:8000";
    response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "content": question,
        }));
    final data = json.decode(response.body);
    question = "";
    print(data);
    messages.add(messageT(data["output"], "recieve"));
    setState(() {
      
    });
  }

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                    for (var i = 0; i < messages.length;i++)
                      message(
                          content:  messages[i].content,
                          type: messages[i].messageType),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.8, // Full width for the input field
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
                      setState(() {
                        question = value;
                      });
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
                    messages.add(messageT(question, "send"));
                    setState(() {
                      
                    });
                    botcall();
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
