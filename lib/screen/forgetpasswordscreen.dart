import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nizipet1/api_connection/apicnnection.dart';
import 'package:nizipet1/screen/loginscreen.dart';

import 'package:http/http.dart' as http;

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();

  void resetPassword() async{
    final response = await http.post(Uri.parse(API.forgetpassword),body: {
      'email': emailcontroller.text,
    });

    if(response.statusCode == 200){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Sucess",style: TextStyle(color: Color(0xFF000033)),),
              content: Text("Your new Password has been sent to your email.",style:TextStyle(color: Color(0xFF000033)),),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text('Ok',style: TextStyle(color: Color(0xFF000033)),)),
              ],
            );
          },
          );
    }
    else{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Error",style: TextStyle(color: Color(0xFF000033)),),
              content: Text("There was as error resetting your password.\n Please try again",style: TextStyle(color: Color(0xFF000033)),),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                    child: Text("Ok",style: TextStyle(color: Color(0xFF000033)),))
              ],
            );
          },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // // backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Forget Password",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000033),
            ),
          ),
          iconTheme: IconThemeData(color: Color(0xFF000033)),
        ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Color(0xFF7C9D8E),
            Color(0xFF89a799),])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please enter Your email Address To Recive A verification Code',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF000033),
                fontWeight: FontWeight.bold,),),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.all(8.0),
              child: TextField(
                //controller: controller,
                decoration: InputDecoration(
                  labelText: "Enter your Email",
                  labelStyle: TextStyle(
                    color: Color(0xFF000033),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              resetPassword();
              // Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
            },
                child: Text('Check',
                  style: TextStyle(
                      color: Color(0xFF7C9D8E),
                    fontWeight: FontWeight.bold,
                  ),),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF000033),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


