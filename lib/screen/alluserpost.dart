import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../api_connection/apicnnection.dart';
import '../userPreferences/current_user.dart';
import 'commentscreen.dart';

class AllUserPost extends StatefulWidget {
  const AllUserPost({Key? key}) : super(key: key);

  @override
  State<AllUserPost> createState() => _AllUserPostState();
}

class _AllUserPostState extends State<AllUserPost> {
  final CurrentUser _currentUser = Get.put(CurrentUser()) ;

  Future allPerson() async{
    var url = Uri.parse(API.viewallpost);
    var response = await http.get(url);
    return jsonDecode(response.body);
    // return json.decoder;

  }

  postFooter() {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentScreen()));
          },
          child: Icon(
            Icons.chat,
            color: Color(0xFF000033),
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget userInfoItemProfile(String userdata){
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
          Text(userdata,style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Post',style: TextStyle(color: Color(0xFF000033),fontSize: 20,fontWeight: FontWeight.bold),),
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xFF000033),
          ),
        ),
          centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color:Color(0xFF7C9D8E),
        ),
        child: FutureBuilder(
          // initialData: userInfoItemProfile(_currentUser.user.user_name),
          // key: postFooter(),
          future: allPerson(),
            builder: (context,snapshot){
            if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData ? ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                  List list = snapshot.data;
                    return ListTile(
                        subtitle: Container(child: Image.network("http://192.168.83.204/api_nizi_pet/user/uploads/${list[index]['image']}"),),
                        title: Center(child: Text(list[index]['name'])),
                    );
              }) :
                  CircularProgressIndicator();
              // Center(
              //   child: CircularProgressIndicator(),);
            },),
      ),
    );
  }
}
