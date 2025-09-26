// practicas.dart
import 'package:flutter/material.dart';
import 'app_drawer.dart';

class PracticasScreen extends StatelessWidget {
  const PracticasScreen({super.key});

  final List<Map<String, String>> practicas = const [
    {"titulo": "Práctica 1", "ruta": "/p1"},
    {"titulo": "Práctica 2", "ruta": "/p2"},
    {"titulo": "Práctica 4 (Registro)", "ruta": "/p4"},
    {"titulo": "Juego: RPS", "ruta": "/juegoRPS"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Índice de Prácticas")),
      drawer: const AppDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) => ListTile(
          leading: CircleAvatar(child: Text("${i + 1}")),
          title: Text(practicas[i]['titulo']!),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, practicas[i]['ruta']!),
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: practicas.length,
      ),
    );
  }
}
