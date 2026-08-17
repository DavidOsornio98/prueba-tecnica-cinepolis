# Problema A: API de detalle de cine

Implementación en FastAPI del endpoint que consulta el detalle de un cine y sus funciones
para una fecha. Los datos se obtienen de PostgreSQL mediante Psycopg.

## Requisitos

- Python 3.10 o superior.
- PostgreSQL con la base `prueba_cinepolis_david` inicializada.

Consulta las instrucciones para PostgreSQL local o Docker en el
[`README` principal](../../README.md#preparar-postgresql).

## Configurar la conexión

La conexión se encuentra en `database.py`:

```python
return psycopg.connect(
    host="localhost",
    port=5432,
    dbname="prueba_cinepolis_david",
    user="postgres",
    password="mysecretpassword",
)
```

Esos valores corresponden al contenedor Docker descrito en el README principal. Si utilizas
una instalación local de PostgreSQL, reemplázalos con el host, puerto, usuario y contraseña
de tu servidor. Las credenciales incluidas son únicamente para desarrollo local.

## Instalación

Desde la raíz del repositorio, ejecuta:

```powershell
cd .\Seccion3\problema_a
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

`requirements.txt` conserva solamente las dependencias directas utilizadas por la solución:

- FastAPI para la API REST.
- Pydantic para los esquemas de respuesta.
- Psycopg para PostgreSQL.
- Uvicorn para ejecutar el servicio.

## Ejecución

```powershell
python -m uvicorn main:app --reload
```

Direcciones disponibles:

- API: <http://127.0.0.1:8000>
- Swagger: <http://127.0.0.1:8000/docs>

## Endpoint

```http
GET /cines/{cine_id}?fecha=AAAA-MM-DD
```

`fecha` es opcional. Si no se proporciona, se utiliza la fecha actual.

Ejemplos:

```text
http://127.0.0.1:8000/cines/1
http://127.0.0.1:8000/cines/2?fecha=2026-08-17
http://127.0.0.1:8000/cines/999
```

El último ejemplo permite revisar la respuesta `404 Cine no encontrado`. Una fecha con un
formato inválido produce la validación `422` de FastAPI.

## Limitación de salas

El esquema de base de datos entregado contiene `cinemas`, `movies` y `showtimes`, pero no
incluye una tabla `rooms` ni una relación entre salas y funciones. Para no alterar el modelo
proporcionado, el endpoint devuelve:

- `rooms`: lista vacía.
- `showtimes`: funciones del cine para la fecha seleccionada.

Implementar salas requeriría crear la entidad correspondiente y relacionarla con
`showtimes`.
