# Fichier : Controllers/index.py

from pathlib import Path

class IndexController:

    @staticmethod
    async def pageIndex(scope, receive, send):
        assert scope["type"] == "http"

        html_path = Path("Views/index.html")
        body = html_path.read_bytes()

        await send(
            {
                "type": "http.response.start",
                "status": 200,
                "headers": [(b"content-type", b"text/html; charset=utf-8")],
            }
        )
        await send({"type": "http.response.body", "body": body})