// imc.dart
import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'dart:math';

class ImcScreen extends StatefulWidget {
  const ImcScreen({super.key});

  @override
  State<ImcScreen> createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pesoCtrl = TextEditingController();
  final _estaturaCtrl = TextEditingController();

  void _calcular() {
    if (!_formKey.currentState!.validate()) return;
    final peso = double.parse(_pesoCtrl.text);
    final est = double.parse(_estaturaCtrl.text);
    final imc = peso / pow(est, 2);
    String categoria;
    if (imc < 18.5) categoria = 'Bajo peso';
    else if (imc < 25) categoria = 'Normal';
    else if (imc < 30) categoria = 'Sobrepeso';
    else categoria = 'Obesidad';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('IMC: ${imc.toStringAsFixed(2)} • $categoria')),
    );
  }

  void _limpiar() {
    _formKey.currentState?.reset();
    _pesoCtrl.clear();
    _estaturaCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Formulario limpio')));
  }

  @override
  void dispose() {
    _pesoCtrl.dispose();
    _estaturaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora IMC')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pesoCtrl,
                decoration: const InputDecoration(labelText: 'Peso (kg)', prefixIcon: Icon(Icons.fitness_center)),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa el peso';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null) return 'Número inválido';
                  if (n <= 0) return 'Debe ser mayor que 0';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _estaturaCtrl,
                decoration: const InputDecoration(labelText: 'Estatura (m)', prefixIcon: Icon(Icons.height)),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa la estatura';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null) return 'Número inválido';
                  if (n <= 0) return 'Debe ser mayor que 0';
                  if (n > 3) return 'Valor poco probable (m)';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: _calcular, child: const Text('Calcular'))),
                  const SizedBox(width: 12),
                  OutlinedButton(onPressed: _limpiar, child: const Text('Limpiar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
