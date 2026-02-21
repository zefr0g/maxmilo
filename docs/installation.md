# Guide d'Installation maxmilo

Félicitations pour votre achat du contrôleur **maxmilo** ! Ce guide vous aidera à installer et configurer votre unité en toute sécurité.

## ⚠️ Sécurité d'abord
*   **Coupez l'alimentation électrique** de votre climatiseur au niveau du disjoncteur avant toute intervention.
*   Ne forcez jamais sur les connecteurs.
*   Si vous n'êtes pas à l'aise, faites appel à un professionnel.

## 🛠 Étape 1 : Accéder au port CN105
1.  Ouvrez le capot avant de votre unité intérieure Mitsubishi.
2.  Localisez le boîtier de commande électrique (généralement à droite).
3.  Retirez les vis du couvercle du boîtier pour accéder à la carte mère.
4.  Cherchez un connecteur rouge à 5 broches marqué **CN105**.

## 🔌 Étape 2 : Branchement
1.  Branchez le connecteur blanc de votre câble maxmilo sur le port rouge **CN105**.
2.  Positionnez le boîtier maxmilo dans un espace libre (il est assez petit pour tenir dans le compartiment câblage).
3.  Refermez le couvercle et le capot de l'unité.

## ⚡ Étape 3 : Mise en route
1.  Rétablissez le courant.
2.  L'unité maxmilo va démarrer et créer un réseau WiFi nommé `Ma Climatisation Setup-xxxxxx`.
3.  Connectez-vous avec votre téléphone et suivez les instructions à l'écran pour connecter l'unité à votre WiFi domestique.

## 📱 Étape 4 : Utilisation
*   **Home Assistant :** L'unité sera automatiquement détectée. Cliquez sur "Configurer".
*   **Navigateur Web :** Accédez à `http://maxmilo-xxxxxx.local` (ou l'adresse IP fournie par votre box) pour contrôler l'unité directement.

---
En cas de problème, ouvrez une issue sur : [https://github.com/zefr0g/maxmilo](https://github.com/zefr0g/maxmilo)
