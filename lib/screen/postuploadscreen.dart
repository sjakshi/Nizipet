import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:nizipet1/screen/alluserpost.dart';
import 'package:nizipet1/screen/homescreen.dart';


import '../api_connection/apicnnection.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({Key? key}) : super(key: key);

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {

   File? image;
  // String? name;
  // String? imageData;

  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedImage!.path);
    });
  }

  Future uploadImage() async{
    final uri = Uri.parse(API.upload);
    var request = http.MultipartRequest('POST',uri);
    request.fields["name"] = nameController.text;
    var pic = await http.MultipartFile.fromPath("image", image!.path);
    request.files.add(pic);
    var response = await request.send();

    if(response.statusCode == 200){
      // print('Image Upload');
      Fluttertoast.showToast(msg: 'Image Uploaded');
    }
    else{
      // print('Image not Upload');
      Fluttertoast.showToast(msg: 'Image not Uploaded');
    }

    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7c9d8e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Upload your photo',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ),
            IconButton(
                onPressed: (){
                  choiceImage();
                  },
                icon: Icon(Icons.camera,color: Color(0xFF000033),)),
            Container(
              child: image == null ? Text('No image Selected') : Image.file(image!),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color(0xFF000033)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                onPressed: (){
                  uploadImage();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                },
                child: Text('Upload'))
          ],
        ),
      )
    );
  }
}
