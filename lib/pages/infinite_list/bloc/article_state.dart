import 'package:equatable/equatable.dart';

import '../models/article.dart';

enum ArticleLoadState {initial,success,failure,loading}
final class ArticleState extends Equatable{
  final List<Article> articleList;
  ArticleLists? pageArticles;
  bool? hasReachedMax;
  final ArticleLoadState articleLoadState;
  ArticleState({this.articleList = const <Article>[],this.pageArticles,this.hasReachedMax = false,this.articleLoadState = ArticleLoadState.initial});
  ArticleState copyWith({List<Article>? articleList,
    ArticleLists? pageArticles,
    bool? hasReachedMax,ArticleLoadState? articleLoadState}){
    return ArticleState(
      articleList: articleList??this.articleList,pageArticles: pageArticles,hasReachedMax: hasReachedMax,articleLoadState: articleLoadState??this.articleLoadState
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [pageArticles,articleList,hasReachedMax,articleLoadState];
  @override
  String toString() {
    return '''ArticleState { status: $articleLoadState, hasReachedMax: $hasReachedMax, articles: ${articleList.length} }''';
  }
}