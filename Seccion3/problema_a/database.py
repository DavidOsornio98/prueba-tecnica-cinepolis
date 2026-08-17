import psycopg


def get_connection():
    return psycopg.connect(
        host="localhost",
        port=5432,
        dbname="prueba_cinepolis_david",
        user="postgres",
        password="mysecretpassword"
    )