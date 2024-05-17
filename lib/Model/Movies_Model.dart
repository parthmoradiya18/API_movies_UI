class Model {
  int? id;
  String? movie;
  dynamic? rating;
  String? image;
  String? imdbUrl;

  Model({this.id, this.movie, this.rating, this.image, this.imdbUrl});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movie = json['movie'];
    rating = json['rating'];
    image = json['image'];
    imdbUrl = json['imdb_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['movie'] = this.movie;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['imdb_url'] = this.imdbUrl;
    return data;
  }
}