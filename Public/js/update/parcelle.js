export function parcelle() {
  document.addEventListener("DOMContentLoaded", () => {
    const parcelleModal = document.getElementById("parcelle-modal");
    const parcelleForm = document.getElementById("parcelle-form");
    const modalTitle = parcelleModal.querySelector("h2");
    const submitButton = parcelleForm.querySelector('button[type="submit"]');
    const parcelleIdInput = document.getElementById("parcelle-id");

    const addParcelleBtn = document.getElementById("add-parcelle-btn");
    addParcelleBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter une parcelle";
      parcelleForm.reset();
      parcelleIdInput.value = "";
      parcelleModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier une parcelle";
        submitButton.textContent = "Modifier";

        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const nom = row.cells[0].textContent;
        const superficie = row.cells[1].textContent;
        const typeSol = row.cells[2].textContent;

        parcelleIdInput.value = id;
        document.getElementById("parcelle-nom").value = nom;
        document.getElementById("parcelle-superficie").value =
          parseInt(superficie);
        document.getElementById("parcelle-sol").value = typeSol;

        parcelleModal.style.display = "block";
      });
    });
  });
}
