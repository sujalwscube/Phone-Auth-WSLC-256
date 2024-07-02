import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wslc_256/Cubits/newscubit.dart';
import 'package:wslc_256/Cubits/newsstates.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  int? totalpage;
  final RefreshController refreshController=RefreshController(initialRefresh: false);
  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    var pages = (totalpage! - 1);
    if (pages == context.read<NewsCubit>().pageno) {
      log('done');
    } else {
      context.read<NewsCubit>().pageno++;
      context.read<NewsCubit>().getdata();
    }

    if (mounted) setState(() {});
    refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsCubit, NewsStates>(
        //Only when Data is Fetching
        builder: (context, state) {
          if (state is NewsLoadingStates) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoadedStates) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${index + 1}"),
                  title:
                      Text(state.newsmodel.articles![index].title.toString()),
                  subtitle: Text(
                      state.newsmodel.articles![index].description.toString()),
                );
              },
              itemCount: state.newsmodel.articles!.length,
            );
          } else if (state is NewsErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return const Center(
              child: Text("Data Not Found!!"),
            );
          }
        },
      ),
    );
  }
}
