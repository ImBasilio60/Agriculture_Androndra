from mysql.connector import connect

class Base(object):
    __instance = None
    def __new__(cls):
        if Base.__instance is None:
            Base.__instance = super().__new__(cls)
        return Base.__instance

    def __init__(self):
        if not hasattr(self, "con"):
            try:
                self.con = connect(
                    host="localhost",
                    user="root",
                    password="",
                    database="agriculture_androndra"
                )
                self.cur = self.con.cursor(dictionary=True)
            except Exception as e:
                print("Erreur de connexion :", e)
                self.con = None
                self.cur = None

    def execute(self, query, params=None):
        try:
            self.cur.execute(query, params or ())
            self.con.commit()
            return self.cur
        except Exception as e:
            print("Erreur SQL :", e)
            return None

    @classmethod
    def close(cls):
        if cls.__instance is not None:
            if getattr(cls.__instance, "cur", None):
                cls.__instance.cur.close()
                cls.__instance.__instance = None
            if getattr(cls.__instance, "con", None):
                cls.__instance.con.close()
                cls.__instance.__instance = None
            cls.__instance = None



