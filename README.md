# trailhead-lab

Projekt Salesforce DX do nauki i eksperymentów na orgu deweloperskim **lotka corp**.

## Środowisko

| Element | Wartość |
| --- | --- |
| Org (alias) | `devorg` |
| Username | `matmat@lotka.com` |
| Edition | Developer Edition |
| Instance | `https://lotkacorp-dev-ed.develop.my.salesforce.com` |
| API | v68.0 |
| Struktura | `force-app/main/default/*` |

## Codzienny workflow

```bash
# 1. Sprawdź, do czego jesteśmy podłączeni
sf org display --target-org devorg

# 2. Pobierz aktualne metadata z orgu (gdy coś klikasz w Setup)
sf project retrieve start --target-org devorg

# 3. Wypchnij lokalne zmiany na org
sf deploy metadata --target-org devorg

# 4. Uruchom testy Apex
sf apex run test --target-org devorg --code-coverage --result-format human --wait 10

# 5. Zobacz log ostatniego wywołania Apex
sf apex run --target-org devorg --file scripts/apex/hello.apex

# 6. SOQL z pliku
sf data query --target-org devorg --file scripts/soql/account.soql
```

## Workflow git: branch + Pull Request

`main` służy **tylko do scalania**. Bezpośredni push na `main` jest blokowany
hookiem `.githooks/pre-push` (GitHub branch protection nie jest dostępny
na planie Free dla repo prywatnych).

```bash
# 1. świeży branch od main
git switch main && git pull
git switch -c feat/krotki-opis

# 2. praca + commit
git add -A
git commit -m "feat: <co dodane>"

# 3. push brancha i Pull Request
git push -u origin HEAD
gh pr create --fill

# 4. merge przez PR (squash) — dopiero wtedy zmiana trafia na main
gh pr merge --squash --delete-branch
```

Konwencja nazw branchy: `feat/…`, `fix/…`, `chore/…`, `docs/…`.

Hook działa, bo repo ma ustawione `core.hooksPath` na `.githooks` (konfiguracja
lokalna, nie trafia do repo — w nowym klonie trzeba ją ustawić raz):

```bash
git config --local core.hooksPath .githooks
```

## Przydatne katalogi

- `force-app/main/default/classes/` – klasy i testy Apex
- `force-app/main/default/triggers/` – triggery
- `force-app/main/default/objects/` – obiekty niestandardowe (pola, walidacje)
- `force-app/main/default/lwc/` – komponenty Lightning Web Components
- `force-app/main/default/flows/` – automatyzacje Flow
- `scripts/apex/` – snippety do uruchamiania przez CLI
- `scripts/soql/` – zapytania SOQL
