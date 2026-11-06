import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/app.dart';
import 'package:test_app/core/di/injection.dart';

void main() {
  setUp(() async {
    await sl.reset();
    configureDependencies();
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('affiche les articles et ajoute un favori', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump();

    expect(find.text('Hoodie oversize'), findsOneWidget);
    expect(find.text('1 000 FCFA'), findsOneWidget);
    expect(find.text('6 900 FCFA'), findsOneWidget);
    expect(find.text('Veste en cuir'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);

    await tester.tap(find.byTooltip('Ajouter aux favoris').first);
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('envoie la commande', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Hoodie oversize'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('payment-name')), 'Awa Diallo');
    await tester.enterText(
      find.byKey(const Key('payment-email')),
      'awa@email.com',
    );
    await tester.enterText(
      find.byKey(const Key('payment-address')),
      '10 rue de Paris',
    );
    await tester.enterText(
      find.byKey(const Key('payment-card')),
      '4242424242424242',
    );
    await tester.enterText(find.byKey(const Key('payment-expiry')), '1228');
    expect(find.text('12/28'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('payment-cvv')), '123');
    await tester.pump();

    await tester.ensureVisible(find.byKey(const Key('payment-submit')));
    await tester.tap(find.byKey(const Key('payment-submit')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.text('Commande confirmée'), findsOneWidget);
    expect(find.text('CMD-1001'), findsOneWidget);
  });
}
