import 'package:wslc_256/Models/newsmodel.dart';

abstract class NewsStates{}
class NewsInitialStates extends NewsStates{}
class NewsLoadingStates extends NewsStates{}
class NewsLoadedStates extends NewsStates{
  NewsModel newsmodel;
  NewsLoadedStates({required this.newsmodel});
}
class NewsErrorState extends NewsStates{
  String error;
  NewsErrorState({required this.error});
}