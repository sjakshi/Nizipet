import 'package:flutter/material.dart';
import 'package:nizipet1/auth/forgetpasseordimp.dart';
import 'package:get/get.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordImp controller = Get.put(ForgetPasswordImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
            'Verification Code',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Color(0xFF000033)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Color(0xFF7C9D8E),
            Color(0xFF89a799),])
        ),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
        child: ListView(
          children: [
            Text(
              'Verify the email address',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF000033),
                  fontWeight: FontWeight.bold,)
            ),
            SizedBox(height: 30,),
            TextField(
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
            ElevatedButton(onPressed: (){
              controller.goToVerifyCode();
              // Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
            },
              child: Text('Verify',
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
        )
      ),
    );
  }
}
