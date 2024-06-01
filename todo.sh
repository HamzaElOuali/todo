#!/bin/bash

# Fonction pour créer une tâche
ajouter_tache() {
    echo "Création d'une nouvelle tâche..."
    read -rp "Entrez le titre : " titre
    titre=$(echo "$titre" | tr -dc '[:alnum:][:space:]')
    if [[ -z "$titre" ]]; then
        echo "Le titre est requis." >&2
        return
    fi

    read -rp "Entrez la date limite (AAAA-MM-JJ) : " date_limite
    if ! [[ "$date_limite" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Format de date limite invalide. Veuillez utiliser AAAA-MM-JJ." >&2
        return
    fi

    read -rp "Entrez la description : " description
    description=$(echo "$description" | tr -dc '[:alnum:][:space:]')
    read -rp "Entrez l'emplacement : " emplacement
    emplacement=$(echo "$emplacement" | tr -dc '[:alnum:][:space:]')
    read -rp "Entrez la priorité (haute/moyenne/basse) : " priorite
    if [[ -z "$priorite" ]]; then
        echo "La priorité est requise." >&2
        return
    fi

    read -rp "La tâche est-elle terminée ? (oui/non) : " completion
    if [[ "$completion" == "oui" ]]; then
        completion=true
    else
        completion=false
    fi

    echo "$titre,$date_limite,$description,$emplacement,$priorite,$completion" >> taches.csv
    echo "Tâche créée avec succès."
}

# Fonction pour mettre à jour une tâche
modifier_tache() {
    echo "Modification d'une tâche..."
    read -rp "Entrez l'ID de la tâche : " id_tache
    if ! [[ "$id_tache" =~ ^[0-9]+$ ]]; then
        echo "ID de tâche invalide." >&2
        return
    fi

    read -rp "Entrez le nouveau titre : " titre
    titre=$(echo "$titre" | tr -dc '[:alnum:][:space:]')
    if [[ -z "$titre" ]]; then
        echo "Le titre est requis." >&2
        return
    fi

    read -rp "Entrez la nouvelle date limite (AAAA-MM-JJ) : " date_limite
    if ! [[ "$date_limite" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Format de date limite invalide. Veuillez utiliser AAAA-MM-JJ." >&2
        return
    fi

    read -rp "Entrez la nouvelle description : " description
    description=$(echo "$description" | tr -dc '[:alnum:][:space:]')
    read -rp "Entrez le nouvel emplacement : " emplacement
    emplacement=$(echo "$emplacement" | tr -dc '[:alnum:][:space:]')
    read -rp "Entrez la nouvelle priorité (haute/moyenne/basse) : " priorite
    if [[ -z "$priorite" ]]; then
        echo "La priorité est requise." >&2
        return
    fi

    read -rp "La tâche est-elle terminée ? (oui/non) : " completion
    if [[ "$completion" == "oui" ]]; then
        completion=true
    else
        completion=false
    fi

    sed -i "${id_tache}s/[^,]*/$(sed 's/[&/\]/\\&/g' <<< "$titre")/1" taches.csv
    sed -i "${id_tache}s/[^,]*/$(sed 's/[&/\]/\\&/g' <<< "$date_limite")/2" taches.csv
    sed -i "${id_tache}s/[^,]*/$(sed 's/[&/\]/\\&/g' <<< "$description")/3" taches.csv
    sed -i "${id_tache}s/[^,]*/$(sed 's/[&/\]/\\&/g' <<< "$emplacement")/4" taches.csv
    sed -i "${id_tache}s/[^,]*/$(sed 's/[&/\]/\\&/g' <<< "$priorite")/5" taches.csv
    sed -i "${id_tache}s/[^,]*/$(sed 's/[&/\]/\\&/g' <<< "$completion")/6" taches.csv
    echo "Tâche modifiée avec succès."
}

# Fonction pour supprimer une tâche
supprimer_tache() {
    echo "Suppression d'une tâche..."
    read -rp "Entrez l'ID de la tâche : " id_tache
    if ! [[ "$id_tache" =~ ^[0-9]+$ ]]; then
        echo "ID de tâche invalide." >&2
        return
    fi

    if [[ ! -f "taches.csv" ]]; then
        echo "Fichier des tâches introuvable." >&2
        return
    fi

    sed -i "${id_tache}d" taches.csv
    echo "Tâche supprimée avec succès."
}

# Fonction pour lister toutes les tâches
lister_taches() {
    echo "Liste de toutes les tâches..."
    awk -F, 'BEGIN { printf "%-8s %-20s %-12s %-30s %-20s %-10s %-10s\n", "ID Tâche", "Titre", "Date Limite", "Description", "Emplacement", "Priorité", "Achèvement" } 
    { printf "%-8s %-20s %-12s %-30s %-20s %-10s %-10s\n", NR, $1, $2, $3, $4, $5, $6 }' taches.csv
}

# Fonction pour rechercher une tâche
rechercher_tache() {
    echo "Recherche d'une tâche..."
    read -rp "Entrez le terme de recherche : " terme_recherche
    awk -F, -v terme_recherche="$terme_recherche" 'BEGIN { printf "%-8s %-20s %-12s %-30s %-20s %-10s %-10s\n", "ID Tâche", "Titre", "Date Limite", "Description", "Emplacement", "Priorité", "Achèvement" } 
    $1 ~ terme_recherche || $2 ~ terme_recherche || $3 ~ terme_recherche || $4 ~ terme_recherche || $5 ~ terme_recherche || $6 ~ terme_recherche { printf "%-8s %-20s %-12s %-30s %-20s %-10s %-10s\n", NR, $1, $2, $3, $4, $5, $6 }' taches.csv
}

# Fonction pour marquer une tâche comme terminée
completer_tache() {
    echo "Marquage d'une tâche comme terminée..."
    read -rp "Entrez l'ID de la tâche : " id_tache
    sed -i "${id_tache}s/[^,]*$/Terminée/" taches.csv
    echo "Tâche marquée comme terminée."
}

# Boucle principale du programme
while true; do
    echo "1. Ajouter une tâche"
    echo "2. Modifier une tâche"
    echo "3. Supprimer une tâche"
    echo "4. Lister toutes les tâches"
    echo "5. Rechercher une tâche"
    echo "6. Marquer une tâche comme terminée"
    echo "7. Quitter"
    read -rp "Entrez votre choix : " choix
    case "$choix" in
        1) ajouter_tache ;;
        2) modifier_tache ;;
        3) supprimer_tache ;;
        4) lister_taches ;;
        5) rechercher_tache ;;
        6) completer_tache ;;
        7) break ;;
        *) echo "Choix invalide." ;;
    esac
done
