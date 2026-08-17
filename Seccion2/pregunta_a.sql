--  Escribe una query que retorne las 5 películas con mayor porcentaje de 
-- ocupación promedio (tickets_sold / capacity) en la última semana, solo para cines de marca 
-- "VIP".

select mov.*,
	ROUND(
        (sho.tickets_sold::numeric / sho.capacity) * 100,
        2
    ) AS porcentaje_ocupacion
from movies AS mov
    inner join showtimes AS sho on sho.id_movie = mov.id_movie
    inner join cinemas AS cin on cin.id_cine = sho.id_cine
where cin.brand = 'VIP'
	AND sho.show_date >= CURRENT_DATE - INTERVAL '7 days'
	ORDER BY porcentaje_ocupacion DESC
LIMIT 5;