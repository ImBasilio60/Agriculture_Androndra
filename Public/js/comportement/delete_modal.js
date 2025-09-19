export function delete_modal() {
  document.addEventListener("DOMContentLoaded", () => {
    const deleteModal = document.getElementById("delete-modal");
    const confirmDeleteBtn = document.getElementById("confirm-delete-btn");
    const cancelDeleteBtn = document.getElementById("cancel-delete-btn");
    let itemToDelete = null;

    document.querySelectorAll(".delete-btn").forEach((button) => {
      button.addEventListener("click", (event) => {
        const row = event.target.closest("tr");
        itemToDelete = row;
        itemToDelete.dataset.id = button.dataset.id;
        itemToDelete.dataset.type = button.dataset.type || "culture";
        deleteModal.style.display = "block";
      });
    });

    cancelDeleteBtn.addEventListener("click", () => {
      deleteModal.style.display = "none";
      itemToDelete = null;
    });

    confirmDeleteBtn.addEventListener("click", () => {
      if (itemToDelete) {
        const id = itemToDelete.dataset.id;
        const type = itemToDelete.dataset.type;

        // On envoie les données au serveur
        const data = new URLSearchParams({ id: id, type: type }).toString();

        fetch("/delete", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: data,
        })
          .then((response) => {
            if (response.ok) {
              itemToDelete.remove();
              deleteModal.style.display = "none";
              itemToDelete = null;
              console.log(`Élément ${type} avec ID ${id} supprimé !`);
            } else {
              console.error("Erreur lors de la suppression.");
            }
          })
          .catch((error) => {
            console.error("Erreur réseau:", error);
          });
      }
    });

    window.addEventListener("click", (event) => {
      if (event.target === deleteModal) {
        deleteModal.style.display = "none";
        itemToDelete = null;
      }
    });
  });
}
