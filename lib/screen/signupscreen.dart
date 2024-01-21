import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nizipet1/api_connection/apicnnection.dart';
import 'package:nizipet1/model/user.dart';
import 'package:nizipet1/screen/loginscreen.dart';
import 'package:http/http.dart' as http;

import '../reusable_widget/reusable_widget.dart';
import 'homescreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var roledController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
        'user_email': emailController.text.trim(),
      });

      // http 200 means success status (ok status)
      if (res.statusCode ==
          200) // from flutter app the connection with api to server - success
      {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(msg: 'Try another email. It is in used');
        } else {
          // Fluttertoast.showToast(msg: "Register your email");
          // Register and save the data of new user
          RegisterAndSaveUserRecord();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  RegisterAndSaveUserRecord() async {
    User userModel = User(
      1,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      roledController.text.trim(),
    );
    try {
      var res = await http.post(
        Uri.parse(API.singUp),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfSingUp = jsonDecode(res.body);
        if (resBodyOfSingUp['user'] == true) {
          Fluttertoast.showToast(msg: 'SignUp Successfully');
          Get.to(()=>HomeScreen());

          // setState(() {
          //   nameController.clear();
          //   emailController.clear();
          //   passwordController.clear();
          //   roledController.clear();
          // });

        } else {
          Fluttertoast.showToast(msg: 'Try Again');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF7C9D8E),
          Color(0xFF89a799),
          // Color(0xFF9CA288),
          // Color(0xFF045F5F),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: LayoutBuilder(
          builder: (contex, cons) {
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

                    // signup Screen header
                    //logoWidget('assets/images/Pet.png'),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      // height: 350,
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black12,
                                offset: Offset(0, -3)),
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
                                      // name
                                      TextFormField(
                                        controller: nameController,
                                        validator: (val) => val == ""
                                            ? "Please write Name"
                                            : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Color(0xFF000033),
                                          ),
                                          hintText: "Name....",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF000033),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF000033),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 14, vertical: 6),
                                          fillColor: Color(0xFF000033),
                                        ),
                                      ),

                                      // Set space between two column
                                      SizedBox(
                                        height: 18,
                                      ),

                                      // Email
                                      TextFormField(
                                        controller: emailController,
                                        // validator: (val) => val == "" ? "Please write Email" : null,
                                        validator: (value) {
                                          final bool emailValid = RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value!);
                                          if (value.isEmpty) {
                                            return "Enter Email";
                                          } else if (!emailValid) {
                                            return "Enter Valid Email";
                                          }
                                        },
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF000033),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 14, vertical: 6),
                                          fillColor: Color(0xFF000033),
                                        ),
                                      ),

                                      // Set space between two column
                                      SizedBox(
                                        height: 18,
                                      ),

                                      //Password
                                      Obx(
                                        () => TextFormField(
                                          controller: passwordController,
                                          obscureText: isObsecure.value,
                                          // validator: (val) => val == "" ? "Please write Password" : null,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Password";
                                            } else if (passwordController
                                                    .text.length <
                                                8) {
                                              return "Password length should be more then 8 character";
                                            }
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Color(0xFF000033),
                                            ),
                                            suffixIcon: Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  isObsecure.value =
                                                      !isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Color(0xFF000033),
                                                ),
                                              ),
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                              color: Color(0xFF000033),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.black12,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.black12,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Color(0xFF000033),
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.black12,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 6),
                                            fillColor: Color(0xFF000033),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      // role of the user
                                      TextFormField(
                                        controller: roledController,
                                        validator: (val) => val == ""
                                            ? "Please write Role"
                                            : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.perm_identity_outlined,
                                            color: Color(0xFF000033),
                                          ),
                                          hintText: "Role...",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF000033),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF000033),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 14, vertical: 6),
                                          fillColor: Color(0xFF000033),
                                        ),
                                      ),

                                      //gape between two filed
                                      SizedBox(
                                        height: 18,
                                      ),

                                      // Submit button
                                      Material(
                                        color: Color(0xFF000033),
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          onTap: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              // Validate the email
                                              validateUserEmail();
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 28,
                                            ),
                                            child: Text(
                                              'SignUp',
                                              style: TextStyle(
                                                color: Color(0xFF7C9D8E),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),

                              SizedBox(
                                height: 10,
                              ),

                              // Already have account - button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have account? ",
                                    style: TextStyle(color: Color(0xFF000033)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(()=>LoginScreen());
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Color(0xFF000033),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ))
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
