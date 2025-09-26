// proyecto.dart
import 'package:flutter/material.dart';
import 'app_drawer.dart';

class ProyectoScreen extends StatelessWidget {
  const ProyectoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Proyecto - Kit Offline")),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.note_alt),
            title: const Text("Notas rápidas"),
            subtitle: const Text("Agregar notas en memoria"),
            onTap: () => Navigator.pushNamed(context, '/kit/notas'),
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight),
            title: const Text("Calculadora IMC"),
            subtitle: const Text("Form con validaciones"),
            onTap: () => Navigator.pushNamed(context, '/kit/imc'),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Galería local"),
            subtitle: const Text("Ver imágenes de assets"),
            onTap: () => Navigator.pushNamed(context, '/kit/galeria'),
          ),
          ListTile(
            leading: const Icon(Icons.gamepad),
            title: const Text("Juego: Par o Impar"),
            subtitle: const Text("Marcador en memoria"),
            onTap: () => Navigator.pushNamed(context, '/kit/parimpar'),
          ),
        ],
      ),
    );
  }
}
