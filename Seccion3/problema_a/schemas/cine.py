from datetime import date, time
from pydantic import BaseModel


class ShowtimeResponse(BaseModel):
    id: int
    movie_id: int
    movie_title: str
    show_time: time


class RoomResponse(BaseModel):
    id: int
    name: str
    showtimes: list[ShowtimeResponse]


class CineDetailResponse(BaseModel):
    id: int
    name: str
    brand: str
    city: str
    date: date
    rooms: list[RoomResponse]
    showtimes: list[ShowtimeResponse]