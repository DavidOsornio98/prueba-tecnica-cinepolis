// Este componente tiene 4 problemas. Identifícalos:

function MovieList({ cinemaId }) {
    const [movies, setMovies] = useState([]);
    const [search, setSearch] = useState("");

    useEffect(() => {
      fetch(`/api/v1/cines/${cinemaId}/movies`)
        .then(res => res.json())
        .then(data => setMovies(data));
    }, []);

    const filtered = movies.filter(m =>
      m.title.toLowerCase().includes(search)
    );

    return (
      <div>
        <input value={search} onChange={e => setSearch(e.target.value)} />
        {filtered.map(movie => (
          <div>{movie.title} - {movie.format}</div>
        ))}
      </div>
);

// Le hace falta una llave final a la funcion
// no se a importado el useEfect ni useState de la libreria de react
// el use efect solo se ejecuta una vez al renderizar el componente, le hace falta la variable cinemaId para escuchar
// al map le hace falta el key unico