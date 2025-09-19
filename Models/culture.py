# Fichier : Models/culture.py

from Models.model import Model

class Culture(Model):
    def __init__(self, id_culture, nom_culture, variete_culture, cycle_culture, saisonnalite_culture):
        self.id_culture = id_culture
        self.nom_culture = nom_culture
        self.variete_culture = variete_culture
        self.cycle_culture = cycle_culture
        self.saisonnalite_culture = saisonnalite_culture

