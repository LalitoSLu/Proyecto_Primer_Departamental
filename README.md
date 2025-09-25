# Proyecto_Primer_Departamental

📱 Portafolio Flutter – Kit Offline
📖 Descripción general (muy detallada)

Esta app es un portafolio académico desarrollado en Flutter que agrupa las prácticas realizadas y un proyecto final llamado “Kit Offline”. Está pensado para funcionar completamente en memoria (sin APIs ni bases de datos) y demuestra:

Navegación centralizada (rutas nombradas + Drawer).

Reuso de pantallas y widgets comunes.

Formularios y validaciones (IMC y registro).

UI consistente usando AppBar, Card, GridView, ListView, SnackBar, AlertDialog, y ThemeMode.

Uso de assets locales (assets/images/).

Comportamiento general:
Al iniciar la app (main.dart) se carga MyApp (Stateful). MaterialApp define initialRoute: '/' y un mapa de routes que enlaza rutas con pantallas (Home, Practicas, Proyecto, Ajustes, y rutas internas del Kit). El tema (claro/oscuro) se maneja desde MyApp y se alterna vía MyApp.of(context).toggleTheme(...). Todas las pantallas usan un Drawer compartido (app_drawer.dart) para navegación global.

🗂 Estructura de archivos (cómo está organizado el proyecto)
/lib
  ├─ main.dart            // punto de entrada + rutas + ThemeMode
  ├─ home.dart            // Hub principal (Dashboard)
  ├─ app_drawer.dart      // Drawer reutilizable
  ├─ practicas.dart       // Índice de prácticas
  ├─ proyecto.dart        // Contenedor del Kit Offline (lista de módulos)
  ├─ ajustes.dart         // Tema / Acerca de
  ├─ notas.dart           // Módulo: Notas rápidas
  ├─ imc.dart             // Módulo: Calculadora IMC
  ├─ galeria.dart         // Módulo: Galería local
  ├─ par_impar.dart       // Módulo: Juego Par o Impar
  ├─ Primera.dart         // Práctica 1
  ├─ Segunda.dart         // Práctica 2
  ├─ Pract4.dart          // Práctica 4 (registro con validaciones)
  └─ JuegoRPS.dart        // Juego Piedra Papel Tijera (práctica)
assets/
  └─ images/
      ├─ imagen_1.jpg
      ├─ imagen_2.jpg
      └─ ...
pubspec.yaml
README.md

🔁 Mapeo de rutas (definidas en main.dart)

/ → HomeScreen() (Hub principal)

/practicas → PracticasScreen()

/proyecto → ProyectoScreen()

/ajustes → AjustesScreen()

/p1 → Primera()

/p2 → Segunda()

/p4 → Prac4()

/juegoRPS → JuegoRPS()

/kit/notas → NotasScreen()

/kit/imc → ImcScreen()

/kit/galeria → GaleriaLocal()

/kit/parimpar → ParImparScreen()

🧭 Explicación detallada de la navegación y por qué evita duplicar código

Centralización con MaterialApp.routes:
Todas las pantallas importantes están registradas en routes en main.dart. Esto permite navegar con Navigator.pushNamed(context, '/ruta') en lugar de reconstruir pantallas ad-hoc. Facilita control del flujo (back stack) y evita duplicar lógica de creación de pantallas en múltiples lugares.

Drawer reutilizable (app_drawer.dart):
El menú lateral está implementado en un único widget AppDrawer. Se importa y reutiliza desde la mayoría de las pantallas (drawer: const AppDrawer()), garantizando que la navegación lateral, la cabecera y los links sean consistentes sin repetir markup.

Funciones de navegación coherentes:

Navigator.pushNamed(context, route) para navegación normal.

Navigator.pushReplacementNamed(context, '/practicas') cuando se desea reemplazar la pantalla actual (útil desde el Drawer).

Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false) para regresar al Hub y limpiar la pila (uso en el Drawer para "Inicio").

Accesibilidad global al Theme:
La variable ThemeMode y las funciones para alternarlo viven en _MyAppState. El acceso a esta lógica se hace a través de MyApp.of(context) (método estático), evitando propagar setState o pasar callbacks por constructor entre muchas pantallas.

