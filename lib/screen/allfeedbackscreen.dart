
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllFeedbackScreen extends StatefulWidget {
  const AllFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<AllFeedbackScreen> createState() => _AllFeedbackScreenState();
}

class _AllFeedbackScreenState extends State<AllFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7c9d8e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Feed Back',
          style: TextStyle(
            color: Color(0xFF000033),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
      body: Card(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Text('No data found');
            }
            return ListView(
              children: snapshot.data!.docs.map((document){
                return Text(document['Message']);
              }).toList(),
            );
            },
        ),
      )
    );
  }
}
