export function suivi() {
  document.addEventListener("DOMContentLoaded", () => {
    const suiviModal = document.getElementById("suivi-modal");
    const suiviForm = document.getElementById("suivi-form");
    const modalTitle = suiviModal.querySelector("h2");
    const submitButton = suiviForm.querySelector('button[type="submit"]');
    const suiviIdInput = document.getElementById("suivi-id");

    const addSuiviBtn = document.getElementById("add-suivi-btn");
    addSuiviBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter un suivi";
      suiviForm.reset();
      suiviIdInput.value = "";
      suiviModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier un suivi";
        submitButton.textContent = "Modifier";
        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const date = row.cells[0].textContent;
        const culture = row.cells[1].textContent;
        const description = row.cells[2].textContent;

        suiviIdInput.value = id;
        document.getElementById("suivi-date").value = date;
        document.getElementById("suivi-culture").value = culture;
        document.getElementById("suivi-description").value = description;

        suiviModal.style.display = "block";
      });
    });
  });
}
