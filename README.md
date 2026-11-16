# trailhead-lab

This is a **Salesforce DX learning, automation, and documentation project**.
It is connected to a Developer Edition org named `devorg` and serves as a safe
laboratory for practicing Salesforce Admin, Flow, Prompt Builder, Apex, and
Salesforce CLI metadata workflows.

This is not a production application. Its purpose is to turn Trailhead
requirements into working Salesforce capabilities and to preserve the resulting
configuration as reusable metadata.

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

- The `Prompt Builder Superbadge Access` permission set grants read and edit
  access to `Contact.Interest_Summary__c` without exporting unrelated profile
  settings.
- Prompt Builder metadata is stored in
  `force-app/main/default/genAiPromptTemplates/`.
- The custom field definition is stored in
  `force-app/main/default/objects/Contact/fields/`.
- Permission set metadata is stored in `force-app/main/default/permissionsets/`.

## Project structure

- `force-app/main/default/classes/` – Apex classes and tests
- `force-app/main/default/flows/` – Flow automation
- `force-app/main/default/genAiPromptTemplates/` – Prompt Builder metadata
- `force-app/main/default/objects/` – objects and fields
- `force-app/main/default/permissionsets/` – focused permission assignments
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
