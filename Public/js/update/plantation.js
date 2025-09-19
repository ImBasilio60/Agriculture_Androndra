export function plantation() {
  document.addEventListener("DOMContentLoaded", () => {
    const plantationModal = document.getElementById("plantation-modal");
    const plantationForm = document.getElementById("plantation-form");
    const modalTitle = plantationModal.querySelector("h2");
    const submitButton = plantationForm.querySelector('button[type="submit"]');
    const plantationIdInput = document.getElementById("plantation-id");

    const addPlantationBtn = document.getElementById("add-plantation-btn");
    addPlantationBtn.addEventListener("click", () => {
      modalTitle.textContent = "Ajouter une plantation";
      submitButton.textContent = "Enregistrer";
      plantationForm.reset();
      plantationIdInput.value = "";
      plantationForm.setAttribute("action", "/plantations/add");
      plantationModal.style.display = "block";
    });

    document.querySelectorAll(".edit-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        modalTitle.textContent = "Modifier une plantation";
        submitButton.textContent = "Modifier";
        const row = event.target.closest("tr");
        const id = button.dataset.id;
        const date = row.cells[0].textContent;
        const methode = row.cells[3].textContent;
        const quantite = row.cells[4].textContent.split(" ")[0]; // Récupérer la quantité seule
        const parcelleNom = row.cells[1].textContent;
        const cultureNom = row.cells[2].textContent;

        // Trouver l'ID de la parcelle et de la culture à partir de leur nom (nécessite une requête supplémentaire si les données ne sont pas dans le DOM)
        // Pour l'instant, on suppose que les options existent déjà dans le select et on cherche la bonne
        const parcelleSelect = document.getElementById("plantation-parcelle");
        const cultureSelect = document.getElementById("plantation-culture");

        let parcelleId = null;
        for (const option of parcelleSelect.options) {
          if (option.textContent.includes(parcelleNom)) {
            parcelleId = option.value;
            break;
          }
        }

        let cultureId = null;
        for (const option of cultureSelect.options) {
          if (option.textContent.includes(cultureNom)) {
            cultureId = option.value;
            break;
          }
        }

        plantationIdInput.value = id;
        document.getElementById("plantation-date").value = date;
        document.getElementById("plantation-methode").value = methode;
        document.getElementById("plantation-quantite").value =
          parseFloat(quantite);
        if (parcelleId) {
          parcelleSelect.value = parcelleId;
        }
        if (cultureId) {
          cultureSelect.value = cultureId;
        }

        plantationForm.setAttribute("action", "/plantations/update");
        plantationModal.style.display = "block";
      });
    });

    plantationModal
      .querySelector(".close-btn")
      .addEventListener("click", () => {
        plantationModal.style.display = "none";
      });

    window.addEventListener("click", (event) => {
      if (event.target === plantationModal) {
        plantationModal.style.display = "none";
      }
    });
  });
}
