# BMad hands-on for the product team

A hands-on session for product managers, BAs and UX. You take one capability of a small sample product, the Factor library, from an empty initiative to a capability PRD, its UX and the epic and tickets that development builds from. You run the BMad commands in GitHub Copilot in VS Code.

All emission factor numbers in this repository are invented sample values, not real emission factors.

## The three commands

You run them in order, in the `product` folder. The master PRD and the system spine are given. Everything else you create.

| Step | Command | What it makes | Estimate |
|---|---|---|---|
| 1 | `/bmad-prd` | The capability PRD for the Factor library | 25 min |
| 2 | `/bmad-ux` | `DESIGN.md` and `EXPERIENCE.md`, from a design screenshot | 25 min |
| 3 | `/bmad-ticket` | The initiative, one epic, and tickets 1.1 and 1.2 | 20 min |
| | Orientation and hand-over | | 10 min |

That is 80 minutes. The times are estimates, because live model runs vary. Use whatever is left of your slot for questions.

Who decides: you do. The skills read what exists, ask about the rest and record each decision. `product/TRACK.md` lists the human decision points and gives the exact prompts.

## What is in this repository

| Path | What it is |
|---|---|
| `product/` | The workspace for the session. BMad is already installed and set up. Open this folder in VS Code. |
| `product/TRACK.md` | The demo script: goal, decisions, commands and checks. |
| `reference/handover/` | The finished initiative as the developer workshop receives it. A guide only, see below. |
| `scripts/setup.sh`, `scripts/setup.cmd` | The one-time check before the session. |
| `scripts/check-install.sh` | Confirms your BMad install matches the reference version. |
| `PREWORK.md` | The pre-work message for participants. |

## Rules

- **Open the `product` folder itself** in VS Code (File > Open Folder). Never open the repository root. BMad finds its settings from the folder you open.
- **Use Copilot Chat in Agent mode.**
- **One clone per person.** Your commits use your own git name and email.
- **Do not open `reference/`** as a workspace, and do not ask the assistant to read it while it plans. It is for comparing after you finish, or for copying from if you are stuck.
- Your result will differ from the reference in wording and in how the work is split. Compare the shape and the decisions, not the exact text.

## Before the session (once)

You need git, uv, VS Code with GitHub Copilot Chat and Copilot access. Nothing needs installing in the project: there is no npm step in this repository.

```bash
./scripts/setup.sh
```

On Windows use `scripts\setup.cmd`, or run the script in Git Bash or WSL. It ends with `Ready. Open the product folder in VS Code.`

## How this connects to the developer workshop

The plan ends at ticket 1.1. The developer workshop starts there with `/bmad-build 1.1`, which reads the ticket, its epic, the PRD, the spine and the UX that you create here.

## Where the product track came from

The `product` folder is the product track from the `bmad-workshop` repository, branch `product-workflow`, commit `06e7e3e`. Only the links to the other tracks were changed so that it stands alone.
