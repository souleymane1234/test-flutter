import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/result/result.dart';
import 'package:test_app/features/articles/domain/usecases/submit_order.dart';
import 'package:test_app/features/articles/presentation/bloc/order_event.dart';
import 'package:test_app/features/articles/presentation/bloc/order_state.dart';

final class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.submitOrder}) : super(const OrderIdle()) {
    on<OrderSubmitted>(_onSubmitted);
  }

  final SubmitOrder submitOrder;

  Future<void> _onSubmitted(
    OrderSubmitted event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderSubmitInProgress());
    final result = await submitOrder(event.draft);
    switch (result) {
      case Success(:final value):
        emit(OrderSubmitSuccess(value));
      case ResultFailure(:final failure):
        emit(OrderSubmitFailure(failure.message));
    }
  }
}
