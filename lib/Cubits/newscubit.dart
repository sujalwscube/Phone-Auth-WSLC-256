import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wslc_256/Cubits/newsstates.dart';
import 'package:http/http.dart' as http;
import 'package:wslc_256/Models/newsmodel.dart';
class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialStates());
  int pageno = 0;
  getdata()async{
    emit(NewsLoadingStates());
    final response=await http.get(Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2024-05-08&sortBy=publishedAt&apiKey=cf1a67204baa41b293e7ad23b41a50dd"));
    if(response.statusCode==200){
      Map<String,dynamic>responsedata=jsonDecode(response.body);
      NewsModel newsModel=NewsModel.fromJson(responsedata);
      emit(NewsLoadedStates(newsmodel: newsModel));
    }
    else{
      emit(NewsErrorState(error: response.statusCode.toString()));
    }
  }
}