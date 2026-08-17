--  Escribe una query que retorne cines que NO tuvieron ninguna función 
-- programada ayer. 

select cin.id_cine, cin.name
from cinemas AS cin
    left join showtimes AS sho 
        on sho.id_cine = cin.id_cine 
        and sho.show_date = CURRENT_DATE - INTERVAL '1 day'
where sho.id_cine is NULL