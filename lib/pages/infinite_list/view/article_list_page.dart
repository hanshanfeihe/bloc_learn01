import 'package:bloc_learn01/pages/infinite_list/bloc/article_bloc.dart';
import 'package:bloc_learn01/pages/infinite_list/bloc/article_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'article_list_view.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_)=>ArticleBloc(Dio())..add(ArticleFetched()),
        child: const ArticleListView(),
      ),
    );
  }
}
