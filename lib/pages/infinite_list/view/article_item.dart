import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleItem extends StatelessWidget {
  final int page;
  final Article article;
  const ArticleItem({super.key,required this.article,required this.page});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('$page', style: textTheme.bodySmall),
        title: Text('${article.title}'),
        isThreeLine: true,
        subtitle: Text('${article.chapterName}'),
        dense: true,
      ),
    );
  }
}
