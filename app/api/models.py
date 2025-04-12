from sqlalchemy import Column, Integer, String,PrimaryKeyConstraint, Text, TIMESTAMP,func,  ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from app.api.db import BASE


class UsersModel(BASE):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    cloud_choice = Column(String(50), nullable=False, default="AWS")
    skill_level = Column(String(50), nullable=False, default="Beginner")
    created_at = Column(DateTime, server_default=func.now())
    salt = Column(String(255), nullable=False)