Nota práctica: en JuegoRPS.dart existe una implementación local de AppDrawer (otro AppDrawer definido en ese archivo). Esa duplicidad no rompe la app pero es un candidato para consolidar: usar siempre app_drawer.dart centralizado para evitar inconsistencia futura.

🎨 Decisiones de UI y consistencia visual (motivos y ejemplos)

Tema y Material 3: ThemeData(... useMaterial3: true) para apariencia moderna. El primarySwatch es Colors.deepPurple y se mantiene en todas las pantallas para coherencia.

AppBar consistente: cada pantalla define título relevante; colores del AppBar siguen la paleta (algunas prácticas usan variantes como Colors.pinkAccent para distinguir).

Uso de gradientes y cards: en pantallas de prácticas (P1, P2, JuegoRPS) se usan BoxDecoration con gradientes para estética y Card para elementos repetibles.

Componentes comunes: botones ElevatedButton, OutlinedButton, FAB y ToggleButtons mantienen comportamiento y spacing constantes.

Iconografía: se usan Icons apropiados para cada función (notas, imc, galería, juego, ajustes) para accesibilidad rápida.

Feedback in-app: SnackBar para acciones (agregar nota, calcular IMC, ganar/perder ronda), AlertDialog para confirmaciones (borrar todo) y para mostrar imagen ampliada.

🧪 Detalle de cada módulo (comportamiento y puntos clave)
Notas (notas.dart)

Estructura: List<String> _notas = [];

Agregar: FAB abre AlertDialog con TextField. Nota insertada al inicio (_notas.insert(0, texto)).

Borrar individual: icono Icons.delete en cada ListTile.

Borrar todo: IconButton en AppBar que abre AlertDialog de confirmación.

Feedback: ScaffoldMessenger.of(context).showSnackBar(...).

IMC (imc.dart)

Inputs: peso (kg), estatura (m).

Validaciones:

No vacío.

Convertir comas a punto: double.tryParse(v.replaceAll(',', '.')).

Número válido y > 0.

Estatura plausible: est <= 3 (valor límite razonable en metros).

Cálculo: imc = peso / pow(est, 2).

Categorías:

imc < 18.5 → Bajo peso

18.5 ≤ imc < 25 → Normal

25 ≤ imc < 30 → Sobrepeso

imc ≥ 30 → Obesidad

UI: Form con TextFormField, botón Calcular y Limpiar. Resultado en SnackBar.

Galería (galeria.dart)

Grid: GridView.count(crossAxisCount: 2).

Lista de imágenes con mapa {'ruta': 'assets/images/imagen_1.jpg', 'titulo': 'Imagen 1'}.

GestureDetector para abrir AlertDialog con Image.asset(...) en tamaño ampliado.

Requisito cumplido: solo assets locales, sin Image.network.

Par o Impar (par_impar.dart)

Elección Par/Impar via ToggleButtons.

Números 0–5 con List.generate(6, ...).

CPU genera número aleatorio Random().nextInt(6).

Suma y comprobación suma % 2 == 0.

Marcador en memoria (_userScore, _cpuScore) y botón Reiniciar.

Resultados mostrados con SnackBar.

Registro (Pract4.dart)

Campos: nombre, email, contraseña, confirmar contraseña.

Validaciones:

Nombre: mínimo 3 caracteres.

Email: regex r"^[^@]+@[^@]+\.[^@]+".

Contraseña: mínimo 6 caracteres.

Confirmar contraseña: comparar con _passCtrl.text.

Checkbox de términos obligatorio.

Feedback: SnackBar al registrarse correctamente.

⚠️ Limitaciones por trabajar solo con estado en memoria y cómo se sortearon

Limitaciones:

Al cerrar la app o hacer un cold restart, todo el estado se pierde (notas, marcador, selección de tema, etc.).

No hay historial persistente ni sincronización.

No se pueden compartir datos entre dispositivos.

Cómo se sortearon (estrategias en el código actual):

Se priorizó retroalimentación inmediata (SnackBars, diálogos) para que el usuario tenga confirmación clara de acciones aunque sean temporales.

El patrón MyApp.of(context) permite un único punto de control del ThemeMode reduciendo inconsistencias visuales aun sin persistencia.

Inserción ordenada en listas (ej. insert(0, ...)) para mantener una UX visible y lógica sin necesidad de almacenamiento.

