export function localisation() {
  document.addEventListener("DOMContentLoaded", () => {
    const localisationModal = document.getElementById("localisation-modal");
    const localisationForm = document.getElementById("localisation-form");
    const modalTitle = localisationModal.querySelector("h2");
    const submitButton = localisationForm.querySelector(
      'button[type="submit"]',
    );
    const localisationIdInput = document.getElementById("localisation-id");

    const addLocalisationBtn = document.getElementById("add-localisation-btn");
    addLocalisationBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter une localisation";
      localisationForm.reset();
      localisationIdInput.value = "";
      localisationModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier une localisation";
        submitButton.textContent = "Modifier";
        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const ville = row.cells[0].textContent;
        const latitude = row.cells[1].textContent;
        const longitude = row.cells[2].textContent;

        localisationIdInput.value = id;
        document.getElementById("localisation-ville").value = ville;
        document.getElementById("localisation-latitude").value =
          parseFloat(latitude);
        document.getElementById("localisation-longitude").value =
          parseFloat(longitude);

        localisationModal.style.display = "block";
      });
    });
  });
}
