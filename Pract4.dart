import 'package:flutter/material.dart';
import 'JuegoRPS.dart'; // Para usar AppDrawer

class Prac4 extends StatefulWidget {
  const Prac4({super.key});

  @override
  State<Prac4> createState() => _Prac4State();
}

class _Prac4State extends State<Prac4> {
  final _formKey = GlobalKey<FormState>();

  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirmPass = true;
  bool _aceptoTerminos = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      if (!_aceptoTerminos) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Debes aceptar los términos")),
        );
        return;
      }
      final nombre = _nombreCtrl.text;
      final email = _emailCtrl.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrado: $nombre ($email)")),
      );
    }
  }

  void _limpiarFormulario() {
    _formKey.currentState!.reset();
    _nombreCtrl.clear();
    _emailCtrl.clear();
    _passCtrl.clear();
    _confirmPassCtrl.clear();
    setState(() {
      _aceptoTerminos = false;
      _obscurePass = true;
      _obscureConfirmPass = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: const AppDrawer(), // ✅ Menú hamburguesa
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nombre
              TextFormField(
                controller: _nombreCtrl,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El nombre es obligatorio";
                  }
                  if (value.length < 3) {
                    return "Debe tener al menos 3 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Email
              TextFormField(
                controller: _emailCtrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El email es obligatorio";
                  }
                  final regex = RegExp(r"^[^@]+@[^@]+\.[^@]+");
                  if (!regex.hasMatch(value)) {
                    return "Ingresa un email válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Contraseña
              TextFormField(
                controller: _passCtrl,
                textInputAction: TextInputAction.next,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La contraseña es obligatoria";
                  }
                  if (value.length < 6) {
                    return "Debe tener al menos 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Confirmar contraseña
              TextFormField(
                controller: _confirmPassCtrl,
                textInputAction: TextInputAction.done,
                obscureText: _obscureConfirmPass,
                decoration: InputDecoration(
                  labelText: "Confirmar Contraseña",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPass
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                        () => _obscureConfirmPass = !_obscureConfirmPass),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirma tu contraseña";
                  }
                  if (value != _passCtrl.text) {
                    return "Las contraseñas no coinciden";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Checkbox Términos
              CheckboxListTile(
                value: _aceptoTerminos,
                onChanged: (val) =>
                    setState(() => _aceptoTerminos = val ?? false),
                title: const Text("Acepto términos y condiciones"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 16),
              // Botón Enviar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                ),
                onPressed: _enviarFormulario,
                child: const Text(
                  "Enviar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              // Botón Limpiar
              OutlinedButton(
                onPressed: _limpiarFormulario,
                child: const Text(
                  "Limpiar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Botón regresar
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Regresar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
