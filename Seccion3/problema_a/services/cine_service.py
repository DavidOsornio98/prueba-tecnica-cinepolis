from database import get_connection
from datetime import date

def get_cine_by_id(cine_id: int, selected_date: date):
    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT id_cine, name, brand, city
                FROM cinemas
                WHERE id_cine = %s
                """,
                (cine_id,),
            )

            cine = cursor.fetchone()

            if cine is None:
                return None

            cursor.execute(
                """
                SELECT
                    s.id,
                    s.id_movie,
                    m.title,
                    s.show_time
                FROM showtimes AS s
                INNER JOIN movies AS m
                    ON m.id_movie = s.id_movie
                WHERE s.id_cine = %s
                  AND s.show_date = %s
                ORDER BY s.show_time
                """,
                (cine_id, selected_date),
            )

            showtime_rows = cursor.fetchall()

            showtimes = [
                {
                    "id": row[0],
                    "movie_id": row[1],
                    "movie_title": row[2],
                    "show_time": row[3],
                }
                for row in showtime_rows
            ]

            return {
                "id": cine[0],
                "name": cine[1],
                "brand": cine[2],
                "city": cine[3],
                "date": selected_date,
                "rooms": [],
                "showtimes": showtimes,
            }
    finally:
        connection.close()