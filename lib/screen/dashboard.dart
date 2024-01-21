import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nizipet1/screen/loginscreen.dart';
import 'package:nizipet1/userPreferences/current_user.dart';
import 'navbarscreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState)
      {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (context) {
        return Scaffold(
          backgroundColor: Color(0xFF7C9D8E),
          drawer: NavBarScreen(),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // title: const Text(
            //   "Home Page",
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xFF000033),
            //   ),
            // ),
            iconTheme: IconThemeData(color: Color(0xFF000033)),
          ),
          body: Container(
            //color: Color(0xFF7C9D8E),
            child: Center(
              child: Text('Dashboard'),
            ),
          ),
        );
      }
    );
  }
}

// extendBodyBehindAppBar: true,
// appBar: AppBar(
// backgroundColor: Colors.transparent,
// elevation: 0,
// title: const Text(''
// 'Home Page',
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: Color(0xFF000033),
// ),
// ),
// iconTheme: IconThemeData(color: Color(0xFF000033)),
// ),
// body: Container(
// width: MediaQuery.of(context).size.width,
// height: MediaQuery.of(context).size.height,
// decoration: BoxDecoration(
// color: Color(0xff62738c),
// ),
// child: Center(
// child: ElevatedButton(
// onPressed: (){
// Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
// },
// child: Text('LogOut')),
// ),
// ),
