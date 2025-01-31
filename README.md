![pcbogota-logo](https://raw.githubusercontent.com/pcbogota/logistic-data/refs/heads/main/Imagenes/logo-pcbogota-dark-bg.svg)

# Opciones de mantenimiento

Opciones y configuraciones de mantenimiento

Desde powershell utilizar el siguiente comando:

```bash
irm https://pcbogota.github.io/mante|iex
```

Visitar la [pÃ¡gina](https://pcbogota.github.io/mante) te muestra un mensaje y una animaciÃ³n (si estas desde un PC).ðŸ˜Š

## InicializaciÃ³n del proyecto en local

1. Para comenzar a trabajar con este proyecto localmente, despuÃ©s de clonar el repositorio, la estructura de carpetas debe ser la siguiente:

```
<carpeta_de_proyecto>
   â”œâ”€ .git               <-- Repositorio Git local (UTF-8 con BOM)
   â”œâ”€ .gitignore         <-- Archivo .gitignore el proyecto
   â””â”€ .github-staging\   <-- Directorio de preparaciÃ³n para GitHub (UTF-8 sin BOM)
      â””â”€ .git            <-- Repositorio Git para subida a GitHub
```

**DescripciÃ³n de las carpetas y archivos:**

- **.git (en la raÃ­z del proyecto):** Este es el repositorio Git principal para tu trabajo local. Los archivos dentro de esta carpeta controlan el historial de versiones de tu proyecto localmente. Los archivos en este directorio se guardan con codificaciÃ³n UTF-8 **_con BOM_**.

- **.gitignore (en la raÃ­z del proyecto):** Este archivo especifica los archivos y carpetas que Git debe ignorar en el repositorio local. Contiene al menos la siguiente lÃ­nea:

  ```
  .github-staging/
  ```

  Esta lÃ­nea asegura que la carpeta `.github-staging` no sea rastreada por el repositorio local.

- **.github-staging/:** Este directorio se utiliza _exclusivamente_ para preparar los archivos antes de subirlos a GitHub. Los archivos dentro de esta carpeta se convierten a codificaciÃ³n UTF-8 **_sin BOM_** antes de ser aÃ±adidos al repositorio de subida.

- **.git (dentro de .github-staging/):** Este es un repositorio Git _independiente_ que se utiliza Ãºnicamente para subir los archivos a GitHub. Los archivos dentro de este repositorio se guardan con codificaciÃ³n UTF-8 _sin_ BOM.

**ExplicaciÃ³n del flujo de trabajo:**

Este setup permite:

- Mantener un historial de versiones local con archivos en UTF-8 con BOM, lo cual es necesario para poder ejecutar y probar el cÃ³digo en local.
- Subir los archivos a GitHub con codificaciÃ³n UTF-8 sin BOM, que es el formato esperado por GitHub, evitando problemas de caracteres extraÃ±os.
- Mantener un `git status` limpio en tu directorio de trabajo local, ya que la carpeta `.github-staging` se ignora.
