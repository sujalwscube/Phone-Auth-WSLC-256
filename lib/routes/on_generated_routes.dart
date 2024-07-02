import 'package:flutter/material.dart';
import 'package:wslc_256/Screens/adddata.dart';
import 'package:wslc_256/Screens/notesapp.dart';
import 'package:wslc_256/routes/appconsts.dart';
class ongeneratedRoutes{
  static Route<dynamic>route(RouteSettings routeSettings){
    final args=routeSettings.arguments;
    switch(routeSettings.name){
      case PageConst.notesapp:
        {
          return materialBuilder(widget: const NotesApp());
        }
      case PageConst.adddata:{
        return materialBuilder(widget: const AddData());
      }
      default:{
        return materialBuilder(widget: const ErrorPage());
      }
    }
  }
}
MaterialPageRoute materialBuilder({required Widget widget}){
  return MaterialPageRoute(builder: (_)=>widget);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Oops an Error Occured!!"),
      ),
    );
  }
}