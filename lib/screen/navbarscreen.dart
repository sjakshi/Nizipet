import 'package:flutter/material.dart';
import 'package:nizipet1/screen/alluserpost.dart';
// import 'package:nizipet1/screen/dashboard.dart';
import 'package:nizipet1/screen/homescreen.dart';
import 'package:nizipet1/screen/loginscreen.dart';
import 'package:nizipet1/screen/postuploadscreen.dart';
import 'package:nizipet1/screen/profilescreen.dart';

import 'callscreen.dart';
import 'feedbacksceen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFb0c4bb),
      child: ListView(
        children: [
          Divider(),
          // UserAccountsDrawerHeader(
          //   accountName: Text('Jakshi'),
          //   accountEmail: Text('sjakshi@gmail.com'),
          //   currentAccountPicture: CircleAvatar(
          //     child: ClipOval(
          //       child: Image.network(
          //           'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
          //         height: 90,
          //         width: 90,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //     image:DecorationImage(
          //         image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.home,color: Color(0xFF000033)),
            title: Text('Home',style: TextStyle(color: Color(0xFF000033))),
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllUserPost()));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            //textColor: Color(0xFF000033),
          ),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.add_comment,color: Color(0xFF000033)),
            title: Text('Post',style: TextStyle(color: Color(0xFF000033))),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostUploadScreen()));
            },
            //tileColor: Color(0xFF000033),
          ),
          SizedBox(height: 20,),
          // // ListTile(
          // //   leading: Icon(Icons.history,color: Color(0xFF000033)),
          // //   title: Text('History',style: TextStyle(color: Color(0xFF000033))),
          // //   onTap: (){
          // //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
          // //   },
          //   // tileColor: Color(0xFF000033),
          // ),
          ListTile(
            leading: Icon(Icons.phone_outlined,color: Color(0xFF000033)),
            title: Text('Call',style: TextStyle(color: Color(0xFF000033))),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen()));
            },
            //tileColor: Color(0xFF000033),
          ),
          SizedBox(height: 20,),
          // ListTile(
          //   leading: Icon(Icons.notifications,color: Color(0xFF000033)),
          //   title: Text('Notification',style: TextStyle(color: Color(0xFF000033))),
          //   onTap: (){},
          //   //tileColor: Color(0xFF000033),
          // ),
          ListTile(
            leading: Icon(Icons.feedback,color: Color(0xFF000033)),
            title: Text('Feedback',style: TextStyle(color: Color(0xFF000033)),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackSceen()));
            },
           // tileColor: Color(0xFF000033),
          ),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.person,color: Color(0xFF000033)),
            title: Text('Profile',style: TextStyle(color: Color(0xFF000033)),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
            },
          ),
          // Divider(),
          // SizedBox(height: 20,),
          // ListTile(
          //   leading: Icon(Icons.logout,color: Color(0xFF000033)),
          //   title: Text('LogOut',style: TextStyle(color: Color(0xFF000033)),),
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          //   },
          //   //tileColor: Color(0xFF000033),
          // ),
        ],
      ),
    );
  }
}
