import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/articles/domain/entities/article.dart';
import 'package:test_app/features/articles/domain/entities/order_confirmation.dart';
import 'package:test_app/features/articles/domain/entities/order_draft.dart';
import 'package:test_app/features/articles/presentation/bloc/order_bloc.dart';
import 'package:test_app/features/articles/presentation/bloc/order_event.dart';
import 'package:test_app/features/articles/presentation/bloc/order_state.dart';
import 'package:test_app/features/articles/presentation/format_price.dart';
import 'package:test_app/features/articles/presentation/notifiers/payment_form_notifier.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.article});

  final Article article;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentFormNotifier _form = PaymentFormNotifier();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paiement')),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return switch (state) {
            OrderSubmitSuccess(:final confirmation) => _ConfirmationView(
              confirmation: confirmation,
            ),
            _ => _PaymentFormView(
              article: widget.article,
              form: _form,
              submitting: state is OrderSubmitInProgress,
              error: state is OrderSubmitFailure ? state.message : null,
            ),
          };
        },
      ),
    );
  }
}

class _PaymentFormView extends StatelessWidget {
  const _PaymentFormView({
    required this.article,
    required this.form,
    required this.submitting,
    required this.error,
  });

  final Article article;
  final PaymentFormNotifier form;
  final bool submitting;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              article.image,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(article.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(article.description),
          const SizedBox(height: 8),
          Text(
            formatPrice(article.price),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          _Field(
            fieldKey: const Key('payment-name'),
            label: 'Nom',
            hint: 'Awa Diallo',
            onChanged: form.changeName,
            keyboard: TextInputType.name,
          ),
          _Field(
            fieldKey: const Key('payment-email'),
            label: 'E-mail',
            hint: 'awa@email.com',
            onChanged: form.changeEmail,
            keyboard: TextInputType.emailAddress,
          ),
          _Field(
            fieldKey: const Key('payment-address'),
            label: 'Adresse',
            hint: '10 rue de Paris',
            onChanged: form.changeAddress,
            keyboard: TextInputType.streetAddress,
          ),
          _Field(
            fieldKey: const Key('payment-card'),
            label: 'Numéro de carte',
            hint: '4242424242424242',
            onChanged: form.changeCardNumber,
            keyboard: TextInputType.number,
          ),
          _Field(
            fieldKey: const Key('payment-expiry'),
            label: 'Expiration',
            hint: 'MM/AA',
            onChanged: form.changeExpiry,
            keyboard: TextInputType.number,
            inputFormatters: const [_ExpiryInputFormatter()],
          ),
          _Field(
            fieldKey: const Key('payment-cvv'),
            label: 'CVV',
            hint: '123',
            onChanged: form.changeCvv,
            keyboard: TextInputType.number,
            obscure: true,
          ),
          if (error != null) ...[
            const SizedBox(height: 8),
            Text(error!, style: const TextStyle(color: Color(0xFFB91C1C))),
          ],
          const SizedBox(height: 16),
          ValueListenableBuilder<PaymentForm>(
            valueListenable: form,
            builder: (context, value, _) {
              return FilledButton(
                key: const Key('payment-submit'),
                onPressed: value.isValid && !submitting
                    ? () {
                        context.read<OrderBloc>().add(
                          OrderSubmitted(
                            OrderDraft(
                              articleId: article.id,
                              articleName: article.name,
                              amount: article.price,
                              customerName: value.name,
                              email: value.email,
                              address: value.address,
                              cardNumber: value.cardNumber,
                            ),
                          ),
                        );
                      }
                    : null,
                child: submitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Payer'),
              );
            },
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<PaymentForm>(
            valueListenable: form,
            builder: (context, value, _) {
              if (value.isValid) {
                return const SizedBox.shrink();
              }
              return Text(
                'Nom, e-mail, adresse, carte (16 chiffres), expiration (MM/AA) et CVV sont requis.',
                style: Theme.of(context).textTheme.bodySmall,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.fieldKey,
    required this.label,
    required this.hint,
    required this.onChanged,
    required this.keyboard,
    this.obscure = false,
    this.inputFormatters = const [],
  });

  final Key fieldKey;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType keyboard;
  final bool obscure;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        key: fieldKey,
        decoration: InputDecoration(labelText: label, hintText: hint),
        keyboardType: keyboard,
        obscureText: obscure,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}

class _ExpiryInputFormatter extends TextInputFormatter {
  const _ExpiryInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final clipped = digits.length > 4 ? digits.substring(0, 4) : digits;
    final isDeleting = newValue.text.length < oldValue.text.length;

    final String formatted;
    if (clipped.length >= 3) {
      formatted = '${clipped.substring(0, 2)}/${clipped.substring(2)}';
    } else if (clipped.length == 2 && !isDeleting) {
      formatted = '$clipped/';
    } else {
      formatted = clipped;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ConfirmationView extends StatelessWidget {
  const _ConfirmationView({required this.confirmation});

  final OrderConfirmation confirmation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF15803D), size: 72),
          const SizedBox(height: 16),
          Text(
            'Commande confirmée',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(confirmation.orderId),
          const SizedBox(height: 4),
          Text(
            '${confirmation.articleName} · ${formatPrice(confirmation.amount)}',
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Retour aux articles'),
          ),
        ],
      ),
    );
  }
}
