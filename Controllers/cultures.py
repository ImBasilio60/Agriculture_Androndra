# Fichier : Controllers/cultures.py
import urllib.parse
from pathlib import Path
from Models.culture import Culture

class CulturesController:

    @staticmethod
    async def pageCultures(scope, receive, send):
        assert scope["type"] == "http"

        cultures_data = Culture.get_all()

        html_path = Path("Views/cultures.html")
        html_content = html_path.read_text("utf-8")
        table_rows = ""
        for culture in cultures_data:
            table_rows += f"""
                        <tr>
                            <td>{culture['nom_culture']}</td>
                            <td>{culture['variete_culture']}</td>
                            <td>{culture['cycle_culture']}</td>
                            <td>{culture['saisonnalite_culture']}</td>
                            <td>
                                <button class="action-btn edit-btn" data-id="{culture['ID_culture']}" data-type="culture">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="action-btn delete-btn" data-id="{culture['ID_culture']}" data-type="culture">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </td>
                        </tr>
                        """

        final_html = html_content.replace("{{ table_rows }}", table_rows)

        await send(
            {
                "type": "http.response.start",
                "status": 200,
                "headers": [(b"content-type", b"text/html; charset=utf-8")],
            }
        )
        await send({"type": "http.response.body", "body": final_html.encode("utf-8")})

    @staticmethod
    async def opInsert(scope, receive, send):
        try:
            body_bytes = b''
            while True:
                message = await receive()
                body_bytes += message.get('body', b'')
                if not message.get('more_body', False):
                    break

            body_str = body_bytes.decode("utf-8")
            form_data = urllib.parse.parse_qs(body_str)

            new_culture_data = {
                "nom_culture": form_data.get("nom_culture")[0],
                "variete_culture": form_data.get("variete_culture")[0],
                "cycle_culture": int(form_data.get("cycle_culture")[0]),
                "saisonnalite_culture": form_data.get("saisonnalite_culture")[0],
            }

            Culture.add(new_culture_data)

            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/cultures")],
                }
            )
            await send({"type": "http.response.body", "body": b""})

        except Exception as e:
            print(f"Erreur dans opInsert : {e}")
            await send(
                {
                    "type": "http.response.start",
                    "status": 500,
                    "headers": [(b"content-type", b"text/plain")],
                }
            )
            await send({"type": "http.response.body", "body": f"Erreur interne du serveur: {e}".encode("utf-8")})

    @staticmethod
    async def opUpdate(scope, receive, send):
        try:
            body_bytes = b''
            while True:
                message = await receive()
                body_bytes += message.get('body', b'')
                if not message.get('more_body', False):
                    break

            body_str = body_bytes.decode("utf-8")
            form_data = urllib.parse.parse_qs(body_str)

            new_culture_data = {
                "ID_culture": form_data.get("id_culture")[0],
                "nom_culture": form_data.get("nom_culture")[0],
                "variete_culture": form_data.get("variete_culture")[0],
                "cycle_culture": int(form_data.get("cycle_culture")[0]),
                "saisonnalite_culture": form_data.get("saisonnalite_culture")[0],
            }

            print(new_culture_data)
            Culture.update(new_culture_data)

            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/cultures")],
                }
            )
            await send({"type": "http.response.body", "body": b""})

        except Exception as e:
            print(f"Erreur dans opUpdate : {e}")
            await send(
                {
                    "type": "http.response.start",
                    "status": 500,
                    "headers": [(b"content-type", b"text/plain")],
                }
            )
            await send({"type": "http.response.body", "body": f"Erreur interne du serveur: {e}".encode("utf-8")})



