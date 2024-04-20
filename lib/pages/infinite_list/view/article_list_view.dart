import 'package:bloc_learn01/pages/infinite_list/bloc/article_bloc.dart';
import 'package:bloc_learn01/pages/infinite_list/bloc/article_event.dart';
import 'package:bloc_learn01/pages/infinite_list/bloc/article_state.dart';
import 'package:bloc_learn01/pages/infinite_list/view/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({super.key});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc,ArticleState>(builder: (BuildContext context, state) {
      return ListView.builder(itemBuilder: (context,index){
        return ArticleItem(article: state.articleList[index]);
      },itemCount: state.articleList.length,);
    },);
  }
}
