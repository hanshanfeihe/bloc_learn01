import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  const ArticleItem({super.key,required this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${article.author??article.shareUser}', style: textTheme.bodySmall),
        title: Text('${article.title}'),
        isThreeLine: true,
        subtitle: Text('${article.chapterName}'),
        dense: true,
      ),
    );
  }
}
