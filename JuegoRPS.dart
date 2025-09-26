import 'package:flutter/material.dart';
import 'Primera.dart';
import 'Segunda.dart';
import 'Pract4.dart';

// 🎮 Juego Piedra, Papel o Tijera
class JuegoRPS extends StatefulWidget {
  const JuegoRPS({super.key});

  @override
  State<JuegoRPS> createState() => _JuegoRPSState();
}

class _JuegoRPSState extends State<JuegoRPS> {
  final List<String> opciones = ["✊", "✋", "✌️"];
  String? eleccionJugador;
  String? eleccionCPU;
  String resultado = "";

  void jugar(String jugador) {
    setState(() {
      eleccionJugador = jugador;
      eleccionCPU = opciones[(opciones.length * (DateTime.now().millisecond % 3) / 3).floor()];
      resultado = _determinarGanador(eleccionJugador!, eleccionCPU!);
    });
  }

  String _determinarGanador(String jugador, String cpu) {
    if (jugador == cpu) return "¡Empate 😐!";
    if ((jugador == "✊" && cpu == "✌️") ||
        (jugador == "✋" && cpu == "✊") ||
        (jugador == "✌️" && cpu == "✋")) {
      return "¡Ganaste 🎉!";
    }
    return "Perdiste 😢";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juego RPS"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const AppDrawer(), // ✅ Menú en todas las prácticas
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Elige tu jugada:",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Botones de juego
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: opciones.map((op) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                      elevation: 6,
                    ),
                    onPressed: () => jugar(op),
                    child: Text(
                      op,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            // Resultados
            if (eleccionJugador != null && eleccionCPU != null) ...[
              Text(
                "Tú: $eleccionJugador   vs   CPU: $eleccionCPU",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                resultado,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// 📌 Drawer reutilizable en todas las pantallas
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                "Menú de Prácticas",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.looks_one),
            title: const Text("Práctica 1"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Primera()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.looks_two),
            title: const Text("Práctica 2"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Segunda()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.looks_4),
            title: const Text("Práctica 4 (Registro)"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Prac4()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.videogame_asset),
            title: const Text("Juego: Piedra, Papel o Tijera"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JuegoRPS()),
            ),
          ),
        ],
      ),
    );
  }
}
