import 'package:equatable/equatable.dart';

final class OrderDraft extends Equatable {
  const OrderDraft({
    required this.articleId,
    required this.articleName,
    required this.amount,
    required this.customerName,
    required this.email,
    required this.address,
    required this.cardNumber,
  });

  final String articleId;
  final String articleName;
  final double amount;
  final String customerName;
  final String email;
  final String address;
  final String cardNumber;

  @override
  List<Object?> get props => [
    articleId,
    articleName,
    amount,
    customerName,
    email,
    address,
    cardNumber,
  ];
}
