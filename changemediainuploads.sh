#!/bin/bash

# Fichier cible
FILE="public/miscellaneous/drawings/index.html"

# Ancienne et nouvelle URL
OLD_URL="grosjean1.github.io/media/Drawings"
NEW_URL="grosjean1.github.io/uploads/Drawings"

# Vérifier si le fichier existe
if [ ! -f "$FILE" ]; then
    echo "Le fichier $FILE n'existe pas. Vérifie le chemin."
    exit 1
fi

# Remplacement dans le fichier

sed -i '' "s|$OLD_URL|$NEW_URL|g" public/miscellaneous/Drawings.html
sed -i '' "s|$OLD_URL|$NEW_URL|g" public/miscellaneous/drawings/index.html

echo "Remplacement terminé dans $FILE."
