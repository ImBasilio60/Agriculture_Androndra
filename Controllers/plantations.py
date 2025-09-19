# Fichier : Controllers/plantations.py

import urllib.parse
from pathlib import Path
from Models.plantation import Plantation
from Models.culture import Culture
from Models.parcelle import Parcelle
from Models.unite import Unite

class PlantationsController:

    @staticmethod
    async def pagePlantations(scope, receive, send):
        assert scope["type"] == "http"

        html_path = Path("Views/plantations.html")
        html_content = html_path.read_text("utf-8")
        table_rows = ""

        plantations_data = Plantation.read_plantation()
        cultures_data = Culture.get_all()
        parcelles_data = Parcelle.get_all_available()
        unites_data = Unite.get_all()

        for plantation in plantations_data:
            table_rows += f"""
                                <tr>
                                    <td>{plantation['date_plantation_terre']}</td>
                                    <td>{plantation['nom_parcelle']}</td>
                                    <td>{plantation['nom_culture']}</td>
                                    <td>{plantation['methode_culture']}</td>
                                    <td>{plantation['quantite_plantee']} {plantation['unite']}</td>
                                    <td>
                                        <button class="action-btn edit-btn" data-id="{plantation['ID_plantation']}" data-type="plantation">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn delete-btn" data-id="{plantation['ID_plantation']}" data-type="plantation">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                                """

        culture_options = "".join(
            [f'<option value="{c["ID_culture"]}">{c["nom_culture"]} - {c["variete_culture"]}</option>' for c in
             cultures_data])
        parcelle_options = "".join(
            [f'<option value="{p["ID_parcelle"]}">{p["nom_parcelle"]} ({p["superficie_parcelle"]} m²)</option>' for p in
             parcelles_data])
        unite_options = "".join([f'<option value="{u["ID_unite"]}">{u["unite"]}</option>' for u in unites_data])

        final_html = html_content.replace("{{ table_rows }}", table_rows)
        final_html = final_html.replace("{{ culture_options }}", culture_options)
        final_html = final_html.replace("{{ parcelle_options }}", parcelle_options)
        final_html = final_html.replace("{{ unite_options }}", unite_options)

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

            new_plantation_data = {
                "date_plantation_terre": form_data.get("date_plantation_terre")[0],
                "methode_culture": form_data.get("methode_culture")[0],
                "quantite_plantee": float(form_data.get("quantite_plantee")[0]),
                "ID_unite": int(form_data.get("ID_unite")[0]),
                "ID_culture": int(form_data.get("ID_culture")[0]),
                "ID_parcelle": int(form_data.get("ID_parcelle")[0]),
            }

            Plantation.add(new_plantation_data)

            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/plantations")],
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

            plantation_data = {
                "ID_plantation": int(form_data.get("ID_plantation")[0]),
                "date_plantation_terre": form_data.get("date_plantation_terre")[0],
                "methode_culture": form_data.get("methode_culture")[0],
                "quantite_plantee": float(form_data.get("quantite_plantee")[0]),
                "ID_unite": int(form_data.get("ID_unite")[0]),
                "ID_culture": int(form_data.get("ID_culture")[0]),
                "ID_parcelle": int(form_data.get("ID_parcelle")[0]),
            }

            Plantation.update(plantation_data)

            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/plantations")],
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