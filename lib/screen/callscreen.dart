import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'addcontactscreen.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

   // Query _ref ="" as Query;
  late Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    _ref = FirebaseDatabase.instance.reference()
    .child('Contacts')
    .orderByChild('name');
  }

  Widget _buildContactItem({required Map<dynamic,dynamic> contact}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color(0xFF000033),
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['name'],
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF000033),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(
                Icons.phone_iphone,
                color: Color(0xFF000033),
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['number'],
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF000033),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40,width: 100,),
              IconButton(
                  onPressed: () async {
                    FlutterPhoneDirectCaller.callNumber(contact['number']);
                    // launch(('tel://${contact['number']}'));
                  },
                  icon: Icon(Icons.phone,
                    color: Color(0xFF000033),)
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7C9D8E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Call Page',
          style: TextStyle(
            color: Color(0xFF000033),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF000033),
          ),
        ),
        centerTitle: true,
      ),
      // To view the contact list from the databse and make a phone call
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
            query: _ref,
            itemBuilder: (BuildContext context,
                DataSnapshot snapshot,Animation<double>animation,int index){
              Map contacts = snapshot.value as Map;
              return _buildContactItem(contact: contacts);
            },
        ),
      ),
      // To save the data to the database
      // floatingActionButton: FloatingActionButton(
      //     onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (_){
      //         return AddContactScreen();
      //       }));
      //     },
      //     child: Icon(Icons.add,color: Color(0xFF000033),),
      // ),
    );
  }
}