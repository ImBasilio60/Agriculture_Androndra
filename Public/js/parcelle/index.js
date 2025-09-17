export default function parcelle() {
  const modal = document.getElementById("parcelle-modal");
  const addParcelleBtn = document.getElementById("add-parcelle-btn");
  const closeBtn = document.querySelector(".close-btn");

  if (modal && addParcelleBtn && closeBtn) {
    addParcelleBtn.addEventListener("click", () => {
      modal.style.display = "block";
    });

    closeBtn.addEventListener("click", () => {
      modal.style.display = "none";
    });

    window.addEventListener("click", (event) => {
      if (event.target === modal) {
        modal.style.display = "none";
      }
    });
  }
}
