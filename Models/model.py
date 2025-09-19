# Fichier : Models/model.py

from Models.base import Base


class Model:
    def __str__(self):
        chaine = ""
        for attr, value in self.__dict__.items():
            chaine += f"{attr:11s}: {value}\n"
        return chaine

    @classmethod
    def __close(cls):
        base = Base()
        if base.cur:
            base.cur.close()
        if base.con:
            base.con.close()

    @classmethod
    def get_all(cls):
        try:
            base = Base()
            table = cls.__name__.lower()
            query = f"SELECT * FROM {table}"
            base.cur.execute(query)
            list_dict = base.cur.fetchall()
            return list_dict
        except Exception as e:
            print(f"get all value error: {e}")
            return []

    @classmethod
    def get_by_id(cls, id):
        try:
            base = Base()
            table = cls.__name__.lower()
            pk = f"id_{table}"
            query = f"SELECT * FROM {table} WHERE {pk} = %s"
            base.cur.execute(query, (id,))
            return base.cur.fetchone()
        except Exception as e:
            print(f"get single value error: {e}")
            return None

    @classmethod
    def add(cls, data):
        try:
            base = Base()
            table = cls.__name__.lower()
            columns = ", ".join(data.keys())
            placeholders = ", ".join(["%s"] * len(data))
            values = list(data.values())
            query = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"
            base.cur.execute(query, values)
            base.con.commit()
            print(f"Nouvelle entrée ajoutée à la table '{table}'")
            return True
        except Exception as e:
            print(f"Erreur d'ajout de valeur: {e}")
            return False

    @classmethod
    def update(cls, data):
        try:
            base = Base()
            table = cls.__name__.lower()
            pk = f"ID_{table}"
            if pk not in data:
                print(f"Erreur d'update: la clé primaire '{pk}' est manquante.")
                return False
            pk_value = data.pop(pk)
            set_parts = [f"{key} = %s" for key in data.keys()]
            set_clause = ", ".join(set_parts)
            query = f"UPDATE {table} SET {set_clause} WHERE {pk} = %s"
            values = list(data.values())
            values.append(pk_value)
            base.cur.execute(query, values)
            base.con.commit()
            print(f"Ligne mise à jour dans la table '{table}'")
            return True
        except Exception as e:
            print(f"Erreur d'update de valeur: {e}")
            return False

    @classmethod
    def delete(cls, id):
        try:
            base = Base()
            table = cls.__name__.lower()
            pk = f"ID_{table}"
            query = f"DELETE FROM {table} WHERE {pk} = %s"
            base.cur.execute(query, (id,))
            base.con.commit()
        except Exception as e:
            print(f"delete value error: {e}")

    @classmethod
    def read_plantation(cls):
        try:
            base = Base()
            query = "CALL read_plantation()"
            base.cur.execute(query)
            list_dict = base.cur.fetchall()
            base.cur.nextset()
            return list_dict
        except Exception as e:
            print(f"get all available value error: {e}")
            return []

    @classmethod
    def get_all_available(cls):
        try:
            base = Base()
            procedure_name = f"parcelle_disponible"
            query = f"CALL {procedure_name}()"
            base.cur.execute(query)
            list_dict = base.cur.fetchall()
            base.cur.nextset()
            return list_dict
        except Exception as e:
            print(f"get all available value error: {e}")
            return []