export function intrant() {
  document.addEventListener("DOMContentLoaded", () => {
    const intrantModal = document.getElementById("intrant-modal");
    const intrantForm = document.getElementById("intrant-form");
    const modalTitle = intrantModal.querySelector("h2");
    const submitButton = intrantForm.querySelector('button[type="submit"]');
    const intrantIdInput = document.getElementById("intrant-id");

    const addIntrantBtn = document.getElementById("add-intrant-btn");
    addIntrantBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter un intrant";
      intrantForm.reset();
      intrantIdInput.value = "";
      intrantModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier un intrant";
        submitButton.textContent = "Modifier";
        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const nom = row.cells[0].textContent;
        const type = row.cells[1].textContent;
        const fournisseur = row.cells[2].textContent;
        const quantite = row.cells[3].textContent;

        intrantIdInput.value = id;
        document.getElementById("intrant-nom").value = nom;
        document.getElementById("intrant-type").value = type;
        document.getElementById("intrant-fournisseur").value = fournisseur;
        document.getElementById("intrant-quantite").value = quantite;

        intrantModal.style.display = "block";
      });
    });
  });
}
