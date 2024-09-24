#!/bin/bash
set -e

pods=$(kubectl get pods --no-headers | awk '{print $1}')

for pod in $pods; do
    echo "Uruchamianie testów w podzie: $pod"
    kubectl exec -it "$pod" -- /app/test.sh

    if [ $? -ne 0 ]; then
        echo "Testy w podzie $pod nie powiodły się!"
        exit 1
    fi
done

echo "Wszystkie testy zakończone pomyślnie!"
