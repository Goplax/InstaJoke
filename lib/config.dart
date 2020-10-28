class Config {
  // Setting the API url and parameters as provided by website
  static String url = 'https://sv443.net/jokeapi/v2/joke/';
  static String categories = 'Any';
  static String language = 'en';
  static String flags = 'nsfw,racist,sexist';
  static String jokeType = 'twopart';
  static String amount = '1';

  // Formatting the final URL, So we can use it directly on our app
  static String apiUrl =
      'https://sv443.net/jokeapi/v2/joke/$categories?blacklistFlags=$flags&type=$jokeType';
}
