// ajustes.dart
import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'main.dart';

class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = MyApp.of(context).isDark;
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Tema oscuro"),
            subtitle: const Text("Alterna entre claro/oscuro (solo memoria)"),
            value: isDark,
            onChanged: (v) {
              MyApp.of(context).toggleTheme(v);
              setState(() {}); // refrescar UI local
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Acerca de"),
            subtitle: const Text("Versión 1.0 • Autor: Alexis Eduardo Suarez Hernandez"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Portafolio - Kit Offline',
                applicationVersion: '1.0',
                applicationLegalese: 'Autor: Alexis Eduardo Suarez Hernandez',
              );
            },
          ),
        ],
      ),
    );
  }
}
