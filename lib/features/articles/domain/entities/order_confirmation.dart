import 'package:equatable/equatable.dart';

final class OrderConfirmation extends Equatable {
  const OrderConfirmation({
    required this.orderId,
    required this.articleName,
    required this.amount,
  });

  final String orderId;
  final String articleName;
  final double amount;

  @override
  List<Object?> get props => [orderId, articleName, amount];
}
