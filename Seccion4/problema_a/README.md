# Problema A: WeekSelector

Componente desarrollado con React y TypeScript que consulta semanas, muestra los estados de
carga y error, y notifica al componente padre cuando el usuario selecciona una semana.

## Requisitos

- Node.js `^20.19.0` o `>=22.12.0`.
- npm.

## Instalación

Desde la raíz del repositorio:

```powershell
cd .\Seccion4\problema_a
npm ci
```

Se recomienda `npm ci` en lugar de `npm install` porque utiliza las versiones exactas de
`package-lock.json`.

## Ejecución

```powershell
npm run dev
```

Abre la dirección mostrada por Vite, normalmente <http://localhost:5173>.

## API simulada

Este ejercicio no depende del servicio FastAPI de la Sección 3. Durante el desarrollo,
`src/main.tsx` habilita un mock local que intercepta la petición:

```http
GET /api/v1/weeks?year=2025&status=assigned
```

La implementación está en `src/common/mockFetch.ts`. Incluye un retraso de tres segundos
para permitir que se observe el estado `Cargando...`.

### Revisar respuesta exitosa

Deja la bandera al inicio de `src/common/mockFetch.ts` en `false`:

```ts
const SHOULD_FAIL = false
```

Al terminar la carga se mostrará el selector de semanas. Al elegir una opción, el componente
ejecuta `onWeekSelect(idWeek)` y la aplicación muestra el identificador seleccionado.

### Revisar respuesta de error

Cambia temporalmente la bandera a `true`:

```ts
const SHOULD_FAIL = true
```

El mock responderá con estado HTTP `500` y el componente mostrará:

```text
Error al cargar semanas
```

Vuelve a colocar la bandera en `false` para recuperar el escenario exitoso. Vite actualizará
la aplicación automáticamente.

## Validaciones

```powershell
npm run lint
npm run build
```

## Aspectos implementados

- Tipado de las semanas y de la respuesta HTTP.
- Consulta cada vez que cambia la propiedad `year`.
- Estados de carga y error.
- Validación de respuestas HTTP no exitosas.
- Cancelación de la petición con `AbortController` al desmontar el componente.
- Formato de fecha solicitado para cada opción.
- Callback tipado con el identificador de la semana seleccionada.
