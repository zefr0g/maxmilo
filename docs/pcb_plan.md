# Plan de Conception : Carte PCB Personnalisée maxmilo

L'objectif est de remplacer l'empilement actuel (ESP-01 + Adaptateur bleu) par une carte unique, compacte et professionnelle, fabricable à faible coût (ex: JLCPCB, PCBWay).

## 🎯 Objectifs
- **Taille :** Réduire l'encombrement de 50%.
- **Fiabilité :** Éliminer les fils DuPont et les faux contacts.
- **Coût :** Réduire le coût de revient unitaire en commandant des séries assemblées (PCBA).

## 🛠 Spécifications Techniques

### 1. Microcontrôleur : ESP-12F (ESP8266)
- Plus robuste que l'ESP-01.
- Antenne intégrée certifiée.
- Plus de pins disponibles pour de futures extensions (ex: capteur d'humidité).

### 2. Alimentation (Buck Converter ou LDO)
- Entrée : 5V (venant du port CN105).
- Sortie : 3.3V stable pour l'ESP.
- Protection contre les inversions de polarité et les pics de tension.

### 3. Adaptation de Niveau Logique (Level Shifting)
- Le CN105 communique en 5V, l'ESP en 3.3V.
- Utilisation de transistors (BSS138) ou d'un buffer (74LVC245) pour une communication série propre à 2400 bauds.

### 4. Connectique
- Empreinte pour connecteur **JST PH 2.0mm 5-pin** (plus compact et sécurisé que le DuPont).
- Port de programmation (Pads pour sondes ou port USB-C minimaliste pour le debug).

### 5. Composants SMD
- Résistances et condensateurs en boîtier **0603** ou **0805** (faciles à souder ou à faire assembler).
- Régulateur de tension type **AMS1117-3.3** ou **AP2112K**.

## 📅 Étapes du Projet
1.  **Schématique (KiCad) :** Dessiner le circuit en intégrant les composants de protection.
2.  **Routage (PCB) :** Optimiser le placement pour que la carte tienne dans un boîtier encore plus petit.
3.  **Prototypage :** Commander 5 exemplaires pour valider le fonctionnement.
4.  **Production :** Lancer une série de 50 à 100 unités avec assemblage des composants (SMD Assembly).

## 📦 Boîtier futur
Une fois la carte finale prête, le fichier `enclosure.scad` sera mis à jour pour un design "snap-fit" ultra-compact ne nécessitant potentiellement plus de vis.
