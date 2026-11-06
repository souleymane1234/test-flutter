import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

final class PaymentForm extends Equatable {
  const PaymentForm({
    this.name = '',
    this.email = '',
    this.address = '',
    this.cardNumber = '',
    this.expiry = '',
    this.cvv = '',
  });

  final String name;
  final String email;
  final String address;
  final String cardNumber;
  final String expiry;
  final String cvv;

  bool get isValid {
    final digits = cardNumber.replaceAll(' ', '');
    return name.trim().length >= 2 &&
        email.contains('@') &&
        email.contains('.') &&
        address.trim().length >= 5 &&
        digits.length == 16 &&
        RegExp(r'^(0[1-9]|1[0-2])/\d{2}$').hasMatch(expiry) &&
        RegExp(r'^\d{3}$').hasMatch(cvv);
  }

  PaymentForm copyWith({
    String? name,
    String? email,
    String? address,
    String? cardNumber,
    String? expiry,
    String? cvv,
  }) {
    return PaymentForm(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvv: cvv ?? this.cvv,
    );
  }

  @override
  List<Object?> get props => [name, email, address, cardNumber, expiry, cvv];
}

final class PaymentFormNotifier extends ValueNotifier<PaymentForm> {
  PaymentFormNotifier() : super(const PaymentForm());

  void changeName(String value) => this.value = this.value.copyWith(name: value);

  void changeEmail(String value) =>
      this.value = this.value.copyWith(email: value);

  void changeAddress(String value) =>
      this.value = this.value.copyWith(address: value);

  void changeCardNumber(String value) =>
      this.value = this.value.copyWith(cardNumber: value);

  void changeExpiry(String value) =>
      this.value = this.value.copyWith(expiry: value);

  void changeCvv(String value) => this.value = this.value.copyWith(cvv: value);
}
