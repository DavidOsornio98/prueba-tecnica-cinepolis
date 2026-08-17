import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { enableWeeksApiMock } from './common/mockFetch.ts'

if (import.meta.env.DEV) {
  enableWeeksApiMock()
}

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
