 @router.post("/movies") 
  async def create_movie(data: dict): 
      movie = Movie( 
          title=data["title"], 
          release_date=data["release_date"], 
          distributor=data["distributor"], 
      ) 
      db.add(movie) 
      db.commit() 
      return movie 


#Los problemas son:
#1. hace falta el await en la función create_movie, en la parte de insertar la pelicula y en hacer commit de la transaccion.
#2. Hace falta la inyeccion de dependencia para la bd ya que no esta declarada internamente en esa funcion.
#3. No existe manejo de excepciones para incluso hacer rollback de la transaccion.
#4. Hace falta validar los datos que se estan ingresando para evitar errores de integridad de datos.