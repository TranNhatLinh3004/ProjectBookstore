
class Post {
  String? name;
  String? avatar;
  String? author;
  String? category;
  String? review;
  String? target;
  String? other;
  String? id;

  Post(
      {this.name,
        this.avatar,
        this.author,
        this.category,
        this.review,
        this.target,
        this.other,
        this.id});

  Post.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    author = json['author'];
    category = json['category'];
    review = json['review'];
    target = json['target'];
    other = json['other'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['author'] = this.author;
    data['category'] = this.category;
    data['review'] = this.review;
    data['target'] = this.target;
    data['other'] = this.other;
    data['id'] = this.id;
    return data;
  }
}
