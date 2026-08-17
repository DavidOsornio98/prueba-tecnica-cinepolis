from datetime import date
from fastapi import APIRouter, HTTPException
from schemas.cine import CineDetailResponse
from services.cine_service import get_cine_by_id

router = APIRouter(
    prefix="/cines",
    tags=["Cines"]
)


@router.get("/{cine_id}", response_model=CineDetailResponse,
responses={
        404: {
            "description": "El cine solicitado no existe",
            "content": {
                "application/json": {
                    "example": {
                        "detail": "Cine no encontrado"
                    }
                }
            },
        },
        500: {
            "description": "Error interno del servidor",
        },
    },
)
def get_detalles_cine(cine_id: int, fecha: date | None = None):
    selected_date = fecha or date.today()

    cine = get_cine_by_id(cine_id, selected_date)

    if cine is None:
        raise HTTPException(
            status_code=404,
            detail="Cine no encontrado",
        )

    return cine