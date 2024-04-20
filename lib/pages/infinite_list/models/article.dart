import 'package:equatable/equatable.dart';

class ArticleLists {
  List<Article>? articleList;
  int? curPage;
  int? offset;
  int? size;
  int? total;
  ArticleLists({this.articleList,this.offset,this.size,this.total,this.curPage});
  factory ArticleLists.fromJson(Map<String, dynamic> json){
    print("${json['datas']}");
    return ArticleLists(
      articleList: json['datas']==null?[]:(json['datas'] as List<dynamic>).map((article) =>Article.fromJson(article)).toList(),
      curPage: json['curPage'],
      offset: json['offset'],
      size: json['size'],
      total: json['total'],
    );
  }
  Map<String,dynamic> toJson() =>{
    "articleList":articleList,
    "curPage":curPage,
    "size":size,
    "offset":offset,
    "total":total
  };
}

class Article extends Equatable {
  final List<Tag>? tags;
  final bool? adminAdd;
  final String? apkLink;
  final int? audit;
  final String? author;
  final bool? canEdit;
  final int? chapterId;
  final String? chapterName;
  final bool? collect;
  final int? courseId;
  final String? desc;
  final String? descMd;
  final String? envelopePic;
  final bool? fresh;
  final String? host;
  final int? id;
  bool? isAdminAdd;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  Article(
      {this.tags,
      this.adminAdd,
      this.apkLink,
      this.audit,
      this.author,
      this.canEdit,
      this.chapterId,
      this.id,
      this.host,
      this.desc,
      this.chapterName,
      this.collect,
      this.courseId,
      this.descMd,
      this.envelopePic,
      this.fresh,
      this.type,
      this.title,
      this.isAdminAdd,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.origin,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.realSuperChapterId,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.userId,
      this.visible,
      this.zan});

  @override
  // TODO: implement props
  List<Object?> get props => [title,tags,link,shareUser,shareDate,publishTime,userId];
  factory Article.fromJson(Map<String, dynamic> json) => Article(
    adminAdd: json["adminAdd"],
    apkLink: json["apkLink"],
    audit: json["audit"],
    author: json["author"],
    canEdit: json["canEdit"],
    chapterId: json["chapterId"],
    chapterName: json["chapterName"],
    collect: json["collect"],
    courseId: json["courseId"],
    desc: json["desc"],
    descMd: json["descMd"],
    envelopePic: json["envelopePic"],
    fresh: json["fresh"],
    host: json["host"],
    id: json["id"],
    isAdminAdd: json["isAdminAdd"],
    link: json["link"],
    niceDate: json["niceDate"],
    niceShareDate: json["niceShareDate"],
    origin: json["origin"],
    prefix: json["prefix"],
    projectLink: json["projectLink"],
    publishTime: json["publishTime"],
    realSuperChapterId: json["realSuperChapterId"],
    selfVisible: json["selfVisible"],
    shareDate: json["shareDate"],
    shareUser: json["shareUser"],
    superChapterId: json["superChapterId"],
    superChapterName: json["superChapterName"],
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((tag) => Tag.fromJson(tag))),
    title: json["title"],
    type: json["type"],
    userId: json["userId"],
    visible: json["visible"],
    zan: json["zan"],
  );
}

class Tag extends Equatable {
  final String? name;
  final String? url;

  const Tag({this.name, this.url});
  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    name: json["name"]!,
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
  @override
  // TODO: implement props
  List<Object?> get props => [name, url];
}
