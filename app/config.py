import os, sys, logging
from typing import List
from loguru import logger
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent
app_log_path = os.path.join(BASE_DIR, "logs", "application.log")
if os.path.exists(app_log_path):
    initial_log_id = logger.add(app_log_path, level=logging.INFO, rotation="500 MB", retention=10)


class AppSettings:
    APP_NAME = "Cloud Companion"
    DESCRIPTION: str = "Cloud Companion - Your Friendly Guide to the Cloud"
    VERSION: str = "0.1.0"
    API_PREFIX: str = "/api"

    DEBUG: bool = bool(int(os.getenv("DEBUG", "0")))
    SESSION_SECRET_KEY: str = os.getenv("SESSION_SECRET_KEY", "")

    LOG_LEVEL: str = os.getenv("LOG_LEVEL", "INFO")
    LOG_FILE: str = os.getenv("LOG_FILE", "")
    LOG_ERROR_FILE: str = os.getenv("LOG_ERROR_FILE", "")

    ALLOWED_HOSTS: List[str] = os.getenv("ALLOWED_HOSTS", "*").split(",")

    def configure_logging(self):
        logger.remove(initial_log_id)

        if self.LOG_ERROR_FILE:
            logger.add(
                Path(self.LOG_ERROR_FILE), level=logging.ERROR, rotation="100 MB", retention=10
            )
        if self.LOG_FILE:
            logger.add(Path(self.LOG_FILE), level=logging.ERROR, rotation="500 MB", retention=10)
        else:
            logger.configure(handlers=[{"sink": sys.stderr, "level": logging.INFO}])

    @property
    def app_args(self):
        return {"title": self.APP_NAME, "version": self.VERSION, "debug": self.DEBUG}


settings = AppSettings()
