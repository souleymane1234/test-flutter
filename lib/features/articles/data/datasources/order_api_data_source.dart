abstract interface class OrderApiDataSource {
  Future<String> postOrder(Map<String, dynamic> body);
}

final class OrderApiException implements Exception {
  const OrderApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class OrderApi implements OrderApiDataSource {
  int _nextId = 1000;

  @override
  Future<String> postOrder(Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final articleId = body['articleId'];
    if (articleId is! String || articleId.isEmpty) {
      throw const OrderApiException('Article manquant');
    }
    _nextId += 1;
    return 'CMD-$_nextId';
  }
}
