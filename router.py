# Fichier : router.py

from Controllers.cultures import CulturesController
from Controllers.index import IndexController
from Controllers.main import MainController
from pathlib import Path
import mimetypes
import re

BASE_DIR = Path(__file__).resolve().parent

routes = {
    "/": {"GET": IndexController.pageIndex},
    "/cultures": {"GET": CulturesController.pageCultures},
    "/cultures/add": {"POST": CulturesController.opInsert},
    "/cultures/update": {"POST": CulturesController.opUpdate},
    "/delete": {"POST": MainController.opDelete},
    "/error" : {"GET": MainController.pageError},
}

async def route_request(scope, receive, send):
    path = scope["path"]
    method = scope["method"]

    if path.startswith("/Public/"):
        file_path = BASE_DIR / path.lstrip("/")
        if file_path.is_file():
            content_type, _ = mimetypes.guess_type(str(file_path))
            if content_type is None:
                content_type = "application/octet-stream"

            body = file_path.read_bytes()

            await send(
                {
                    "type": "http.response.start",
                    "status": 200,
                    "headers": [(b"content-type", content_type.encode("utf-8"))],
                }
            )
            await send({"type": "http.response.body", "body": body})
            return

    handler = routes.get(path, {}).get(method)

    if handler:
        await handler(scope, receive, send)
    else:
        await MainController.pageError(scope, receive, send)