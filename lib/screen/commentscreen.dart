import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nizipet1/api_connection/apicnnection.dart';
import '../userPreferences/current_user.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _commentController = TextEditingController();
  final CurrentUser _currentUser = Get.put(CurrentUser()) ;

  buildComments()  async {
    try{
      var res = await http.post(
          Uri.parse(API.comment),
          body: {
            'comment' : _commentController.text.trim(),
          }
      );

      // http 200 means success status (ok status)
      if(res.statusCode == 200) // from flutter app the connection with api to server - success
          {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if(resBodyOfValidateEmail['success'] == true){
          Fluttertoast.showToast(msg: 'Comment added');
        }
        else{
          Fluttertoast.showToast(msg: "Check your connection");
          // Register and save the data of new user
        }
      }

    }
    catch(e)
    {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  addcomment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Post',
          style: TextStyle(
              color: Color(0xFF000033),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF000033),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
              title: TextFormField(
                controller: _commentController,
                decoration: InputDecoration(
                    labelText: "Write a comment",
                    labelStyle: TextStyle(color: Color(0xFF000033))),
              ),
              trailing:
                  OutlinedButton(onPressed: addcomment(), child: Text("Post")))
        ],
      ),
    );
  }
}
