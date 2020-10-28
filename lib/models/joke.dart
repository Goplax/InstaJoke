class ModelJoke {
  bool error;
  String category;
  String setup;
  String delivery;
  String message;

  ModelJoke(
      {this.error, this.category, this.setup, this.delivery, this.message});

  ModelJoke.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    // If no error is there get the Joke
    if (!error) {
      category = json['category'];
      setup = json['setup'];
      delivery = json['delivery'];
    } else {
      // If there is error get error message
      message = json['message'];
    }
  }
}
