import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_learn01/pages/infinite_list/bloc/article_event.dart';
import 'package:bloc_learn01/pages/infinite_list/bloc/article_state.dart';
import 'package:bloc_learn01/pages/infinite_list/models/article.dart';
import 'package:dio/dio.dart';

class ArticleBloc extends Bloc<ArticleEvent,ArticleState>{
  ArticleBloc(this.dio):super(ArticleState()){
    on<ArticleFetched>(_onArticleFetched);
  }
  final Dio dio;
  Future<void> _onArticleFetched(ArticleFetched event,Emitter<ArticleState> emit) async{
    if(state.hasReachedMax??false)return;
    try{
      print("执行xxx${state.articleLoadState}");
      if (state.articleLoadState == ArticleLoadState.initial) {
        final pageArticles = await _fetchArticles();
        print("${pageArticles.articleList?.length}");
        return emit(state.copyWith(
          articleLoadState: ArticleLoadState.success,
          pageArticles: pageArticles,
          articleList: pageArticles.articleList??[],
          hasReachedMax: false,
        ));
      }else{
        final pageArticles = await _fetchArticles(state.pageArticles?.curPage??0);
        pageArticles.articleList!.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
          state.copyWith(
            articleLoadState: ArticleLoadState.success,
            articleList: List.of(state.articleList)..addAll(pageArticles.articleList??[]),
            hasReachedMax: false,
          ),
        );
      }
    }catch(err){
      emit(state.copyWith(articleLoadState: ArticleLoadState.failure));
    }
  }
  Future<ArticleLists> _fetchArticles([int page = 0]) async{
    final response = await dio.get('https://www.wanandroid.com/article/list/$page/json');
    if (response.statusCode == 200) {
      try{
        print("response:${ response.data['data']}");
      }catch(err){
        print("err:$err");
      }
      return ArticleLists.fromJson(response.data['data']);
    }
    throw Exception('error fetching posts');
  }
}