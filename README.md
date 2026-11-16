# trailhead-lab

Projekt **Salesforce DX do nauki, automatyzacji i dokumentowania pracy w
Trailhead**. Repozytorium jest połączone z Developer Edition orgiem `devorg` i
służy jako bezpieczne laboratorium do ćwiczenia Salesforce Admin, Flow,
Prompt Builder, Apex oraz pracy z metadata przez Salesforce CLI.

To nie jest aplikacja produkcyjna. Każda zmiana ma przede wszystkim pokazywać
proces: wymaganie biznesowe → konfiguracja w Salesforce → test w orgu →
metadata w repozytorium → commit na osobnej gałęzi.

## Zrealizowany zakres

W repozytorium znajduje się konfiguracja wykonana w ramach **Prompt Builder
Templates Superbadge**:

### 1. Tłumaczenie ankiet Fitness

- Prompt Template `Translate Survey Input` (`Translate_Survey_Input`), typu
  **Flex**.
- Wejścia: `Account`, `Contact` i `Fitness`.
- Tłumaczenie pola `Survey Input` na język angielski z limitem odpowiedzi
  odpowiednim dla pola docelowego.
- Record-Triggered Flow `Translate Fitness Survey Input` wywołuje prompt po
  utworzeniu rekordu `Fitness` i zapisuje wynik w `Translated Survey Input`.

### 2. Podsumowanie celów klienta

- Pole Contact `Interest Summary` (`Interest_Summary__c`) typu **Rich Text Area**.
- Prompt Template `Summarize Client Goals` (`Summarize_Client_Goals`), typu
  **Field Generation**.
- Prompt korzysta z całej related listy rekordów `Fitness` i imienia kontaktu.
- Template został podłączony do strony Contact Lightning Record Page w aplikacji
  Tranquil Trails.

### 3. Spersonalizowany email z rekomendacją programu

- Prompt Template `Program Recommendation Email`
  (`Program_Recommendation_Email`), typu **Sales Email**.
- Odbiorcą jest `Contact`, bez Related Object.
- Prompt korzysta z related listy `Recipient.Fitness__r` oraz invocable Apex
  `Prompt_Program_Recommendation_Invocable`.
- Template generuje email z rekomendacją maksymalnie dwóch programów.

### Uprawnienia i metadata

- Profil administratora ma Field-Level Security dla
  `Contact.Interest_Summary__c` z dostępem do odczytu i edycji.
- Metadata Prompt Buildera znajduje się w
  `force-app/main/default/genAiPromptTemplates/`.
- Definicja pola znajduje się w
  `force-app/main/default/objects/Contact/fields/`.
- Definicja profilu znajduje się w `force-app/main/default/profiles/`.

## Środowisko

| Element | Wartość |
| --- | --- |
| Org alias | `devorg` |
| Edition | Developer Edition |
| API | v68.0 |
| Salesforce CLI | Salesforce CLI v2 (`sf`) |
| Node.js | Node 26 |
| Kod źródłowy | `force-app/main/default/*` |

## Codzienny workflow Salesforce CLI

```bash
# Sprawdź połączenie z orgiem
sf org display --target-org devorg

# Pobierz metadata po zmianach wykonanych w Setup
sf project retrieve start --target-org devorg

# Wdróż wybrany katalog metadata do orga
sf project deploy start --target-org devorg --source-dir <path>

# Uruchom testy Apex
sf apex run test --target-org devorg --code-coverage --result-format human --wait 10

# Wykonaj zapytanie SOQL
sf data query --target-org devorg --query "SELECT Id, Name FROM Account LIMIT 5"
```

Zmiany wykonane w interfejsie Salesforce należy pobrać do repozytorium przed
commitem. Nie należy przechowywać w repozytorium haseł, tokenów, pełnych danych
logowania ani danych wrażliwych.

## Workflow Git: branch i Pull Request

`main` służy **tylko do scalania**. Praca odbywa się na osobnej gałęzi, a
użytkownik wykonuje merge Pull Requesta.

```bash
# Utwórz branch od aktualnego main
git switch main
git pull
git switch -c trailhead/nazwa-zmiany

# Sprawdź i zapisz zmianę
git status
git diff
git add <pliki>
git commit -m "trailhead: opis zmiany"

# Opcjonalnie: opublikuj branch i otwórz PR
git push -u origin HEAD
gh pr create --fill
```

Konwencja nazw branchy: `feat/…`, `fix/…`, `chore/…`, `docs/…`,
`trailhead/…`. Commit powinien opisywać jedną logiczną zmianę i mieć maksymalnie
72 znaki.

## Struktura projektu

- `force-app/main/default/classes/` – klasy i testy Apex
- `force-app/main/default/flows/` – automatyzacje Flow
- `force-app/main/default/genAiPromptTemplates/` – Prompt Builder metadata
- `force-app/main/default/objects/` – obiekty i pola
- `force-app/main/default/profiles/` – uprawnienia profili
- `force-app/main/default/lwc/` – komponenty Lightning Web Components
- `scripts/apex/` – skrypty Anonymous Apex
- `scripts/soql/` – zapytania SOQL
- `.opencode/` – lokalne instrukcje i procedury agenta, jeśli są używane

## Cel edukacyjny

Repozytorium pomaga rozwijać praktyczne umiejętności:

- modelowania danych i konfiguracji Salesforce,
- projektowania promptów opartych na danych CRM,
- budowania automatyzacji Record-Triggered Flow,
- integrowania Prompt Buildera z Flow, Lightning Record Pages i emailami,
- nadawania poprawnych uprawnień użytkownikom,
- pracy z Salesforce metadata i wersjonowaniem Git.
