const fallbackInventory = {
  daemon: {
    name: "pocketforge-daemon",
    contract_version: "0.2",
    mode: "read-only",
  },
  detection: {
    system: {
      sys_vendor: "",
      product_name: "",
      product_version: "",
      board_name: "",
    },
    current_device: {
      matched: false,
      id: "unknown",
      name: "Unknown device",
      matched_on: "none",
    },
  },
  device_profiles: [
    {
      id: "legion-go",
      name: "Lenovo Legion Go",
    },
    {
      id: "rog-ally-x",
      name: "ASUS ROG Ally X",
    },
    {
      id: "rog-ally",
      name: "ASUS ROG Ally",
    },
    {
      id: "steam-deck-lcd",
      name: "Steam Deck LCD",
    },
    {
      id: "steam-deck-oled",
      name: "Steam Deck OLED",
    },
  ],
  performance_profiles: [
    {
      id: "balanced",
      name: "Balanced",
    },
    {
      id: "battery-saver",
      name: "Battery Saver",
    },
  ],
};

function profileItem(profile) {
  const item = document.createElement("article");
  item.className = "profile-item";

  const dot = document.createElement("span");
  dot.className = "profile-dot";
  dot.setAttribute("aria-hidden", "true");

  const body = document.createElement("div");
  const name = document.createElement("strong");
  const id = document.createElement("code");

  name.textContent = profile.name;
  id.textContent = profile.id;

  body.append(name, id);
  item.append(dot, body);
  return item;
}

function renderProfiles(id, profiles) {
  const target = document.getElementById(id);
  target.replaceChildren();

  for (const profile of profiles) {
    target.append(profileItem(profile));
  }
}

function renderInventory(inventory) {
  const currentDevice = inventory.detection?.current_device ?? fallbackInventory.detection.current_device;

  document.getElementById("device-count").textContent = inventory.device_profiles.length;
  document.getElementById("performance-count").textContent = inventory.performance_profiles.length;
  document.getElementById("detected-device").textContent = currentDevice.name;
  document.getElementById("daemon-mode").textContent = inventory.daemon.mode;
  document.getElementById("contract-version").textContent = inventory.daemon.contract_version;
  document.getElementById("daemon-name").textContent = inventory.daemon.name;
  document.getElementById("inventory-json").textContent = JSON.stringify(inventory, null, 2);

  renderProfiles("device-profiles", inventory.device_profiles);
  renderProfiles("performance-profiles", inventory.performance_profiles);

  const status = document.getElementById("contract-status");
  status.classList.remove("error");
  status.textContent = "Contract Loaded";
}

async function loadInventory() {
  try {
    const response = await fetch("./sample-inventory.json", { cache: "no-store" });
    if (!response.ok) {
      throw new Error(`inventory request failed: ${response.status}`);
    }
    return await response.json();
  } catch {
    return fallbackInventory;
  }
}

loadInventory()
  .then(renderInventory)
  .catch((error) => {
    const status = document.getElementById("contract-status");
    status.classList.add("error");
    status.textContent = "Contract Error";
    document.getElementById("inventory-json").textContent = error.message;
  });

// Nav: highlight the section closest to the top of the viewport on scroll.
function updateActiveNav() {
  const sections = ["overview", "profiles", "system"];
  const links = document.querySelectorAll("nav a");

  let activeId = sections[0];
  for (const id of sections) {
    const el = document.getElementById(id);
    if (el && el.getBoundingClientRect().top <= 80) {
      activeId = id;
    }
  }

  for (const link of links) {
    const href = link.getAttribute("href");
    link.classList.toggle("active", href === `#${activeId}`);
  }
}

document.addEventListener("scroll", updateActiveNav, { passive: true });
updateActiveNav();
