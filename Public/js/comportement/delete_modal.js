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
        deleteModal.style.display = "block";
      });
    });

    cancelDeleteBtn.addEventListener("click", () => {
      deleteModal.style.display = "none";
      itemToDelete = null;
    });

    confirmDeleteBtn.addEventListener("click", () => {
      if (itemToDelete) {
        itemToDelete.remove();
        deleteModal.style.display = "none";
        itemToDelete = null;
        console.log("Élément supprimé !");
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
