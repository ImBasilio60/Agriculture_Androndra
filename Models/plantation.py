from Models.model import Model

class Plantation(Model):
    def __init__(self, id_plantation, date_plantation_terre, methode_culture, quantite_plantee, id_unite, id_culture, id_parcelle):
        self.id_plantation = id_plantation
        self.date_plantation_terre = date_plantation_terre
        self.methode_culture = methode_culture
        self.quantite_plantee = quantite_plantee
        self.id_unite = id_unite
        self.id_culture = id_culture
        self.id_parcelle = id_parcelle

