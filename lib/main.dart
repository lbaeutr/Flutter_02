import 'package:flutter/material.dart';
import 'package:flutter_listatareas_api/screens/home_list.dart';
import 'package:flutter_listatareas_api/screens/loginscreen.dart';
import 'package:flutter_listatareas_api/screens/register_screen.dart';


/// Función principal que inicia la aplicación Flutter
void main() {
  runApp(const MainApp());
}

/// Clase principal de la aplicación que extiende de StatelessWidget, que es un widget inmutable
/// que no tiene estado y no cambia a lo largo del tiempo
class MainApp extends StatelessWidget {
  const MainApp({super.key});


  /// Método build que construye la interfaz de la aplicación
  /// Recibe un BuildContext que es un objeto que contiene información sobre la ubicación
  /// de este widget en el árbol de widgets
  /// Devuelve un widget que es la representación visual de la aplicación
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de "debug"
      title: 'Lista de Tareas (API)', 
      themeMode: ThemeMode.system, // Usa el tema del sistema (claro u oscuro)
      theme: ThemeData.light(), // Tema claro predeterminado
      darkTheme: ThemeData.dark(), // Tema oscuro predeterminado
      initialRoute: '/', // Ruta inicial al iniciar la app
      routes: {
        '/': (context) => const LoginScreen(), 
        '/register': (context) => const RegisterScreen(), 
        '/home': (context) => const HomeList(), 
      },
    );
  }
}
