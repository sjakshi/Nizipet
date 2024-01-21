import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nizipet1/screen/homescreen.dart';

import 'allfeedbackscreen.dart';

class FeedbackSceen extends StatefulWidget {
  const FeedbackSceen({Key? key}) : super(key: key);

  @override
  State<FeedbackSceen> createState() => _FeedbackSceenState();
}

class _FeedbackSceenState extends State<FeedbackSceen> {

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Future datainsert() async{
    Map<String, dynamic> message = {'Message':_controller.text};
    FirebaseFirestore.instance.collection("feedback").add(message);
  }

  // Future Getdata() async{
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot){
  //     if(!snapshot.hasData){
  //       return Text("No data found");
  //     }
  //     return ListView(
  //       children: snapshot.data.documents.map((document){
  //        return Text(document['Message']);
  //       }).toList(),
  //     );
  //   },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7C9D8E),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Feedback',
          style: TextStyle(
            color: Color(0xFF000033),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xFF000033),
          ),
        ),
        centerTitle: true,
      ),
      body: AlertDialog(
        backgroundColor: Color(0xFF7C9D8E),
        content: Form(
          key: _fromkey,
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Enter your feedback here",
                filled: true,
              ),
              maxLines: 10,
              maxLength: 4509,
              textInputAction: TextInputAction.done,
              validator: (String? text){
                if(text == null || text.isEmpty){
                  return "Please enter a value";
                }
                return null;
              },
            ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancle',style: TextStyle(color: Color(0xFF000033)),)),
          TextButton(onPressed: () async {
            datainsert();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllFeedbackScreen()));
            // if(_fromkey.currentState!.validate()){
            //   String? message;
            //   try{
            //     final collection = FirebaseFirestore.instance.collection('feedback');
            //     await collection.doc().set(
            //       {
            //         'timestamp' : FieldValue.serverTimestamp(),
            //         'feedback' : _controller.text,
            //       }
            //     );
            //   }
            //   catch(e){
            //     message = "Error when sending message";
            //   }
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text(message!)));
            //   Navigator.pop(context);
            // }
          },
              child: Text('Submit',style: TextStyle(color: Color(0xFF000033)),)),
        ],
      )
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:nizipet1/api_connection/apicnnection.dart';
//
// class FeedbackForm extends StatefulWidget {
//   @override
//   _FeedbackFormState createState() => _FeedbackFormState();
// }
//
// class _FeedbackFormState extends State<FeedbackForm> {
//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final messageController = TextEditingController();
//
//   void submitForm() async {
//     var url = API.feedback;
//     var response = await http.post(Uri.parse(url), body: {
//       'name': nameController.text,
//       'email': emailController.text,
//       'message': messageController.text,
//     });
//
//     if (response.statusCode == 200) {
//       // Show success message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Feedback submitted'),
//             content: Text('Thank you for your feedback!'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Show error message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('An error occurred. Please try again later.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             controller: nameController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your name';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               labelText: 'Name',
//             ),
//           ),
//           TextFormField(
//             controller: emailController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your email';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               labelText: 'Email',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
