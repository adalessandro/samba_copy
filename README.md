### Estructura del directorio.

~~~
.
├── All Users
│   └── Nombre Equipo.lnk
├── input.txt
├── Nombre Equipo
│   └── Nombre Equipo.exe
├── nombres_dominio_backup_251013.txt
├── output.txt
├── README.md
└── samba_copy.sh

2 directories, 7 files
~~~

## Funcionamiento

Básicamente el script toma un archivo input.txt que contiene líneas con el formato: hostaname,status
Si el status es OK lo ignora, de lo contrario trata de copiar en ese host.
La salida es un archivo output.txt con líneas de igual formato, con el status actualizado.
Para volver a correr el programa con los status actualizados, debería moverse output.txt a input.txt

El script monta en directorios locales los directorios del host remoto. Si lo monta exitósamente, copia los archivos indicados (si los archivos o directorios ya existen, sobrescribe).
NOTA: Tener en cuenta que si para montar se utilizan subdirectorios de /mnt, hay que ejecutarlo como root o como un usuario con permisos. 

### Descripción.

* All Users y Nombre Equipo son las carpetas o archivos locales a copiar. Esto se setea en las variables al comienzo del script.
* output.txt no es necesario, el script concatena la salida al final del mismo.
* input.txt es de donde se leen los nombres de los equipos del dominio y su estado.
* nombres_dominio_backup_251013.txt muestra cómo podría ser input.txt en la primera ejecución.

