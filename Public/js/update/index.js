import { parcelle } from "./parcelle.js";
import { intrant } from "./intrant.js";
import { culture } from "./culture.js";
import { recolte } from "./recolte.js";
import { suivi } from "./suivi.js";
import { localisation } from "./localisation.js";

export default function update() {
  const body = document.body;
  switch (body.className) {
    case "parcelles-page":
      parcelle();
      break;
    case "localisations-page":
      localisation();
      break;
    case "intrants-page":
      intrant();
      break;
    case "cultures-page":
      culture();
      break;
    case "suivis-page":
      suivi();
      break;
    case "recoltes-page":
      recolte();
      break;
  }
}
