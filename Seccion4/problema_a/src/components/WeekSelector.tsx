import { useEffect, useState } from 'react'

interface Week {
  id_week: number
  week_number: number
  init_date: string
  end_date: string
  movies_count: number
}

interface WeeksResponse {
  data: Week[]
}

interface WeekSelectorProps {
  year: number
  onWeekSelect: (idWeek: number) => void
}

const MONTHS = [
  'Ene',
  'Feb',
  'Mar',
  'Abr',
  'May',
  'Jun',
  'Jul',
  'Ago',
  'Sep',
  'Oct',
  'Nov',
  'Dic',
]

function formatDate(date: string): string {
  const [, month, day] = date.split('-').map(Number)

  return `${String(day).padStart(2, '0')} ${MONTHS[month - 1]}`
}

export function WeekSelector({ year, onWeekSelect }: WeekSelectorProps) {
  const [weeks, setWeeks] = useState<Week[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState(false)

  useEffect(() => {
    const controller = new AbortController()

    async function loadWeeks() {
      setIsLoading(true)
      setError(false)

      try {
        const response = await fetch(
          `/api/v1/weeks?year=${encodeURIComponent(year)}&status=assigned`,
          { signal: controller.signal },
        )

        if (!response.ok) {
          throw new Error(`HTTP error ${response.status}`)
        }

        const result: WeeksResponse = await response.json()
        setWeeks(result.data)
      } catch {
        if (!controller.signal.aborted) {
          setError(true)
        }
      } finally {
        if (!controller.signal.aborted) {
          setIsLoading(false)
        }
      }
    }

    void loadWeeks()

    return () => controller.abort()
  }, [year])

  if (isLoading) {
    return <p>Cargando...</p>
  }

  if (error) {
    return <p role="alert">Error al cargar semanas</p>
  }

  return (
    <select
      defaultValue=""
      aria-label="Seleccionar semana"
      onChange={(event) => onWeekSelect(Number(event.target.value))}
    >
      <option value="" disabled>
        Selecciona una semana
      </option>
      {weeks.map((week) => (
        <option key={week.id_week} value={week.id_week}>
          Semana {week.week_number} ({formatDate(week.init_date)} -{' '}
          {formatDate(week.end_date)})
        </option>
      ))}
    </select>
  )
}
