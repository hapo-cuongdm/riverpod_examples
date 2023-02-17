class Post {
  String? title;
  String? body;
  int? user;
  String? id;

  Post({this.title, this.body, this.user, this.id});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    user = json['user'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['user'] = user;
    data['id'] = id;
    return data;
  }
}
