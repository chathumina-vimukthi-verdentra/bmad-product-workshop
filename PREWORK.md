# Pre-work message (copy and send before the session)

**Subject:** BMad hands-on for the product team: 10 minutes of setup beforehand

Hi all,

In the session we use the BMad Method with GitHub Copilot in VS Code. You will plan one capability of a small sample product: write its capability PRD, capture its UX from a design screenshot, and turn both into an epic and tickets that development can build from. All emission factor numbers are invented sample values.

To keep the time for the exercise, please do the one-time setup below beforehand. It takes about 10 minutes.

**What you need**

- [ ] git, with your name and email set (check with `git --version`)
- [ ] uv, a small tool runner that the BMad scripts use (check with `uv --version`). If it is missing, install it with `pip install uv`, or `brew install uv` on a Mac.
- [ ] VS Code with the GitHub Copilot Chat extension, and Copilot access on your account

**What to do**

1. Clone the repository to a short path, for example `C:\bmad-product` on Windows or `~/bmad-product` on Mac and Linux:
   `git clone [repository URL]`
2. Open a terminal in the cloned folder and run the setup check.
   Mac, Linux, Git Bash or WSL: `./scripts/setup.sh`
   Windows, cmd or PowerShell: `scripts\setup.cmd`

**How to know it worked**

The setup check ends with: `Ready. Open the product folder in VS Code.`
If a tool is missing, the script stops and says what to install. Install it, open a new terminal and run the same command again. It is safe to run more than once.

**On the day**

In VS Code use File > Open Folder and choose the `product` folder itself, not the folder above it. Use Copilot Chat in Agent mode. Then read `TRACK.md` in that folder.

**If it fails**

Send a screenshot or the text of the terminal to [Presenter name], at [email or chat handle], before the session if you can.

See you there.
[Presenter name]
