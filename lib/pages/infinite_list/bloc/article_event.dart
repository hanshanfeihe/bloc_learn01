import 'package:equatable/equatable.dart';

sealed class ArticleEvent extends Equatable{
  @override
  List<Object> get props => [];
}
final class ArticleFetched extends ArticleEvent{

}