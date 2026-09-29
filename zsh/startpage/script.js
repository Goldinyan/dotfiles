document.addEventListener("DOMContentLoaded", () => {
  // Live Clock
  function updateClock() {
    const clockEl = document.getElementById("clock");
    if (!clockEl) return;

    const now = new Date();
    const hours = String(now.getHours()).padStart(2, "0");
    const minutes = String(now.getMinutes()).padStart(2, "0");
    clockEl.textContent = `${hours}:${minutes}`;
  }

  updateClock();
  setInterval(updateClock, 1000);

  // Grids & State
  let extraMode = false;
  const mainGrid = document.getElementById("main-grid");
  const extraGrid = document.getElementById("extra-grid");
  const searchInput = document.getElementById("search-input");

  // Keybindings
  window.addEventListener("keydown", (e) => {
    const isInputFocused = document.activeElement === searchInput;

    if (!isInputFocused) {
      // Toggle mit 'e'
      if (e.key === "e") {
        extraMode = !extraMode;
        mainGrid.classList.toggle("hidden", extraMode);
        extraGrid.classList.toggle("hidden", !extraMode);
        return;
      }

      // Shortcuts: Main Grid
      if (!extraMode) {
        if (e.key === "y") window.location.href = "https://youtube.com";
        if (e.key === "g") window.location.href = "https://github.com";
        if (e.key === "v") window.location.href = "https://vercel.com";
      }

      // Shortcuts: Extra Grid
      if (extraMode) {
        if (e.key === "1") window.location.href = "http://localhost:3000";
        if (e.key === "t")
          window.location.href = "https://tailwindcss.com/docs";
        if (e.key === "f") window.location.href = "https://firebase.google.com";
        if (e.key === "r")
          window.location.href =
            "https://www.raylib.com/cheatsheet/cheatsheet.html";
        if (e.key === "a") window.location.href = "https://wiki.archlinux.org";
        if (e.key === "p") window.location.href = "https://en.cppreference.com";
        if (e.key === "i") window.location.href = "https://lucide.dev";
        if (e.key === "d") window.location.href = "https://discord.com/app";
        if (e.key === "k") window.location.href = "https://tiktok.com";
      }

      // Focus Search
      if (e.key === "/") {
        e.preventDefault();
        searchInput.focus();
      }
    } else if (e.key === "Escape") {
      searchInput.blur();
    }
  });
});
