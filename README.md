# Terminal FFmpeg Video Converter Script 
This script requires **ffmpeg, python**

Probado en:

**Debian 12**

Explicación del funcionamiento del script:

1. Definición del directorio del script:
   ```bash
   SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
   ```
   Esta línea obtiene la ruta absoluta del directorio donde se encuentra el script.

2. Función `check_video_files()`:
   - Busca archivos de video en el directorio actual.
   - Muestra una lista numerada de los archivos encontrados.
   - Permite al usuario seleccionar un archivo para convertir.

3. Inicio del script principal:
   - Muestra el título y la fecha de actualización.
   - Llama a la función `check_video_files()`.

4. Menú principal:
   - Muestra las opciones de conversión (mp4, mp3, avanzada).
   - Lee la selección del usuario.

5. Preparación para la conversión:
   - Extrae el nombre del archivo sin la extensión.
   - Define el directorio de salida.
   - Crea el directorio de salida si no existe.

6. Proceso de conversión:
   - Opción 1 (Convertir a mp4):
     * Muestra opciones de calidad de video.
     * Ejecuta ffmpeg con los parámetros correspondientes a la calidad seleccionada.
   - Opción 2 (Convertir a mp3):
     * Muestra opciones de calidad de audio.
     * Ejecuta ffmpeg para convertir a mp3 con la calidad seleccionada.
   - Opción 3 (Conversión avanzada):
     * Permite al usuario especificar el formato de salida.
     * Ejecuta ffmpeg con el formato especificado.

7. Finalización:

   - Muestra un mensaje indicando que la conversión ha terminado y dónde se han guardado los archivos.
