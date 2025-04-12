from pydantic import BaseModel
from typing import Optional, List, Dict, Union

class NewUserRegisterSchema(BaseModel):
    name: str # required
    email: str # required
    password_hash: str # required
    cloud_choice: Optional[str] = "AWS" # default value
    skill_level: Optional[str] = "Beginner" # default value