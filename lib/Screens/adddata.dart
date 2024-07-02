import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wslc_256/Widgets/uihelper.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(titleController, "Enter Title", Icons.title),
        UiHelper.CustomTextField(descController,"Enter Description", Icons.description),
        SizedBox(height: 20),
        ElevatedButton(onPressed: (){
          adddata(titleController.text.toString(), descController.text.toString());
        }, child: Text("Add"))
      ],),
    );
  }
  adddata(String title,String desc)async{
    if(title=="" || desc==""){
      return log("Enter Required Fields");
    }
    else{
      FirebaseFirestore.instance.collection("Notes").doc(title).set({
        "title":title,
        "description":desc
      });
    }
  }
}
