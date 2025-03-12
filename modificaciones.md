# Proyecto Flutter: Lista de Tareas

## Navegación

La aplicación tiene las siguientes rutas de navegación:

- `/`: Pantalla de inicio de sesión (`LoginScreen`)
- `/register`: Pantalla de registro (`RegisterScreen`)
- `/home`: Pantalla principal con la lista de tareas (`HomeList`)

## Pantallas

### LoginScreen

- **Descripción**: Pantalla de inicio de sesión.
- **Widgets principales**:
  - `CustomTextField`: Campo de texto personalizado para el nombre de usuario y la contraseña.
  - `CustomButton`: Botón personalizado para iniciar sesión.
  - `TextButton`: Botón para navegar a la pantalla de registro.

### RegisterScreen

- **Descripción**: Pantalla de registro de usuario.
- **Widgets principales**:
  - `CustomTextField`: Campos de texto personalizados para el nombre de usuario, email, contraseña y repetir contraseña.
  - `CustomButton`: Botón personalizado para registrar al usuario.
  - `TextButton`: Botón para regresar a la pantalla de inicio de sesión.

### HomeList

- **Descripción**: Pantalla principal que muestra la lista de tareas.
- **Widgets principales**:
  - `ListView.builder`: Lista de tareas.
  - `ListTile`: Elemento de la lista que muestra el título y contenido de la tarea, con opciones para editar y eliminar.
  - `FloatingActionButton`: Botón para agregar una nueva tarea.

## Widgets Personalizados

### CustomTextField

- **Descripción**: Campo de texto personalizado.
- **Propiedades**:
  - `controller`: Controlador del campo de texto.
  - `labelText`: Texto de la etiqueta del campo.
  - `obscureText`: Indica si el texto debe ser oculto (por defecto es `false`).

### CustomButton

- **Descripción**: Botón personalizado.
- **Propiedades**:
  - `text`: Texto del botón.
  - `onPressed`: Función que se ejecuta al presionar el botón.
  - `backgroundColor`: Color de fondo del botón.
  - `foregroundColor`: Color del texto del botón.
