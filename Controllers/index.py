# Fichier : Controllers/index.py

from Models.parcelle import Parcelle
from Models.culture import Culture
from Models.plantation import Plantation
from pathlib import Path


class IndexController:
    @staticmethod
    async def pageIndex(scope, receive, send):
        assert scope["type"] == "http"

        nombre_parcelles = Parcelle.count_all()
        nombre_cultures = Culture.count_all()
        nombre_plantations = Plantation.count_all()

        html_path = Path("Views/index.html")
        html_content = html_path.read_text("utf-8")

        final_html = html_content.replace("{{ nombre_parcelles }}", str(nombre_parcelles))
        final_html = final_html.replace("{{ nombre_cultures }}", str(nombre_cultures))
        final_html = final_html.replace("{{ nombre_plantations }}", str(nombre_plantations))

        await send(
            {
                "type": "http.response.start",
                "status": 200,
                "headers": [(b"content-type", b"text/html; charset=utf-8")],
            }
        )
        await send({"type": "http.response.body", "body": final_html.encode("utf-8")})