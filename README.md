# maxmilo - Contrôleur ESPHome pour Climatiseurs Mitsubishi

Ce projet vous permet de contrôler votre unité CVC Mitsubishi (avec un port CN105) en utilisant un ESP8266 (ESP-01) et ESPHome. Il est basé sur l'excellent travail de [echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome).

Il offre une interface moderne via Home Assistant ou un navigateur web, et dispose d'un portail captif pour une configuration WiFi facile.

[🇬🇧 Read the English version here](README_EN.md)

<p align="center">
  <img src="images/assembled_unit.jpg" alt="maxmilo Unit" width="300" />
  <img src="images/ha_dashboard.jpg" alt="Home Assistant Dashboard" width="300" />
</p>

## 🚀 Fonctionnalités

- **Portail Captif WiFi :** Connectez-vous au point d'accès du module pour configurer votre réseau local.
- **Interface Web Standalone :** Contrôlez votre climatisation directement depuis votre smartphone.
- **Intégration Home Assistant :** Découverte automatique via l'API Native.
- **Matériel Open Source :** Composants simples et abordables.

## 🛠 Matériel Requis

Pour fabriquer ce contrôleur, vous aurez besoin de :

1.  **Module ESP8266 ESP-01**
2.  **Adaptateur Série WiFi ESP-01** (Assure la régulation 5V vers 3.3V et l'adaptation de niveau logique)
3.  **Connecteur JST PAP-05V-S** (Connecteur 5 broches pour le port CN105)
4.  **Boîtier** (Imprimé en 3D ou standard)

### Schéma de câblage (CN105 vers ESP-01)

| Broche CN105 | Fonction | Adaptateur ESP-01 |
| :--- | :--- | :--- |
| 1 | 12V | Non Connecté |
| 2 | GND | GND |
| 3 | 5V | VCC (5V) |
| 4 | TX | RX (GPIO3) |
| 5 | RX | TX (GPIO1) |

> ⚠️ **Attention :** Assurez-vous que votre adaptateur gère bien la conversion de niveau 5V vers 3.3V pour protéger l'ESP-01.

## 💻 Installation

### Option A : Installateur Web (Recommandé)
Flashez votre ESP-01 directement depuis votre navigateur (Chrome/Edge) sans rien installer !
👉 **[Cliquez ici pour utiliser l'Installateur Web maxmilo](https://zefr0g.github.io/maxmilo/web_installer/)**

### Option B : Installation Manuelle (CLI)
Si vous préférez compiler vous-même :

#### 1. Installer ESPHome
Si vous ne l'avez pas déjà fait :
```bash
pip install esphome
```

### 2. Flasher le Firmware
Connectez votre ESP-01 à votre ordinateur et lancez :
```bash
esphome run example.yaml
```

### 3. Configuration WiFi
1. Une fois flashé et alimenté, l'appareil créera un point d'accès nommé `Mon HVAC Setup` (ou le nom choisi).
2. Connectez-vous avec votre smartphone.
3. Un portail s'ouvrira automatiquement. Sélectionnez votre WiFi et entrez le mot de passe.

## 📂 Structure du Projet

- `common/`: Fichiers de configuration ESPHome modulaires.
- `hardware/`: Fichiers de conception (SCAD) et boîtiers.
- `example.yaml`: Modèle de configuration pour votre unité.

## 💰 Acheter un Kit
Vous ne voulez pas sourcer les pièces vous-même ? [Ouvrez une Issue sur GitHub](https://github.com/zefr0g/maxmilo/issues) pour commander un kit prêt à l'emploi (10€).