Mejoras recomendadas (si se permitiera persistencia):

Guardar notas como JSON en SharedPreferences (rápida y simple).

Guardar el ThemeMode en SharedPreferences (persistencia inmediata del tema).

Si es necesario mayor rendimiento o queries: usar Hive o sqflite para notas y puntuaciones.

Separar la lógica de estado en un gestor (Provider / Riverpod / Bloc) para facilitar sincronización con persistencia.

✅ Validaciones aplicadas (por qué y cómo)
IMC

No vacío: evita excepciones al parsear.

Conversión de coma a punto: usuarios tienden a usar coma decimal en locales hispanos.

Número válido (> 0): impide divisiones por cero y datos no reales.

Estatura ≤ 3 m: filtro heurístico para evitar errores de captura (ej. ingresar en cm por error).

Resultado categorizado: umbrales estándar de la OMS (18.5 y 25 y 30) para clasificar de manera comprensible.

Registro (Prac4)

Nombre mínimo 3 caracteres: evitar nombres vacíos o inválidos.

Email con regex básico: evitar entradas con formato inválido.

Contraseña min. 6 caracteres: requisito mínimo de seguridad.

Confirmación de contraseña: prevenir errores tipográficos.

Checkbox de términos: control de consentimiento explícito.

🔔 Retroalimentación inmediata al usuario (cómo se implementó)

SnackBar: acción rápida (añadir nota, borrar nota, resultado de IMC, resultado de ronda).

AlertDialog: confirmaciones (borrar todas las notas) y vista ampliada de imágenes.

UI blocking mínimo: los diálogos se usan solo cuando se requiere confirmación/entrada para no interrumpir flujo.

Mensajes descriptivos: todos los SnackBars indican exactamente qué pasó (ej. Nota agregada, IMC: 23.45 • Normal).

▶️ Cómo ejecutar (paso a paso, incluido Visual Studio Code y emulador)
Requisitos previos

Tener instalado Flutter y configurado (flutter en el PATH).

Android Studio (para emuladores) o un dispositivo físico con depuración USB activada.

Visual Studio Code recomendado con extensiones: Flutter y Dart.

1) Clonar repo y obtener dependencias
git clone <url-del-repo>
cd <nombre-del-proyecto>
flutter pub get

2) Verificar instalación (opcional pero recomendado)
flutter doctor


Resolver cualquier advertencia que muestre flutter doctor.

3) Ejecutar en emulador (línea de comandos)

Listar dispositivos:

flutter devices


Si necesitas iniciar un emulador Android:

flutter emulators        # lista emuladores
flutter emulators --launch <emulatorId>


Correr la app:

flutter run
# o para un dispositivo específico:
flutter run -d <deviceId>

4) Ejecutar desde Visual Studio Code

Abre la carpeta del proyecto en VS Code.

Selecciona el dispositivo/emulador desde la barra inferior (o ejecuta un emulador).

Presiona F5 o usa Run > Start Debugging.

La app iniciará en HomeScreen (Hub principal). Usa el Drawer o los botones del Hub para navegar.

5) Problemas comunes & soluciones rápidas

Imágenes no aparecen: verifica pubspec.yaml que tenga:

flutter:
  assets:
    - assets/images/


Ejecuta flutter pub get y flutter clean si persiste.

Errores de dependencia: flutter pub get y revisar flutter doctor.

Hot reload no aplica cambios globales (Theme/initialRoute): usar full restart (R).

📸 Capturas (plantilla para tu repo)

Pon tus capturas en capturas/ y enlázalas así:

![Hub principal](capturas/hub.png)
![Índice de prácticas](capturas/practicas.png)
![Notas rápidas](capturas/notas.png)
![IMC](capturas/imc.png)
![Galería](capturas/galeria.png)
![Par o Impar](capturas/parimpar.png)
![Ajustes](capturas/ajustes.png)

✅ Checklist (mapa al criterio de evaluación)

 Navegación y rutas (25 pts) — Hub, Drawer, rutas nombradas, títulos y navegación hacia atrás (back) implementados.

 Integración de prácticas (15 pts) — P1, P2, P4, JuegoRPS integrados y accesibles desde el índice.

 Kit Offline – Notas (10 pts) — Agregar, listar, borrar con confirmación.

 Kit Offline – IMC (10 pts) — Form + validaciones + resultado.

 Kit Offline – Galería (10 pts) — Grid de assets + diálogo ampliado.

 Kit Offline – Par/Impar (10 pts) — Juego con marcador y snackbars.

 UI/UX y consistencia (10 pts) — Espaciado, iconos, colores y feedback coherentes.

 Calidad de código (10 pts) — Organización de archivos y uso correcto de dispose() en formularios.

