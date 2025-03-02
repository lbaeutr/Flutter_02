## **Proyecto: Lista de Tareas**  
Este proyecto es una app en Flutter para gestionar una lista de tareas. Tiene lo esencial: registro, inicio de sesión y la posibilidad de manejar notas de manera sencilla.

**Funcionalidades**  
- Registro de usuario  
- Inicio de sesión  
- Agregar, editar y eliminar notas  
- Modo claro y oscuro  

**Estructura del proyecto**  
- `lib/screens/`: Contiene todas las pantallas (registro, inicio de sesión, lista de tareas).
- `lib/models/`: Modelos de datos de la app.
- `lib/assets/`: Recursos estáticos como imágenes.

**Detalle de las funcionalidades**  

**Registro de Usuario**  
Desde la pantalla de registro puedes crear una cuenta con tu correo y contraseña. La contraseña debe confirmarse antes de continuar.

**Inicio de Sesión**  
Si ya tienes una cuenta, solo ingresas tu correo y contraseña. Si todo está bien, te lleva a la pantalla principal.

**Gestión de Notas**  
En la pantalla principal puedes:
- Agregar notas con título y contenido.
- Editar notas existentes.
- Eliminar notas (con confirmación para evitar errores).

**Modo Claro y Oscuro**  
La app cambia automáticamente entre modo claro y oscuro según la configuración del sistema del dispositivo.

- **Capturas de pantalla**  

    | Modo Claro | Modo Oscuro |
    |------------|-------------|
    | ![Modo Claro](lib/resources/screenshoot/modoclaro.png) | ![Modo Oscuro](lib/resources/screenshoot/modooscuro.png) |


**Componentes**  
- **RegisterScreen**  
  Pantalla para registrarse. Usa `TextEditingController` para manejar los inputs y `SnackBar` para mostrar mensajes de éxito o error.

- **LoginScreen**  
  Pantalla de inicio de sesión. Maneja la entrada de datos y muestra errores con `SnackBar`. Si las credenciales son correctas, redirige a la pantalla principal.

- **HomeList**  
  La pantalla principal donde ves tus notas. Puedes agregar, editar o eliminar usando `showModalBottomSheet` para el formulario y `AlertDialog` para confirmaciones.

    La pantalla usa un Scaffold, que básicamente le da la estructura principal a la app. Arriba tiene una AppBar con un botón para cerrar sesión.

    En el body, usamos un Stack para poner una imagen de fondo que cambia según el modo del sistema (claro u oscuro) y, encima de eso, el contenido principal de la pantalla.

    El contenido está organizado en una Column, donde un Expanded contiene una lista de notas (ListView.builder). Cada nota se muestra dentro de una Card, que tiene un ListTile con el título y el contenido de la nota, junto con botones (IconButton) para editar y eliminar.

    También hay un FloatingActionButton que sirve para agregar nuevas notas. La lógica para manejar las notas está en los métodos addOrEditNote (para agregar o editar) y deleteNote (para eliminar). Si intentas borrar una nota, aparece un cuadro de confirmación antes de hacerlo. Y si vas a agregar o editar, se muestra un modal para que puedas escribir tu nota.

**Capturas de pantalla**  
Modo Claro | Modo Oscuro  

**Próximos pasos**  

Este proyecto es la base para conectar con la API que estamos desarrollando.
Vamos a usar SharedPreferences para guardar los tokens de la app y la librería Retrofit para hacer las peticiones a la API.



### Junto con la entrega, también incluyo un video mostrando cómo funciona la interfaz. Además, adjunto el enlace al repositorio. 

- [Repositorio del proyecto](https://github.com/lbaeutr/Flutter_02)
