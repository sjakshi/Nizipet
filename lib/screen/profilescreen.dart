import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nizipet1/screen/loginscreen.dart';
import 'package:nizipet1/userPreferences/current_user.dart';
import 'package:nizipet1/userPreferences/user_preferences.dart';

class ProfileScreen extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser()) ;

  signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        // backgroundColor: Color(0xFF000033),
        backgroundColor: Colors.white10,
        title: Text(
            'LogOut',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7C9D8E),
          ),
        ),
        content: Text(
            'Are You sure? \n You want to logOut form App',
          style: TextStyle(
            color: Color(0xFF7C9D8E),
          ),
        ),
        actions: [
          TextButton(
              onPressed: (){
                Get.back();
              },
              child: Text(
                  'No',
                style: TextStyle(
                  color: Color(0xFF7C9D8E),
                ),
              )),
          TextButton(
              onPressed: (){
                Get.back(result: "LoggedOut");
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Color(0xFF7C9D8E),
                ),
              )),
        ],
      ),
    );

    if(resultResponse == 'LoggedOut'){
      // delete or remove the user data from the local storage
      RememberUserPrefs.removeUserInfo().then((value){
        Get.off(LoginScreen());
      });
    }
  }

  Widget userInfoItemProfile(IconData icondata, String userdata){
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
          Icon(icondata,size: 30,color: Color(0xFF000033),),
          SizedBox(width: 16,),
          Text(userdata,style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7C9D8E),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Profile',
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
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(32)),
          // Center(
          //   child: Image.asset('assets/images/woman.png',width: 200,),
          // ),
          // SizedBox(height: 20,),

          userInfoItemProfile(Icons.person, _currentUser.user.user_name),
          SizedBox(height: 20,),
          userInfoItemProfile(Icons.mail, _currentUser.user.user_email),
          SizedBox(height: 20,),
          userInfoItemProfile(Icons.person, _currentUser.user.user_role),
          Center(
            child: Material(
              color: Color(0xFF000033),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: (){
                  signOutUser();
                },
                borderRadius: BorderRadius.circular(32),
                child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12),
                    child: Text(
                      'LogOut',
                      style: TextStyle(
                        color: Color(0xFF7C9D8E),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
