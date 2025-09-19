import { modal } from "./modal.js";
import { search } from "./search.js";
import { delete_modal } from "./delete_modal.js";
import { animateCounters } from "./counter.js";

export default function parcelle() {
  modal();
  search();
  delete_modal();
  animateCounters();
}