✍️ Reflexión (respuestas breves a tus 6 preguntas — formato compacto, máximo ~media cuartilla cada una)
1) ¿Cómo organicé la navegación para integrar Hub, índice de prácticas y proyecto sin duplicar código?

La navegación se centralizó en main.dart mediante MaterialApp y un mapa de routes. El Drawer se implementó como un widget único (app_drawer.dart) y se reutiliza en casi todas las pantallas; así, el menú lateral y sus acciones (ir a Inicio, Prácticas, Proyecto, Ajustes) no se repiten. Las prácticas están registradas como rutas nombradas (/p1, /p2, etc.), lo que evita instanciar las pantallas en cada punto donde se quieran usar. Para cambios globales (tema), MyApp expone métodos estáticos (MyApp.of(context)) evitando pasar callbacks por constructores. Estos tres elementos (routes centralizadas + Drawer reutilizable + punto único para estado global) evitan duplicación y mantienen coherencia.

2) ¿Qué decisiones de UI tomé para mantener consistencia entre prácticas y proyecto?

Usé la misma paleta (deepPurple), AppBar con títulos claros, Card y GridView/ListView donde aplica y botones con estilos similares (Elevated/Outlined). Los gradientes aplicados en prácticas sirven para distinguir visualmente actividades sin romper la coherencia porque conservan la tipografía y el espaciado. El Drawer y los iconos proporcionan navegación homogénea. Además, los mensajes mediante SnackBar y los AlertDialog siguen un patrón uniforme para la retroalimentación.

3) ¿Qué límites encontré al trabajar solo con estado en memoria y cómo los sorteé?

Límites: pérdida total del estado al cerrar la app, imposibilidad de historial/puntuaciones persistentes y dificultad para probar estados a largo plazo. Para sortearlo, hice énfasis en retroalimentación inmediata (SnackBars), usé inserciones que muestran el contenido nuevo arriba (insert(0, ...)) para UX clara, y centralicé el control del tema para que al menos el cambio sea inmediato durante la sesión. Para producción, recomendaría persistir notas y configuraciones.

4) ¿Qué validaciones apliqué en la calculadora de IMC y por qué?

Campos no vacíos: evitar errores de parseo.

Conversión de coma a punto: conveniencia para el usuario hispanohablante.

Números válidos y > 0: sentido físico de las medidas.

Estatura ≤ 3 m: filtro heurístico para evitar entradas en cm o caracteres incorrectos.
Estas reglas evitan resultados absurdos y protegen la app de excepciones.

5) ¿Cómo garantizaste retroalimentación inmediata al usuario sin recargar la interfaz?

Usando SnackBar para casi todas las acciones (agregar nota, borrar, resultados de IMC y juegos) y AlertDialog para confirmaciones o vistas ampliadas. Estas herramientas permiten comunicar estado y resultado sin reconstruir pantallas ni bloquear UI, lo que proporciona una UX fluida y reactiva.

6) Si pudiera persistir datos, ¿qué mejoraría primero y con qué enfoque?

Primero persistiría notas y tema (SharedPreferences para empezar por su simplicidad: guardar un JSON con la lista de notas y una clave booleana para el tema). Luego, si se requiere mayor estructura (búsqueda, índices), migraría a Hive o sqflite. Paralelamente extraería la lógica de estado a un gestor (Provider/Riverpod) para desacoplar UI y facilitar sincronización entre memoria y almacenamiento persistente.

👤 Autor

Alexis Eduardo Suarez Hernandez — Versión: 1.0

🔚 Notas finales / recomendaciones rápidas

Recomendable consolidar la definición duplicada del AppDrawer (hay otra en JuegoRPS.dart) para mantener un único widget Drawer.

Si añades persistencia: empieza por SharedPreferences para notas y tema, y luego decide si migrar a una db local.

Incluye las capturas en capturas/ y actualiza este README con las imágenes.
