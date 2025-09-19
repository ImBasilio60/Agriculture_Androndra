import { parcelle } from "./parcelle.js";
import { plantation } from "./plantation.js";
import { culture } from "./culture.js";

export default function update() {
  const body = document.body;
  switch (body.className) {
    case "parcelles-page":
      parcelle();
      break;
    case "plantations-page":
      plantation();
      break;
    case "cultures-page":
      culture();
      break;
  }
}
