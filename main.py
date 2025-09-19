# Fichier : main.py

import uvicorn

from router import route_request

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="127.0.0.1",
        port=8000,
        log_level="info",
        reload=True
    )

async def app(scope, receive, send):
    await route_request(scope, receive, send)