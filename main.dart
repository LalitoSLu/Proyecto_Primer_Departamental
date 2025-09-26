// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/galeria.dart';
import 'package:flutter_application_1/imc.dart';
import 'package:flutter_application_1/notas.dart';
import 'package:flutter_application_1/par_impar.dart';
import 'home.dart';
import 'app_drawer.dart';
import 'practicas.dart';
import 'proyecto.dart';
import 'ajustes.dart';

// Importa tus prácticas existentes (ajustadas más abajo)
import 'Primera.dart';
import 'Segunda.dart';
import 'Pract4.dart';
import 'JuegoRPS.dart';

// Punto de entrada
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool dark) {
    setState(() {
      _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  bool get isDark => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portafolio - Kit Offline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/practicas': (_) => const PracticasScreen(),
        '/proyecto': (_) => const ProyectoScreen(),
        '/ajustes': (_) => const AjustesScreen(),
        // Prácticas (tus pantallas)
        '/p1': (_) => const Primera(),
        '/p2': (_) => const Segunda(),
        '/p4': (_) => const Prac4(),
        '/juegoRPS': (_) => const JuegoRPS(),
        // Módulos Kit Offline (rutas internas)
        '/kit/notas': (_) => const NotasScreen(),
        '/kit/imc': (_) => const ImcScreen(),
        '/kit/galeria': (_) => const GaleriaLocal(),
        '/kit/parimpar': (_) => const ParImparScreen(),
      },
    );
  }
}
