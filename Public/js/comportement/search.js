export function search() {
  document.addEventListener("DOMContentLoaded", () => {
    function setupTableSearch(inputId, tableSelector) {
      const searchInput = document.getElementById(inputId);
      const table = document.querySelector(tableSelector);
      if (!searchInput || !table) {
        console.error(`Élément introuvable : ${inputId} ou ${tableSelector}`);
        return;
      }

      searchInput.addEventListener("keyup", (event) => {
        const searchText = event.target.value.toLowerCase();
        const rows = table.querySelectorAll("tbody tr");

        rows.forEach((row) => {
          let rowText = "";
          row.querySelectorAll("td").forEach((cell) => {
            rowText += cell.textContent.toLowerCase() + " ";
          });

          if (rowText.includes(searchText)) {
            row.style.display = "";
          } else {
            row.style.display = "none";
          }
        });
      });
    }

    if (document.body.classList.contains("parcelles-page")) {
      setupTableSearch("parcelle-search", ".data-table table");
    } else if (document.body.classList.contains("cultures-page")) {
      setupTableSearch("culture-search", ".data-table table");
    } else if (document.body.classList.contains("plantations-page")) {
      setupTableSearch("plantation-search", ".data-table table");
    }
  });
}
