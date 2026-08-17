import { useState } from 'react'
import './App.css'
import { WeekSelector } from './components/WeekSelector'

function App() {
  const [selectedWeek, setSelectedWeek] = useState<number | null>(null)

  return (
    <main className="card">
      <p className="eyebrow">Componente con fetch y estado </p>
      <h1>Selector de semanas</h1>
      <p className="description">Selecciona una semana asignada del año 2025.</p>

      <WeekSelector year={2025} onWeekSelect={setSelectedWeek} />

      {selectedWeek !== null && (
        <p className="selection">ID seleccionado: {selectedWeek}</p>
      )}
    </main>
  )
}

export default App
