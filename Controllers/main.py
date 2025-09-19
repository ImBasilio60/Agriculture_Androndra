from Models.culture import Culture
import urllib.parse
import json

class MainController:
    @staticmethod
    async def opDelete(scope, receive, send):
        try:
            body_bytes= b""
            while True:
                message = await receive()
                body_bytes += message.get("body", b"")
                if not message.get("more_body", False):
                    break

            body_str = body_bytes.decode("utf-8")
            form_data = urllib.parse.parse_qs(body_str)

            item_id = int(form_data.get("id")[0])
            item_type = form_data.get("type")[0]

            model_map = {
                "culture": Culture,
            }

            if item_type in model_map:
                model_class = model_map[item_type]
                model_class.delete(item_id)
                print(f"{item_type.capitalize()} avec ID {item_id} supprimée.")
            else:
                print(f"Erreur : Type d'entité '{item_type}' non géré.")
                await send(
                    {
                        "type": "http.response.start",
                        "status": 400,
                        "headers": [(b"content-type", b"text/plain")],
                    }
                )
                await send({"type": "http.response.body", "body": b"Type d'entite invalide."})
                return
            await send(
                {
                    "type": "http.response.start",
                    "status": 303,
                    "headers": [(b"location", b"/cultures")],  # Rediriger vers la page qui a fait la requête
                }
            )
            await send({"type": "http.response.body", "body": b""})
        except Exception as e:
            print(f"Erreur dans opDelete : {e}")
            await send(
                {
                    "type": "http.response.start",
                    "status": 500,
                    "headers": [(b"content-type", b"text/plain")],
                }
            )
            await send({"type": "http.response.body", "body": f"Erreur interne du serveur: {e}".encode("utf-8")})