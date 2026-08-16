def validate_showtime(start_time: str, duration_min: int, opening: str, closing: str) -> dict:
    # Args:
    #     start_time: "14:30" (HH:MM)
    #     duration_min: 120
    #     opening: "10:00"
    #     closing: "23:00"
    # Returns:
    #     {"valid": True} o {"valid": False, "reason": "..."}
    # Reglas:
    #     - La función no puede empezar antes de opening
    #     - La función debe TERMINAR antes de closing
    #     - duration_min incluye 15 min de créditos finales (ya incluidos)
    start_hour, start_minute = map(int, start_time.split(':'))
    opening_hour, opening_minute = map(int, opening.split(':'))
    closing_hour, closing_minute = map(int, closing.split(':'))

    start_total_min = start_hour * 60 + start_minute
    opening_total_min = opening_hour * 60 + opening_minute
    closing_total_min = closing_hour * 60 + closing_minute
    end_total_min = start_total_min + duration_min

    if start_total_min < opening_total_min:
        return {"valid": False, "reason": "La función empieza antes de la hora de apertura"}
    if end_total_min > closing_total_min:
        return {"valid": False, "reason": "La función termina después de la hora de cierre"}
    return {"valid": True}

print(validate_showtime("14:30", 120, "10:00", "23:00"))
print(validate_showtime("00:30", 120, "10:00", "23:00")) 
print(validate_showtime("14:30", 120, "10:00", "15:00"))  # {"valid": True}