import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nizipet1/screen/commentscreen.dart';
import 'package:nizipet1/screen/loginscreen.dart';
import 'package:nizipet1/screen/navbarscreen.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../api_connection/apicnnection.dart';
import '../userPreferences/current_user.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  final CurrentUser _currentUser = Get.put(CurrentUser());

  Future allPerson() async {
    var url = Uri.parse(API.viewallpost);
    var response = await http.get(url);
    return jsonDecode(response.body);
    // return json.decoder;
  }

  postFooter() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => CommentScreen(),
          child: Icon(
            Icons.chat,
            color: Color(0xFF000033),
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget userInfoItemProfile(String userdata) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Text(userdata, style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }

  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
        initState: (currentState) {
          _rememberCurrentUser.getUserInfo();
        },
        builder: (context) {
          return Scaffold(
            drawer: NavBarScreen(),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text('Home Screen',
                style: TextStyle(
                  color: Color(0xFF000033),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              elevation: 0,
              // leading: IconButton(onPressed: () {
              //   Navigator.;
              // },
              //   icon: Icon(Icons.arrow_back_ios, color: Color(0xFF000033),
              //   ),
              // ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Color(0xFF000033)),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Color(0xFF7C9D8E),
              ),
              child: FutureBuilder(
                  future: allPerson(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return ListTile(
                            title: Container(child: Image.network(
                                "http://192.168.83.204/api_nizi_pet/user/uploads/${list[index]['image']}"),),
                            subtitle: Text(list[index]['name'],
                              textAlign: TextAlign.left,),
                          );
                        }) : Center(child: CircularProgressIndicator(),);
                  }),
            ),
          );
        }
    );
  }
}