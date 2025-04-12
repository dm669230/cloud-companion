from fastapi import APIRouter, Depends,Body, Request
from app.config import settings
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from sqlalchemy.orm import Session
from typing import Annotated
from app.utils import utils
from app.api.db import get_db
from app.api import schemas 
from app.api.controller import register_new_user,login
router = APIRouter()


@router.get("/")
async def home():
    return {"message": f"Welcome to {settings.APP_NAME}!"}


@router.post("/login")
def login_fun(form_data:Annotated[OAuth2PasswordRequestForm, Depends()], db:Session=Depends(get_db)):
    response = login(form_data, db)
    return response

@router.post("/registration")
def user_register(new_user_schema:schemas.NewUserRegisterSchema, db:Session=Depends(get_db)):
    response = register_new_user(new_user_schema,db)
    return response