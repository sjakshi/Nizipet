import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nizipet1/screen/forgetpasswordscreen.dart';
import 'package:nizipet1/screen/dashboard.dart';
import 'package:nizipet1/screen/homescreen.dart';
import 'package:nizipet1/screen/signupscreen.dart';
import 'package:http/http.dart' as http;
import 'package:nizipet1/userPreferences/user_preferences.dart';

import '../api_connection/apicnnection.dart';
import '../model/user.dart';
import '../reusable_widget/reusable_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async
  {
    try{
      var res = await http.post(
          Uri.parse(API.login),
          body: {
            "user_email": emailController.text.trim(),
            "user_password": passwordController.text.trim(),
          }
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['Success'] == true) {
          Fluttertoast.showToast(msg: 'Login Successfully');

          User userInfo = User.fromJson(resBodyOfLogin["UserData"]);

          // Save user info for local storage using shared Perfrences
          await RememberUserPrefs.storeUserInfo(userInfo);

          // Get.to(DashboardScreen());
          Get.to(HomeScreen());
        }
        else {
          Fluttertoast.showToast(msg: 'Try Again');
        }
      }
    }
    catch(e){
      print('Error'+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: Text('Login Screen',style: TextStyle(
      //     color: Color(0xFF000033),
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //   ),),
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // backgroundColor: Color(0xFFcbd8d2),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF7C9D8E),
                  Color(0xFF89a799),
                  // Color(0xFF9CA288),
                  // Color(0xFF045F5F),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: LayoutBuilder(builder: (contex, cons){
          return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: cons.maxHeight,
              ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),

                  // login Screen header
                 // logoWidget('assets/images/Pet.png'),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    // height: 10,
                    child: Image.asset(
                      'assets/images/Pet.png',
                      fit: BoxFit.fitWidth,
                      height: 240,
                      width: 240,
                      color: Color(0xFF000033),
                    ),
                  ),

                  // Login Screen sign-up form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        // color: Colors.white24,
                        borderRadius: BorderRadius.all(Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black12,
                            offset: Offset(0, -3)
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            // Email-password-login button
                            Form(
                              key: formkey,
                                child: Column(
                                  children: [

                                    // Email
                                    TextFormField(
                                      controller: emailController,
                                      validator: (val) => val == "" ? "Please write Email" : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: Color(0xFF000033),
                                        ),
                                        hintText: "Email...",
                                        hintStyle: TextStyle(
                                          color: Color(0xFF000033),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF000033),
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                                        fillColor: Color(0xFF000033),
                                      ),
                                    ),

                                    // Set space between two column
                                    SizedBox(height: 18,),

                                    //Password
                                    Obx(
                                          () => TextFormField(
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == "" ? "Please write Password" : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_sharp,
                                          color: Color(0xFF000033),
                                        ),
                                        suffixIcon: Obx(
                                              () => GestureDetector(
                                            onTap: (){
                                              isObsecure.value = !isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                              color: Color(0xFF000033),
                                            ),
                                          ),
                                        ),
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: Color(0xFF000033),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF000033),
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                                        fillColor: Color(0xFF000033),
                                      ),
                                    ),
                                    ),

                                    SizedBox(height: 18,),

                                    // Forget Password
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   "Forget Password ",
                                        //   style: TextStyle(color: Color(0xFF000033)) ,),
                                        Material(
                                          color: Color(0xFF000033),
                                          borderRadius: BorderRadius.circular(30),
                                          child: InkWell(
                                            onTap: (){
                                              if(formkey.currentState!.validate())
                                                {
                                                  loginUserNow();
                                                }
                                            },
                                            borderRadius: BorderRadius.circular(30),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 28,
                                              ),
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: Color(0xFF7C9D8E),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: (){
                                              Get.to(ForgetPasswordScreen());
                                            },
                                            child: Text(
                                              'Forget Password',
                                              style: TextStyle(
                                                color: Color(0xFF000033),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ) ,))

                                      ],
                                    ),

                                    //const SizedBox(height: 18),

                                    // Submit button

                                  ],
                                )),

                            SizedBox(height: 10,),

                            // For don't have account - button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have account? ",
                                  style: TextStyle(color: Color(0xFF000033)) ,),
                                TextButton(
                                    onPressed: (){
                                      Get.to(SignUpScreen());
                                    },
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          color: Color(0xFF000033),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ) ,))
                              ],
                            ),
                          ],
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          );
        },
        ),
      ),
    );
  }
}
