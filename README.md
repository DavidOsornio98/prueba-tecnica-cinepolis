# Prueba técnica Cinépolis

Soluciones para la prueba técnica de Backend Engineer. El repositorio está organizado con
la misma estructura de secciones y problemas del documento proporcionado.

## Contenido

```text
Seccion1/
  problema_a.py              Agrupación de funciones por película
  problema_b.py              Validación de horarios
Seccion2/
  bd.sql                     Tablas y datos de prueba para PostgreSQL
  pregunta_a.sql             Porcentaje de ocupación en cines VIP
  pregunta_b.sql             Cines sin funciones programadas ayer
  pregunta_c.sql             Propuesta de índice
Seccion3/
  problema_a/                API REST con FastAPI y PostgreSQL
  problema_b.py              Identificación de errores en un endpoint
  problema_c.txt             Diferencias entre conceptos HTTP
Seccion4/
  problema_a/                WeekSelector con React y TypeScript
  problema_b.tsx             Identificación de errores en un componente
```

Las aplicaciones de `Seccion3/problema_a` y `Seccion4/problema_a` resuelven ejercicios
independientes. El frontend utiliza un mock de `/api/v1/weeks` y no consume la API de
FastAPI.

## Requisitos

- Python 3.10 o superior.
- Node.js `^20.19.0` o `>=22.12.0`.
- npm.
- PostgreSQL, instalado localmente o ejecutándose en Docker.
- Opcionalmente, un cliente como TablePlus, pgAdmin o una extensión de PostgreSQL para
  Visual Studio Code.

TablePlus y Visual Studio Code solamente se utilizan como clientes para conectarse al
servidor. PostgreSQL debe estar instalado en el equipo o ejecutándose dentro de Docker.

## Preparar PostgreSQL

### Opción 1: PostgreSQL instalado

Si PostgreSQL ya está instalado y en ejecución, no es necesario utilizar Docker. Conéctate
al servidor con tus credenciales mediante TablePlus, Visual Studio Code, pgAdmin o `psql` y
continúa en [Crear la base de datos](#crear-la-base-de-datos).

### Opción 2: PostgreSQL con Docker

Utiliza esta opción solamente si no cuentas con un servidor PostgreSQL local:

```powershell
docker pull postgres:16
docker volume create postgres-cinepolis-david
docker run --name postgres-cinepolis `
  -d `
  -p 5432:5432 `
  -e POSTGRES_PASSWORD=mysecretpassword `
  -v postgres-cinepolis-david:/var/lib/postgresql/data `
  postgres:16
```

Comprueba que el contenedor esté activo:

```powershell
docker ps
```

Datos de conexión utilizados durante el desarrollo:

| Campo | Valor |
| --- | --- |
| Host | `localhost` |
| Puerto | `5432` |
| Usuario | `postgres` |
| Contraseña | `mysecretpassword` |
| Base inicial | `postgres` |

### Crear la base de datos

1. Conéctate inicialmente a la base `postgres`.
2. Ejecuta la siguiente instrucción:

```sql
CREATE DATABASE prueba_cinepolis_david;
```

3. Abre una conexión o editor SQL nuevo seleccionando `prueba_cinepolis_david`.
4. Ejecuta todo el archivo `Seccion2/bd.sql` dentro de esa base.

La creación de la base está separada de `bd.sql` porque PostgreSQL no cambia
automáticamente a una base recién creada. Este procedimiento funciona igual desde
TablePlus, Visual Studio Code, pgAdmin o `psql`.

Verifica la carga con:

```sql
SELECT COUNT(*) FROM cinemas;   -- 6
SELECT COUNT(*) FROM movies;    -- 8
SELECT COUNT(*) FROM showtimes; -- 36
```

Los datos de funciones usan `CURRENT_DATE`, de modo que los endpoints y consultas que
dependen de hoy o de ayer puedan revisarse al momento de cargar el script.

## Ejecutar FastAPI

La guía completa se encuentra en
[`Seccion3/problema_a/README.md`](Seccion3/problema_a/README.md).

Resumen:

```powershell
cd .\Seccion3\problema_a
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python -m uvicorn main:app --reload
```

Antes de iniciar el servicio, revisa `Seccion3/problema_a/database.py`. Si no utilizas el
contenedor descrito anteriormente, reemplaza `host`, `port`, `dbname`, `user` y `password`
con los datos de tu servidor PostgreSQL.

Swagger estará disponible en <http://127.0.0.1:8000/docs>.

## Ejecutar React

La guía completa se encuentra en
[`Seccion4/problema_a/README.md`](Seccion4/problema_a/README.md).

```powershell
cd .\Seccion4\problema_a
npm ci
npm run dev
```

El proyecto intercepta `/api/v1/weeks` mediante un mock habilitado únicamente durante el
desarrollo. En `src/common/mockFetch.ts`, usa `SHOULD_FAIL = false` para revisar la carga
correcta y `SHOULD_FAIL = true` para revisar el mensaje `Error al cargar semanas`.

## Limitación del endpoint de cines

El enunciado solicita mostrar salas y funciones, pero las tablas proporcionadas no incluyen
una entidad `rooms` ni una relación entre sala y función. Por ese motivo, la respuesta del
endpoint mantiene `rooms` como una lista vacía y devuelve las funciones disponibles en
`showtimes`.

Completar esa parte requeriría modificar el esquema proporcionado, añadir una tabla de salas
y relacionarla con `showtimes`. Se decidió conservar el esquema original y documentar esta
limitación.

## Revisión rápida

1. Inicia PostgreSQL localmente o con Docker.
2. Crea `prueba_cinepolis_david` y ejecuta `Seccion2/bd.sql` conectado a ella.
3. Ejecuta las consultas de `Seccion2` desde el mismo cliente SQL.
4. Ajusta `Seccion3/problema_a/database.py` y levanta FastAPI.
5. Prueba `GET /cines/1`, `GET /cines/2` y `GET /cines/999` desde Swagger.
6. Levanta React con `npm run dev` y revisa el mock con ambos valores de `SHOULD_FAIL`.
7. Ejecuta `npm run lint` y `npm run build` para validar el frontend.
