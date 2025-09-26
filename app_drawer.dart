// app_drawer.dart
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  "Menú de Navegación",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text("Índice de Prácticas"),
              onTap: () => Navigator.pushReplacementNamed(context, '/practicas'),
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text("Proyecto (Kit Offline)"),
              onTap: () => Navigator.pushReplacementNamed(context, '/proyecto'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Ajustes / Acerca de"),
              onTap: () => Navigator.pushReplacementNamed(context, '/ajustes'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("v1.0 • Tu nombre", style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
