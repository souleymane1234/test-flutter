import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/result/result.dart';
import 'package:test_app/features/articles/data/datasources/order_api_data_source.dart';
import 'package:test_app/features/articles/data/models/order_request_model.dart';
import 'package:test_app/features/articles/domain/entities/order_confirmation.dart';
import 'package:test_app/features/articles/domain/entities/order_draft.dart';
import 'package:test_app/features/articles/domain/repositories/order_repository.dart';

final class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._api);

  final OrderApiDataSource _api;

  @override
  Future<Result<OrderConfirmation>> submit(OrderDraft draft) async {
    try {
      final request = OrderRequestModel.fromDraft(draft);
      final orderId = await _api.postOrder(request.toJson());
      return Success(
        OrderConfirmation(
          orderId: orderId,
          articleName: draft.articleName,
          amount: draft.amount,
        ),
      );
    } on OrderApiException catch (error) {
      return ResultFailure(Failure(error.message));
    } catch (error) {
      return ResultFailure(Failure(error.toString()));
    }
  }
}
