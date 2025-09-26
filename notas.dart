// notas.dart
import 'package:flutter/material.dart';
import 'app_drawer.dart';

class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  State<NotasScreen> createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final List<String> _notas = [];

  void _agregarNota(String texto) {
    setState(() => _notas.insert(0, texto));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nota agregada')));
  }

  void _borrarTodo() async {
    if (_notas.isEmpty) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Borrar todo'),
        content: const Text('¿Seguro que quieres borrar todas las notas?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Borrar')),
        ],
      ),
    );
    if (confirm == true) {
      setState(() => _notas.clear());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Todas las notas borradas')));
    }
  }

  void _mostrarDialogoAgregar() {
    final ctrl = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Agregar nota'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          maxLength: 100,
          decoration: const InputDecoration(hintText: 'Escribe una nota corta'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final texto = ctrl.text.trim();
              if (texto.isNotEmpty) {
                _agregarNota(texto);
                Navigator.pop(context);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas rápidas'),
        actions: [
          IconButton(onPressed: _borrarTodo, icon: const Icon(Icons.delete_forever)),
        ],
      ),
      drawer: const AppDrawer(),
      body: _notas.isEmpty
          ? const Center(child: Text('No hay notas. Presiona + para agregar.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _notas.length,
              itemBuilder: (_, i) {
                return Card(
                  child: ListTile(
                    title: Text(_notas[i]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        final removed = _notas[i];
                        setState(() => _notas.removeAt(i));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nota borrada: $removed')));
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
