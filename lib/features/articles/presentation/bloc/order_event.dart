import 'package:equatable/equatable.dart';
import 'package:test_app/features/articles/domain/entities/order_draft.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => const [];
}

final class OrderSubmitted extends OrderEvent {
  const OrderSubmitted(this.draft);

  final OrderDraft draft;

  @override
  List<Object?> get props => [draft];
}
