from fastapi import APIRouter
from app.config import settings

router = APIRouter()


@router.get("/")
async def home():
    return {"message": f"Welcome to {settings.APP_NAME}!"}
