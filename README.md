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
### Descripción.

* All Users y Nombre Equipo son las carpetas o archivos a copiar. Esto se setea en las variables al comienzo del script.
* output.txt puede existir o no, el script concatena la salida al final del mismo.
* input.txt es de donde se leen los nombres de los equipos del dominio.
* input.txt debería ser una copia de nombres_dominio_backup_251013.txt al comienzo.

### Input file

Tiene un formato nombre_equipo, estado. También puede ser solamente nombre_equipo.
En el caso de que el estado sea OK lo saltea sin realizar ninguna acción.
Caso contrario intenta ejecutar el copiado por samba y modifica el estado de acuerdo al resultado.
