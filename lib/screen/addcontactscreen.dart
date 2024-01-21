
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  late DatabaseReference _ref ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7C9D8E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Save Contact',
          style: TextStyle(
            color: Color(0xFF000033),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF000033),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController!,
              decoration: InputDecoration(
                hintText: 'Enter name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                //fillColor: Color(0xFF000033),
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                hintText: 'Enter number',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  size: 30,
                  //color: Color(0xFFffb247),
                ),
                //fillColor: Color(0xFF000033),
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              // height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              // ignore: deprecated_member_use
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                // color: Color(0xFFffb247),
                onPressed: () {
                  saveContact();
                },
                child: Text(
                  'Save Contact',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF000033),
                    //color: Color(0xFFffb247),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void saveContact(){
    String name = _nameController.text;
    String number = _numberController.text;

    Map<String,String> contact ={
      'name' : name,
      'number' : '+91 '+ number,
    };

    _ref.push().set(contact).then((value) {
      Navigator.pop(context);
    });
  }
}