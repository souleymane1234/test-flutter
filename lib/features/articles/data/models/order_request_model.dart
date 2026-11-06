import 'package:test_app/features/articles/domain/entities/order_draft.dart';

final class OrderRequestModel {
  const OrderRequestModel({
    required this.articleId,
    required this.customerName,
    required this.email,
    required this.address,
    required this.cardLast4,
    required this.amount,
  });

  factory OrderRequestModel.fromDraft(OrderDraft draft) {
    final digits = draft.cardNumber.replaceAll(' ', '');
    return OrderRequestModel(
      articleId: draft.articleId,
      customerName: draft.customerName.trim(),
      email: draft.email.trim(),
      address: draft.address.trim(),
      cardLast4: digits.substring(digits.length - 4),
      amount: draft.amount,
    );
  }

  final String articleId;
  final String customerName;
  final String email;
  final String address;
  final String cardLast4;
  final double amount;

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
      'customerName': customerName,
      'email': email,
      'address': address,
      'cardLast4': cardLast4,
      'amount': amount,
    };
  }
}
