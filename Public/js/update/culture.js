export function culture() {
  document.addEventListener("DOMContentLoaded", () => {
    const cultureModal = document.getElementById("culture-modal");
    const cultureForm = document.getElementById("culture-form");
    const modalTitle = cultureModal.querySelector("h2");
    const submitButton = cultureForm.querySelector('button[type="submit"]');
    const cultureIdInput = document.getElementById("culture-id");

    const addCultureBtn = document.getElementById("add-culture-btn");
    addCultureBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter une culture";
      cultureForm.reset();
      cultureIdInput.value = "";
      cultureModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier une culture";
        submitButton.textContent = "Modifier";
        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const nom = row.cells[0].textContent;
        const variete = row.cells[1].textContent;
        const cycle = row.cells[2].textContent;
        const saisonnalite = row.cells[3].textContent;

        cultureIdInput.value = id;
        document.getElementById("culture-nom").value = nom;
        document.getElementById("culture-variete").value = variete;
        document.getElementById("culture-cycle").value = parseInt(cycle);
        document.getElementById("culture-saisonnalite").value = saisonnalite;

        cultureModal.style.display = "block";
      });
    });
  });
}
