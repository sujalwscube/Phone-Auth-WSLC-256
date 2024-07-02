import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wslc_256/Screens/adddata.dart';
import 'package:wslc_256/routes/appconsts.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              return ListView.builder(itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${index+1}"),
                  ),
                  title: Text(snapshot.data!.docs[index]["title"]),
                  subtitle: Text(snapshot.data!.docs[index]["description"]),
                );
              },itemCount: snapshot.data!.docs.length,);
            }
            else if(snapshot.hasError){
              return Center(child: Text(snapshot.hasError.toString()),);
            }
            else{
              return Center(child: Text("No Data Found!!"),);
            }
          }
          else{
            return Center(child: Text("Connection is Not Proper"),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, PageConst.adddata, (route) => false);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
