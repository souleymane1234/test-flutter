import 'package:test_app/core/result/result.dart';
import 'package:test_app/features/articles/domain/entities/order_confirmation.dart';
import 'package:test_app/features/articles/domain/entities/order_draft.dart';

abstract interface class OrderRepository {
  Future<Result<OrderConfirmation>> submit(OrderDraft draft);
}
