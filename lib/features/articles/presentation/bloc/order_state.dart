import 'package:equatable/equatable.dart';
import 'package:test_app/features/articles/domain/entities/order_confirmation.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => const [];
}

final class OrderIdle extends OrderState {
  const OrderIdle();
}

final class OrderSubmitInProgress extends OrderState {
  const OrderSubmitInProgress();
}

final class OrderSubmitSuccess extends OrderState {
  const OrderSubmitSuccess(this.confirmation);

  final OrderConfirmation confirmation;

  @override
  List<Object?> get props => [confirmation];
}

final class OrderSubmitFailure extends OrderState {
  const OrderSubmitFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
