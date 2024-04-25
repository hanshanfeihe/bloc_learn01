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
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      print("加载下一页");
      context.read<ArticleBloc>().add(ArticleFetched());
    }
  }

  bool get _isBottom {
    if ((!_scrollController.hasClients) ||
        (context.read<ArticleBloc>().state.articleLoadState ==
            ArticleLoadState.loading)) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (BuildContext context, state) {
        switch (state.articleLoadState) {
          case ArticleLoadState.loading:
          case ArticleLoadState.success:
            return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.articleList.length
                    ? const BottomLoader()
                    : ArticleItem(article: state.articleList[index],page: state.pageArticles?.curPage??0,);
              },
              controller: _scrollController,
              itemCount: state.hasReachedMax == true
                  ? state.articleList.length
                  : state.articleList.length + 1,
            );
          case ArticleLoadState.failure:
            return const Center(child: Text('failed to fetch articles'));
          case ArticleLoadState.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
