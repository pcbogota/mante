![pcbogota-logo](https://raw.githubusercontent.com/pcbogota/logistic-data/refs/heads/main/Imagenes/logo-pcbogota-dark-bg.svg)

# Opciones de mantenimiento

Opciones y configuraciones de mantenimiento

Desde powershell utilizar el siguiente comando:

```bash
irm https://pcbogota.github.io/mante|iex
```

Visitar la [página](https://pcbogota.github.io/mante) te muestra un mensaje y una animación (si estas desde un PC).😊

## Inicialización del proyecto en local

1. Para comenzar a trabajar con este proyecto localmente, después de clonar el repositorio, la estructura de carpetas debe ser la siguiente:

```
<carpeta_de_proyecto>
   ├─ .git               <-- Repositorio Git local (UTF-8 con BOM)
   ├─ .gitignore         <-- Archivo .gitignore el proyecto
   └─ .github-staging\   <-- Directorio de preparación para GitHub (UTF-8 sin BOM)
      └─ .git            <-- Repositorio Git para subida a GitHub
```

**Descripción de las carpetas y archivos:**

- **.git (en la raíz del proyecto):** Este es el repositorio Git principal para tu trabajo local. Los archivos dentro de esta carpeta controlan el historial de versiones de tu proyecto localmente. Los archivos en este directorio se guardan con codificación UTF-8 **_con BOM_**.

- **.gitignore (en la raíz del proyecto):** Este archivo especifica los archivos y carpetas que Git debe ignorar en el repositorio local. Debe contener al menos la siguiente línea:

  ```
  .github-staging/
  ```

  Esta línea asegura que la carpeta `.github-staging` no sea rastreada por el repositorio local.

- **.github-staging/:** Este directorio se utiliza _exclusivamente_ para preparar los archivos antes de subirlos a GitHub. Los archivos `.ps1` dentro de esta carpeta se convierten a codificación UTF-8 **_sin BOM_** antes de ser añadidos al repositorio de subida.

- **.github-staging/.git:** Este es un repositorio Git _independiente_ que se utiliza únicamente para subir los archivos a GitHub.

## Explicación del flujo de trabajo:

Este setup permite:

- Mantener un historial de versiones local con archivos en UTF-8 con BOM, lo cual es necesario para poder ejecutar y probar el código en local.
- Subir los archivos a GitHub con codificación UTF-8 sin BOM, que es el formato esperado por GitHub, evitando problemas de caracteres extraños.
- Mantener un `git status` limpio en tu directorio de trabajo local, ya que la carpeta `.github-staging` se ignora.
