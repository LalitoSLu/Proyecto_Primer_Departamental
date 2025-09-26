import 'package:flutter/material.dart';

class GaleriaLocal extends StatelessWidget {
  const GaleriaLocal({super.key});

  // Lista de imágenes (todas .jpg ahora)
  final List<Map<String, String>> imagenesAssets = const [
    {'ruta': 'assets/images/imagen_1.jpg', 'titulo': 'Imagen 1'},
    {'ruta': 'assets/images/imagen_2.jpg', 'titulo': 'Imagen 2'},
    {'ruta': 'assets/images/imagen_3.jpg', 'titulo': 'Imagen 3'},
    {'ruta': 'assets/images/imagen_4.jpg', 'titulo': 'Imagen 4'},
  ];

  // Función para mostrar la imagen en un diálogo
  void _mostrarImagen(BuildContext context, String ruta, String titulo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Image.asset(ruta, fit: BoxFit.contain),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería local')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 2, // 2 columnas
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: imagenesAssets.map((img) {
            return GestureDetector(
              onTap: () => _mostrarImagen(context, img['ruta']!, img['titulo']!),
              child: Card(
                child: Image.asset(
                  img['ruta']!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
