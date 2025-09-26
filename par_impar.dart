// par_impar.dart
import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'dart:math';

class ParImparScreen extends StatefulWidget {
  const ParImparScreen({super.key});

  @override
  State<ParImparScreen> createState() => _ParImparScreenState();
}

class _ParImparScreenState extends State<ParImparScreen> {
  bool? _esPar; // true = par, false = impar, null = no seleccionado
  int _userScore = 0;
  int _cpuScore = 0;
  final Random _rng = Random();


  void _lanzar(int numeroUsuario) {
    final numCpu = _rng.nextInt(6);
    final suma = numCpu + numeroUsuario;
    final esSumaPar = suma % 2 == 0;
    final usuarioGana = (esSumaPar && (_esPar == true)) || (!esSumaPar && (_esPar == false));

    setState(() {
      if (usuarioGana) _userScore++; else _cpuScore++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tu $numeroUsuario + CPU $numCpu = $suma → ${esSumaPar ? 'Par' : 'Impar'} • ${usuarioGana ? 'Ganaste' : 'Perdiste'}')),
    );
  }

  void _reiniciar() {
    setState(() {
      _userScore = 0;
      _cpuScore = 0;
      _esPar = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marcador reiniciado')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Par o Impar')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Elige Par o Impar:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ToggleButtons(
              isSelected: [_esPar == true, _esPar == false],
              onPressed: (i) => setState(() => _esPar = i == 0),
              children: const [Padding(padding: EdgeInsets.all(8), child: Text('Par')), Padding(padding: EdgeInsets.all(8), child: Text('Impar'))],
            ),
            const SizedBox(height: 16),
            Text('Elige un número (0–5):', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(6, (i) {
                return ElevatedButton(
                  onPressed: _esPar == null ? null : () => _lanzar(i),
                  child: Text('$i'),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text('Marcador — Tú: $_userScore  CPU: $_cpuScore', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _reiniciar, child: const Text('Reiniciar marcador')),
          ],
        ),
      ),
    );
  }
}
