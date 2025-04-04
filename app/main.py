from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from starlette.middleware.sessions import SessionMiddleware

from app.api.router import router as api_router
from app.config import settings


def get_application() -> FastAPI:
    settings.configure_logging()

    application = FastAPI(**settings.app_args)
    application.add_middleware(
        CORSMiddleware,
        allow_origins=settings.ALLOWED_HOSTS,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    application.include_router(api_router, prefix=settings.API_PREFIX)
    application.add_middleware(SessionMiddleware, secret_key=settings.SESSION_SECRET_KEY)

    return application


app = get_application()
