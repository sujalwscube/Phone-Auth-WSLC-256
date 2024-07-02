import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wslc_256/Widgets/uihelper.dart';

class Storage extends StatefulWidget {
  const Storage({super.key});

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  TextEditingController imagenameController=TextEditingController();
  File? newimage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Storage"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          GestureDetector(
            onTap: (){
              _pickImage(context);
            },
            child: newimage==null? CircleAvatar(
              radius: 60,
              child: Icon(Icons.person,size: 70,),
            ):CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(newimage!),
            ),
          ),
          const SizedBox(height: 10),
          UiHelper.CustomTextField(imagenameController, "Enter Image Name", Icons.image),
          const SizedBox(height: 30),
          ElevatedButton(onPressed: (){
            Upload();
          }, child: const Text("Upload"))
        ],),
      ),
    );
  }
  _pickImage(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return  AlertDialog(
        title: Text("Pick Image From"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          ListTile(
            onTap: (){
              pickImages(ImageSource.camera);
            },
            leading: Icon(Icons.camera_alt),
            title: Text("Camera"),
          ), ListTile(
              onTap: (){
                pickImages(ImageSource.gallery);
              },
            leading: Icon(Icons.image),
            title: Text("Gallery"),
          )

        ],),
      );
    });
  }
  
  Upload()async{
    UploadTask uploadTask= FirebaseStorage.instance.ref("Profile Pictures").child(imagenameController.text.toString()).putFile(newimage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String imageurl=await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance.collection("Images").doc(imagenameController.text.toString()).set({
      "image":imageurl,
      "imagename":imagenameController.text.toString()
    }).then((value){
      log("Image Uploaded");
    });
  }

  pickImages(ImageSource imageSource)async{
    try{
      final photo=await ImagePicker().pickImage(source: imageSource);
      if(photo==null)return;
      final tempImage=File(photo.path);
      setState(() {
        newimage=tempImage;
      });
    }
    catch(ex){
      log(ex.toString());
    }
  }
}
