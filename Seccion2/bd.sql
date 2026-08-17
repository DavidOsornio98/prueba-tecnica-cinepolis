-- Ejecutar este script conectado a la base prueba_cinepolis_david.
-- La creación de la base se realiza por separado; consulta el README raíz.

CREATE TABLE cinemas (
id_cine INT PRIMARY KEY,
name VARCHAR(100),
brand VARCHAR(20), -- 'VIP', 'TRAD', 'MICINE'
city VARCHAR(50)
);

CREATE TABLE movies (
id_movie INT PRIMARY KEY,
title VARCHAR(200),
release_date DATE,
distributor VARCHAR(100)
);

CREATE TABLE showtimes (
id INT PRIMARY KEY,
id_cine INT REFERENCES cinemas(id_cine),
id_movie INT REFERENCES movies(id_movie),
show_date DATE,
show_time TIME,
tickets_sold INT,
capacity INT
);

INSERT INTO cinemas (id_cine, name, brand, city)
VALUES
    (1, 'Cinépolis Centro', 'TRAD', 'Morelia'),
    (2, 'Cinépolis Escala Morelia', 'VIP', 'Morelia'),
    (3, 'Cinépolis Las Américas', 'TRAD', 'Morelia'),
    (4, 'Mi Cine Pátzcuaro', 'MICINE', 'Pátzcuaro'),
    (5, 'Cinépolis VIP Las Américas', 'VIP', 'Morelia'),
    (6, 'Cinépolis VIP Plaza Morelia', 'VIP', 'Morelia');



INSERT INTO movies (id_movie, title, release_date, distributor)
VALUES
    (1, 'Superman', '2026-07-10', 'Warner Bros'),
    (2, 'Jurassic World', '2026-07-02', 'Universal Pictures'),
    (3, 'Los 4 Fantásticos', '2026-07-24', 'Disney'),
    (4, 'F1', '2026-06-26', 'Warner Bros'),
    (5, 'Cómo entrenar a tu dragón', '2026-06-12', 'Universal Pictures'),
    (6, 'La Odisea', '2026-07-17', 'Universal Pictures'),
    (7, 'Minecraft', '2026-04-04', 'Warner Bros'),
    (8, 'Lilo y Stitch', '2026-05-22', 'Disney');


INSERT INTO showtimes (
    id,
    id_cine,
    id_movie,
    show_date,
    show_time,
    tickets_sold,
    capacity
)
VALUES
    (1, 1, 1, CURRENT_DATE - 1, '14:30', 85, 120),
    (2, 2, 1, CURRENT_DATE - 1, '18:00', 45, 60),
    (3, 5, 1, CURRENT_DATE - 3, '20:30', 55, 60),
    (4, 6, 1, CURRENT_DATE - 5, '21:00', 48, 60),
    (5, 1, 2, CURRENT_DATE - 1, '13:00', 50, 120),
    (6, 2, 2, CURRENT_DATE - 2, '19:00', 40, 60),
    (7, 5, 2, CURRENT_DATE - 4, '21:00', 45, 60),
    (8, 6, 2, CURRENT_DATE - 6, '18:30', 42, 60),
    (9, 2, 3, CURRENT_DATE - 1, '15:00', 60, 60),
    (10, 5, 3, CURRENT_DATE - 2, '18:00', 58, 60),
    (11, 6, 3, CURRENT_DATE - 5, '20:00', 57, 60),
    (12, 3, 3, CURRENT_DATE - 1, '21:00', 140, 150),
    (13, 2, 4, CURRENT_DATE - 1, '19:30', 30, 60),
    (14, 5, 4, CURRENT_DATE - 3, '22:00', 35, 60),
    (15, 6, 4, CURRENT_DATE - 6, '18:00', 40, 60),
    (16, 3, 4, CURRENT_DATE - 2, '17:00', 130, 150),
    (17, 2, 5, CURRENT_DATE - 2, '12:00', 20, 60),
    (18, 5, 5, CURRENT_DATE - 4, '13:30', 25, 60),
    (19, 6, 5, CURRENT_DATE - 6, '16:00', 30, 60),
    (20, 4, 5, CURRENT_DATE, '17:00', 75, 100),
    (21, 2, 6, CURRENT_DATE - 1, '18:45', 58, 60),
    (22, 5, 6, CURRENT_DATE - 3, '20:30', 55, 60),
    (23, 6, 6, CURRENT_DATE - 5, '21:30', 50, 60),
    (24, 1, 6, CURRENT_DATE - 1, '17:30', 115, 120),
    (25, 2, 7, CURRENT_DATE - 2, '14:00', 38, 60),
    (26, 5, 7, CURRENT_DATE - 4, '17:00', 42, 60),
    (27, 6, 7, CURRENT_DATE - 6, '19:00', 40, 60),
    (28, 2, 8, CURRENT_DATE - 1, '12:30', 48, 60),
    (29, 5, 8, CURRENT_DATE - 3, '15:30', 50, 60),
    (30, 6, 8, CURRENT_DATE - 5, '18:30', 52, 60),
    (31, 2, 1, CURRENT_DATE - 10, '18:00', 60, 60),
    (32, 5, 2, CURRENT_DATE - 15, '19:00', 60, 60),
    (33, 6, 5, CURRENT_DATE - 20, '20:00', 60, 60),
    (34, 1, 1, CURRENT_DATE, '16:00', 70, 120),
    (35, 2, 3, CURRENT_DATE, '19:00', 50, 60),
    (36, 3, 6, CURRENT_DATE, '21:00', 100, 150);
