const fallbackInventory = {
  daemon: {
    name: "pocketforge-daemon",
    contract_version: "0.1",
    mode: "read-only",
  },
  device_profiles: [
    {
      id: "rog-ally-x",
      name: "ASUS ROG Ally X",
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
  document.getElementById("device-count").textContent = inventory.device_profiles.length;
  document.getElementById("performance-count").textContent = inventory.performance_profiles.length;
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
