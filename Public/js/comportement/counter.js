export function animateCounters() {
  const counters = document.querySelectorAll(".widget-content p");

  counters.forEach((counter) => {
    const target = +counter.textContent;
    let count = 0;
    const increment = target / 200;
    const updateCount = () => {
      if (count < target) {
        count += increment;
        counter.textContent = Math.ceil(count);
        requestAnimationFrame(updateCount);
      } else {
        counter.textContent = target;
      }
    };
    updateCount();
  });
}
