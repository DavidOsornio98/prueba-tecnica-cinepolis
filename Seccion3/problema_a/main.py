from fastapi import FastAPI
from routers.cines import router as cines_router

app = FastAPI(
    title="Cinépolis API",
    version="1.0.0"
)

app.include_router(cines_router)