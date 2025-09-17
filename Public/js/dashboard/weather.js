export function weather() {
  document.addEventListener("DOMContentLoaded", () => {
    async function fetchWeather(lat, lon) {
      try {
        const weatherRes = await fetch(
          `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&timezone=auto&daily=weathercode,temperature_2m_max,temperature_2m_min`,
        );

        if (!weatherRes.ok) {
          throw new Error("Erreur de réseau ou de serveur");
        }

        const weatherData = await weatherRes.json();

        // Vérification de la présence des données
        if (
          weatherData.daily &&
          weatherData.daily.temperature_2m_max &&
          weatherData.daily.temperature_2m_min
        ) {
          const tempMax = weatherData.daily.temperature_2m_max[0];
          const tempMin = weatherData.daily.temperature_2m_min[0];
          const weatherCode = weatherData.daily.weathercode[0];

          // Mise à jour de l'HTML avec les données météo
          document.getElementById("weather-temp").textContent =
            `Température: ${tempMin}°C - ${tempMax}°C`;
          document.getElementById("weather-description").textContent =
            getWeatherDescription(weatherCode);

          // Mise à jour de l'icône météo
          const iconClass = getWeatherIcon(weatherCode);
          document.getElementById("weather-icon").className = iconClass;
        } else {
          throw new Error("Données météo non valides");
        }
      } catch (err) {
        console.error("Erreur lors de la récupération de la météo:", err);
        document.getElementById("weather-temp").textContent =
          "Météo indisponible";
        document.getElementById("weather-description").textContent = "";
      }
    }

    async function fetchLocationName(lat, lon) {
      try {
        const geoRes = await fetch(
          `https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${lat}&longitude=${lon}&localityLanguage=fr`,
        );
        if (!geoRes.ok) {
          throw new Error("Erreur de réseau pour la géolocalisation inverse");
        }
        const geoData = await geoRes.json();
        const cityName = geoData?.city || "Unknown location";
        document.getElementById("weather-location").textContent = cityName;
      } catch (err) {
        console.error(
          "Erreur lors de la récupération du nom de la ville:",
          err,
        );
        document.getElementById("weather-location").textContent =
          "Nom de lieu inconnu";
      }
    }

    function getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const lat = position.coords.latitude;
            const lon = position.coords.longitude;
            fetchWeather(lat, lon);
            fetchLocationName(lat, lon);
          },
          (error) => {
            console.error("Erreur de géolocalisation:", error);
            document.getElementById("weather-location").textContent =
              "Géolocalisation refusée";
            document.getElementById("weather-temp").textContent = "";
            document.getElementById("weather-description").textContent = "";
          },
        );
      } else {
        document.getElementById("weather-location").textContent =
          "Votre navigateur ne supporte pas la géolocalisation.";
      }
    }

    function getWeatherDescription(code) {
      const descriptions = {
        0: "Ciel clair",
        1: "Principalement dégagé",
        2: "Partiellement nuageux",
        3: "Très nuageux",
        45: "Brouillard",
        48: "Brouillard givrant",
        51: "Bruine légère",
        53: "Bruine modérée",
        55: "Bruine dense",
        56: "Bruine légère et givrante",
        57: "Bruine dense et givrante",
        61: "Pluie légère",
        63: "Pluie modérée",
        65: "Pluie forte",
        66: "Pluie légère et givrante",
        67: "Pluie forte et givrante",
        71: "Chute de neige légère",
        73: "Chute de neige modérée",
        75: "Chute de neige forte",
        77: "Grains de neige",
        80: "Averses de pluie légères",
        81: "Averses de pluie modérées",
        82: "Averses de pluie violentes",
        85: "Averses de neige légères",
        86: "Averses de neige fortes",
        95: "Orage",
        96: "Orage avec grêle légère",
        99: "Orage avec grêle forte",
      };
      return descriptions[code] || "Condition inconnue";
    }

    function getWeatherIcon(code) {
      if (code >= 0 && code <= 3) {
        return "fas fa-cloud-sun"; // Ciel dégagé à nuageux
      } else if (code >= 45 && code <= 48) {
        return "fas fa-smog"; // Brouillard
      } else if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
        return "fas fa-cloud-rain"; // Pluie ou bruine
      } else if (code >= 71 && code <= 77) {
        return "fas fa-snowflake"; // Neige
      } else if (code >= 95 && code <= 99) {
        return "fas fa-bolt"; // Orage
      } else {
        return "fas fa-question"; // Icône par défaut
      }
    }

    getLocation();
  });
}
