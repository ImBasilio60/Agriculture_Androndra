export function recolte() {
  document.addEventListener("DOMContentLoaded", () => {
    const recolteModal = document.getElementById("recolte-modal");
    const recolteForm = document.getElementById("recolte-form");
    const modalTitle = recolteModal.querySelector("h2");
    const submitButton = recolteForm.querySelector('button[type="submit"]');
    const recolteIdInput = document.getElementById("recolte-id");

    const addRecolteBtn = document.getElementById("add-recolte-btn");
    addRecolteBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter une récolte";
      recolteForm.reset();
      recolteIdInput.value = "";
      recolteModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier une récolte";
        submitButton.textContent = "Modifier";
        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const date = row.cells[0].textContent;
        const culture = row.cells[1].textContent;
        const parcelle = row.cells[2].textContent;
        const quantite = row.cells[3].textContent;

        recolteIdInput.value = id;
        document.getElementById("recolte-date").value = date;
        document.getElementById("recolte-culture").value = culture;
        document.getElementById("recolte-parcelle").value = parcelle;
        document.getElementById("recolte-quantite").value = parseInt(quantite);

        recolteModal.style.display = "block";
      });
    });
  });
}
