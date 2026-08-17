-- ¿Qué índices crearías en la tabla showtimes para optimizar las queries 
-- anteriores? ¿Por qué? 

--Yo agregaria un indice compuesto con show_date e id_cine, ya que en ambas consultas se filtra por show_date y id_cine,
--lo que permitiría una búsqueda más rápida de los registros relevantes.
CREATE INDEX idx_showtimes_cine_date ON showtimes (id_cine, show_date);