import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:population_model_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(PopulationModelApp());

    // Como tu app no tiene un contador por defecto, aquí necesitarías pruebas
    // específicas que verifiquen elementos relevantes en tu pantalla principal.
    // Ejemplo:
    expect(find.text('Modelo de Población'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField), findsOneWidget);
    expect(find.text('Calcular'), findsOneWidget);
  });
}
