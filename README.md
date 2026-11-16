# trailhead-lab

This is a **Salesforce DX learning, automation, and documentation project**.
It is connected to a Developer Edition org named `devorg` and serves as a safe
laboratory for practicing Salesforce Admin, Flow, Prompt Builder, Apex, and
Salesforce CLI metadata workflows.

This is not a production application. Each change is intended to demonstrate
the complete workflow: business requirement → Salesforce configuration → org
validation → metadata in source control → commit on a dedicated branch.

## Completed work

The repository contains configuration completed as part of the **Prompt Builder
Templates Superbadge**:

### 1. Fitness survey translation

- `Translate Survey Input` (`Translate_Survey_Input`), a **Flex** prompt template.
- Inputs: `Account`, `Contact`, and `Fitness`.
- Translates the `Survey Input` field into English with a response length
  appropriate for the target field.
- The `Translate Fitness Survey Input` record-triggered flow invokes the prompt
  when a `Fitness` record is created and stores the result in `Translated Survey Input`.

### 2. Client goals summary

- `Interest Summary` (`Interest_Summary__c`) on Contact, using the **Rich Text Area** type.
- `Summarize Client Goals` (`Summarize_Client_Goals`), a **Field Generation** prompt template.
- Uses the complete related list of `Fitness` records and the contact's first name.
- The template is connected to the Contact Lightning Record Page in the
  Tranquil Trails app.

### 3. Personalized program recommendation email

- `Program Recommendation Email` (`Program_Recommendation_Email`), a
  **Sales Email** prompt template.
- Uses `Contact` as the recipient and no Related Object.
- Uses the `Recipient.Fitness__r` related list and the invocable Apex class
  `Prompt_Program_Recommendation_Invocable`.
- Generates an email recommending up to two relevant programs.

### Permissions and metadata

- The administrator profile has Field-Level Security for
  `Contact.Interest_Summary__c` with read and edit access.
- Prompt Builder metadata is stored in
  `force-app/main/default/genAiPromptTemplates/`.
- The custom field definition is stored in
  `force-app/main/default/objects/Contact/fields/`.
- Profile metadata is stored in `force-app/main/default/profiles/`.

## Environment

| Item | Value |
| --- | --- |
| Org alias | `devorg` |
| Edition | Developer Edition |
| API | v68.0 |
| Salesforce CLI | Salesforce CLI v2 (`sf`) |
| Node.js | Node 26 |
| Source directory | `force-app/main/default/*` |

## Salesforce CLI workflow

```bash
# Check the connected org
sf org display --target-org devorg

# Retrieve metadata after changes made in Setup
sf project retrieve start --target-org devorg

# Deploy a selected metadata directory to the org
sf project deploy start --target-org devorg --source-dir <path>

# Run Apex tests
sf apex run test --target-org devorg --code-coverage --result-format human --wait 10

# Run a SOQL query
sf data query --target-org devorg --query "SELECT Id, Name FROM Account LIMIT 5"
```

Changes made in the Salesforce UI should be retrieved into the repository before
committing. Passwords, tokens, complete login details, and sensitive data must
never be stored in the repository.

## Git workflow: branches and pull requests

`main` is used **only for merges**. Work is done on a dedicated branch, and the
repository owner performs the Pull Request merge.

```bash
# Create a branch from the current main
git switch main
git pull
git switch -c trailhead/change-name

# Review and commit the change
git status
git diff
git add <files>
git commit -m "trailhead: describe the change"

# Optional: publish the branch and open a PR
git push -u origin HEAD
gh pr create --fill
```

Branch naming convention: `feat/...`, `fix/...`, `chore/...`, `docs/...`, and
`trailhead/...`. Each commit should describe one logical change and be no longer
than 72 characters.

## Project structure

- `force-app/main/default/classes/` – Apex classes and tests
- `force-app/main/default/flows/` – Flow automation
- `force-app/main/default/genAiPromptTemplates/` – Prompt Builder metadata
- `force-app/main/default/objects/` – objects and fields
- `force-app/main/default/profiles/` – profile permissions
- `force-app/main/default/lwc/` – Lightning Web Components
- `scripts/apex/` – Anonymous Apex scripts
- `scripts/soql/` – SOQL queries
- `.opencode/` – local agent instructions and procedures, when used

## Learning goals

This repository supports practical learning in:

- Salesforce data modeling and configuration,
- CRM-grounded prompt design,
- Record-Triggered Flow automation,
- Prompt Builder integration with Flow, Lightning Record Pages, and email,
- user and field-level permissions,
- Salesforce metadata management and Git version control.
