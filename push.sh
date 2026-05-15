#!/bin/bash

# Script per automatizzare add, commit e push

# 1. Recupera il nome del branch corrente
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 2. Chiedi il messaggio di commit (se non fornito come argomento)
if [ -z "$1" ]; then
    echo "Inserisci il messaggio di commit:"
    read MESSAGE
else
    MESSAGE="$1"
fi

# Se il messaggio è vuoto, usa un default
if [ -z "$MESSAGE" ]; then
    MESSAGE="Aggiornamento del $(date +'%d/%m/%Y %H:%M:%S')"
fi

echo "--- Inizio sincronizzazione su branch: $BRANCH ---"

# 3. Add di tutte le modifiche
git add .

# 4. Commit
git commit -m "$MESSAGE"

# 5. Push
echo "Invio delle modifiche a GitHub..."
git push origin "$BRANCH"

if [ $? -eq 0 ]; then
    echo "--- Sincronizzazione completata con successo! ---"
else
    echo "--- Errore durante il push. Controlla la tua connessione o credenziali. ---"
fi
