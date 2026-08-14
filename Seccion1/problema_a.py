showtimes = [
{"movie": "Inside Out 3", "cine": "Perisur", "format": "IMAX", "tickets_sold": 120},
{"movie": "Inside Out 3", "cine": "Perisur", "format": "2D", "tickets_sold": 85},
{"movie": "Inside Out 3", "cine": "Santa Fe", "format": "2D", "tickets_sold": 90},
{"movie": "Deadpool 4", "cine": "Perisur", "format": "3D", "tickets_sold": 200},
{"movie": "Deadpool 4", "cine": "Santa Fe", "format": "IMAX", "tickets_sold": 180},
{"movie": "Moana 3", "cine": "Perisur", "format": "2D", "tickets_sold": 60},
]


def summarize_by_movie(showtimes:list[dict]) -> list[dict]:
    finalList = []
    tempDict = {}

    for showtime in showtimes:
        if showtime["movie"] not in tempDict:
            tempDict.update({showtime["movie"]: {"total_shows": 1, "total_tickets": showtime["tickets_sold"]}})
        else:
            tempDict[showtime["movie"]]["total_shows"] += 1
            tempDict[showtime["movie"]]["total_tickets"] += showtime["tickets_sold"]


    for movie in tempDict:
        finalList.append(
            {
                "movie": movie,
                "total_shows": tempDict[movie]["total_shows"],
                "total_tickets": tempDict[movie]["total_tickets"],
                "avg_tickets": round(tempDict[movie]["total_tickets"] / tempDict[movie]["total_shows"], 2)
            }
        )
    finalList.sort(key=lambda x: x["avg_tickets"], reverse=True)
    
    return finalList

print(summarize_by_movie(showtimes))