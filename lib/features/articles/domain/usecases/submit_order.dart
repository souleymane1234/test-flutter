import 'package:test_app/core/result/result.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/articles/domain/entities/order_confirmation.dart';
import 'package:test_app/features/articles/domain/entities/order_draft.dart';
import 'package:test_app/features/articles/domain/repositories/order_repository.dart';

final class SubmitOrder implements UseCase<OrderConfirmation, OrderDraft> {
  const SubmitOrder(this._repository);

  final OrderRepository _repository;

  @override
  Future<Result<OrderConfirmation>> call(OrderDraft draft) {
    return _repository.submit(draft);
  }
}
