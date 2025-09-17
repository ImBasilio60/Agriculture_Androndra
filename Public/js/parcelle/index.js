export default function parcelle() {
  document.addEventListener("DOMContentLoaded", () => {
    function openModal(modalId) {
      const modal = document.getElementById(modalId);
      if (modal) {
        modal.style.display = "block";
      }
    }

    function closeModal(modalElement) {
      if (modalElement) {
        modalElement.style.display = "none";
      }
    }

    document.querySelectorAll("[data-modal-target]").forEach((button) => {
      button.addEventListener("click", () => {
        const modalId = button.getAttribute("data-modal-target");
        openModal(modalId);
      });
    });

    document.querySelectorAll(".modal").forEach((modal) => {
      const closeBtn = modal.querySelector(".close-btn");
      if (closeBtn) {
        closeBtn.addEventListener("click", () => {
          closeModal(modal);
        });
      }
      window.addEventListener("click", (event) => {
        if (event.target === modal) {
          closeModal(modal);
        }
      });
    });
  });
}
