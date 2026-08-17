const SHOULD_FAIL = false

const weeks = [
  {
    id_week: 1,
    week_number: 32,
    init_date: '2025-08-04',
    end_date: '2025-08-10',
    movies_count: 12,
  },
  {
    id_week: 2,
    week_number: 33,
    init_date: '2025-08-11',
    end_date: '2025-08-17',
    movies_count: 8,
  },
  {
    id_week: 3,
    week_number: 34,
    init_date: '2025-08-18',
    end_date: '2025-08-24',
    movies_count: 10,
  },
  {
    id_week: 4,
    week_number: 35,
    init_date: '2025-08-25',
    end_date: '2025-08-31',
    movies_count: 15,
  },
]

function wait(milliseconds: number, signal?: AbortSignal): Promise<void> {
  return new Promise((resolve, reject) => {
    const timer = window.setTimeout(resolve, milliseconds)

    signal?.addEventListener(
      'abort',
      () => {
        window.clearTimeout(timer)
        reject(new DOMException('Request aborted', 'AbortError'))
      },
      { once: true },
    )
  })
}

export function enableWeeksApiMock() {
  const originalFetch = window.fetch.bind(window)

  window.fetch = async (input, init) => {
    const rawUrl =
      typeof input === 'string'
        ? input
        : input instanceof URL
          ? input.href
          : input.url
    const url = new URL(rawUrl, window.location.origin)

    if (url.pathname !== '/api/v1/weeks') {
      return originalFetch(input, init)
    }

    const signal = init?.signal ?? (input instanceof Request ? input.signal : undefined)
    
    await wait(3000, signal)

    if (SHOULD_FAIL) {
      return Response.json({ message: 'Mock error' }, { status: 500 })
    }

    return Response.json({ data: weeks })
  }
}
