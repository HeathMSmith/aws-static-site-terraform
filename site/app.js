(function () {
  // Current year in footer
  const year = document.getElementById("year");
  if (year) year.textContent = String(new Date().getFullYear());

  // Mobile nav toggle
  const toggle = document.querySelector(".nav-toggle");
  const nav = document.querySelector(".nav");

  if (toggle && nav) {
    toggle.addEventListener("click", () => {
      const isOpen = nav.classList.toggle("open");
      toggle.setAttribute("aria-expanded", String(isOpen));
    });

    // Close nav on click
    nav.querySelectorAll("a").forEach((a) => {
      a.addEventListener("click", () => {
        nav.classList.remove("open");
        toggle.setAttribute("aria-expanded", "false");
      });
    });
  }
})();

const GITHUB_USERNAME = "HeathMSmith";

async function loadRepos() {
  try {
    const res = await fetch(
      `https://api.github.com/users/${GITHUB_USERNAME}/repos?per_page=100`,
      {
        headers: {
          Accept: "application/vnd.github.mercy-preview+json"
        }
      }
    );
    const repos = await res.json();

    const container = document.getElementById("repo-grid");

    // Show public portfolio repos that are not already represented
    // in the curated Featured Architectures section.
    const filtered = repos
      .filter(
        repo =>
          repo.topics &&
          repo.topics.includes("portfolio") &&
          !repo.topics.includes("featured")
      )
      .sort(
        (a, b) => new Date(b.updated_at) - new Date(a.updated_at)
      );

    container.innerHTML = filtered.map(repo => {

      const topicsHTML = (repo.topics || [])
        .map(t => `<span class="pill">${t}</span>`)
        .join("");
      return `
        <article class="card">
          <div class="card-top">
            <span class="tag tag-primary">GitHub</span>
            <span class="tag">${repo.language || "Code"}</span>
          </div>

          <h3>${formatRepoName(repo.name)}</h3>

          <p>
            ${repo.description || "No description provided."}
          </p>
            <div class="pill-row">
              ${topicsHTML}
            </div>

          <div class="card-meta">
            <div>
              <div class="meta-k">Last updated</div>
              <div class="meta-v">${formatDate(repo.updated_at)}</div>
            </div>
          </div>

          <div class="card-actions">
            <a class="btn btn-sm" href="${repo.html_url}" target="_blank">
              View Repository
            </a>
          </div>
        </article>
      `;
    }).join("");

  } catch (err) {
    console.error("Error loading repos:", err);
  }
}

// Helpers
function formatRepoName(name) {
  return name
    .replace(/-/g, " ")
    .replace(/\b\w/g, c => c.toUpperCase());
}

function formatDate(dateStr) {
  const date = new Date(dateStr);
  return date.toLocaleDateString();
}

// Run on load
loadRepos();