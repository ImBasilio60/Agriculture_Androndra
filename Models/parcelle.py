# Fichier : Models/parcelle.py

from Models.model import Model

class Parcelle(Model):
    def __init__(self, id_parcelle, nom_parcelle, superficie_parcelle, type_sol, id_terrain, disponible):
        self.id_parcelle = id_parcelle
        self.nom_parcelle = nom_parcelle
        self.superficie_parcelle = superficie_parcelle
        self.type_sol = type_sol
        self.id_terrain = id_terrain
        self.disponible = disponible
