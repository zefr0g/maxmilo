# Matériel maxmilo - Liste des Pièces & Assemblage

Ce dossier contient les informations sur les composants physiques et le processus d'assemblage.

[🇬🇧 English version available here](README_EN.md)

## 📦 Liste des Pièces (BOM)

| Qté | Article | Description | Prix Approx. |
| :--- | :--- | :--- | :--- |
| 1 | ESP8266 ESP-01 | Microcontrôleur (Wi-Fi) | ~$2.00 |
| 1 | Adaptateur Série ESP-01 | Régulateur 5V et adaptateur de niveau | ~$1.50 |
| 1 | JST PAP-05V-S | Connecteur 5 broches (pour CN105) | ~$0.50 |
| 1 | Boîtier imprimé 3D | Boîtier pour les modules | (Minimal) |

## 💰 Acheter le Kit

- **Kit DIY :** Tous les composants inclus. Vous assemblez et flashez.
- **Assemblé & Pré-flashé :** Prêt à l'emploi.

### Comment commander
Pour acheter, merci d'**[ouvrir une issue sur GitHub](https://github.com/zefr0g/maxmilo/issues)**.

## 🛠 Instructions d'Assemblage

1.  **Préparer le connecteur :** Sertissez le connecteur PAP-05V-S avec 4 fils (GND, 5V, TX, RX).
2.  **Câblage :**
    - CN105 Pin 2 (GND) -> Adaptateur GND
    - CN105 Pin 3 (5V) -> Adaptateur VCC
    - CN105 Pin 4 (TX) -> Adaptateur RX
    - CN105 Pin 5 (RX) -> Adaptateur TX
3.  **Insérer l'ESP-01 :** Branchez le module dans le socket de l'adaptateur.

## 📂 Fichiers du Boîtier
- `enclosure.scad` : Script OpenSCAD professionnel et rapide.
- `box.stl` : Le corps principal du boîtier.
- `lid.stl` : Le couvercle avec gravure "maxmilo".
