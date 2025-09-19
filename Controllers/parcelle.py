# Fichier : Controllers/parcelle.py
import urllib.parse
from pathlib import Path
from Models.parcelle import Parcelle


class ParcelleController:

    @staticmethod
    async def pageParcelles(scope, receive, send):
        assert scope["type"] == "http"

        parcelles_data = Parcelle.get_all()

        html_path = Path("Views/parcelles.html")
        html_content = html_path.read_text("utf-8")
        table_rows = ""
        for parcelle in parcelles_data:
            table_rows += f"""
                        <tr>
                            <td>{parcelle['nom_parcelle']}</td>
                            <td>{parcelle['superficie_parcelle']}</td>
                            <td>{parcelle['type_sol']}</td>
                            <td>
                                <button class="action-btn edit-btn" data-id="{parcelle['ID_parcelle']}" data-type="parcelle">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="action-btn delete-btn" data-id="{parcelle['ID_parcelle']}" data-type="parcelle">
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

            new_parcelle_data = {
                "nom_parcelle": form_data.get("nom_parcelle")[0],
                "superficie_parcelle": float(form_data.get("superficie_parcelle")[0]),
                "type_sol": form_data.get("type_sol")[0],
                "ID_terrain": 8,
                "disponible": 1,
            }

            Parcelle.add(new_parcelle_data)

            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/parcelles")],
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

            updated_parcelle_data = {
                "ID_parcelle": form_data.get("id_parcelle")[0],
                "nom_parcelle": form_data.get("nom_parcelle")[0],
                "superficie_parcelle": float(form_data.get("superficie_parcelle")[0]),
                "type_sol": form_data.get("type_sol")[0],
                "ID_terrain": 8,
                "disponible": 1,
            }

            Parcelle.update(updated_parcelle_data)

            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/parcelles")],
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