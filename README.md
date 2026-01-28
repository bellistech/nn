# nn - New Note 📝

Note-taking CLI. Daily journals, incident docs, meeting notes — from a terminal.

```bash
nn                          # Open today's journal
nn -a "fixed the auth bug"  # Quick append without opening editor
nn -T incident db-outage    # Incident response template
kubectl get pods | nn -i debug  # Capture command output
nn -y                       # Yesterday's journal
nn --sync                   # Git commit & push
```

## Why nn?

- **Fast** — Notes in milliseconds, not minutes
- **Organized** — Auto-dated folders: `~/journal/2026/01/28/`
- **Templates** — SRE-focused: incidents, postmortems, runbooks, oncall handoffs
- **Git-friendly** — Built-in sync, YAML frontmatter for tooling
- **Zero dependencies** — Pure bash, works everywhere

## Install

```bash
# Download
curl -fsSL https://raw.githubusercontent.com/bellistech/nn/main/nn -o ~/.local/bin/nn
chmod +x ~/.local/bin/nn

# Or clone
git clone https://github.com/bellistech/nn.git
cp nn/nn ~/.local/bin/

# Add completions (optional)
echo 'eval "$(nn --completions)"' >> ~/.bashrc
```

Requires: `bash 4+`, `find`, `date`, `grep`  
Optional: `fzf` (fuzzy finder), `rg` (faster search), `tree` (directory view), `git` (sync)

## Documentation

```bash
nn --help      # Quick reference
man nn         # Full manual (after install)
nn -m          # Markdown cheat sheet
```

## Quick Start

```bash
# Daily journaling
nn                    # Create/open today's journal
nn -a "quick thought" # Append without opening editor
nn -y                 # Yesterday's journal
nn -3                 # 3 days ago

# Named notes
nn standup            # Creates standup.md in today's folder
nn meeting-planning   # Creates meeting-planning.md

# Templates
nn -T incident api-down      # Incident response
nn -T postmortem api-down    # Post-incident review
nn -T oncall                 # On-call handoff
nn -T runbook restart-db     # Operational runbook

# Search & browse
nn -o                 # Fuzzy find with fzf
nn -s "kubernetes"    # Search content
nn -f meeting         # Find by filename
nn -r 20              # Recent 20 notes
nn --stats            # Streak tracking 🔥

# Git sync
nn --git-init         # Initialize repo
nn --sync             # Commit and push
```

## Directory Structure

```
~/journal/
├── .git/
├── .latest -> 2026/01/28/journal-2026-01-28.md
├── 2026/
│   └── 01/
│       ├── 26/
│       │   └── journal-2026-01-26.md
│       ├── 27/
│       │   ├── journal-2026-01-27.md
│       │   └── incident-db-outage.md
│       └── 28/
│           ├── journal-2026-01-28.md
│           ├── standup.md
│           └── oncall-2026-01-28.md
```

## Templates

All templates include YAML frontmatter for metadata:

```yaml
---
title: "Incident: db-outage"
date: 2026-01-28
time: 14:32 UTC
template: incident
tags: [incident, sre]
---
```

| Template | Command | Use Case |
|----------|---------|----------|
| `journal` | `nn` or `nn -T journal` | Daily journal with mood, wins, blockers |
| `incident` | `nn -T incident name` | Active incident: timeline, impact, mitigation |
| `postmortem` | `nn -T postmortem name` | Post-incident: 5 whys, action items, lessons |
| `oncall` | `nn -T oncall` | Shift handoff: open issues, alerts, notes |
| `runbook` | `nn -T runbook name` | Step-by-step operational procedures |
| `standup` | `nn -T standup` | Yesterday/today/blockers |
| `1on1` | `nn -T 1on1` | One-on-one meeting notes |
| `meeting` | `nn -T meeting name` | General meeting: agenda, decisions, actions |
| `retro` | `nn -T retro` | Sprint retrospective |

## All Commands

```
USAGE
  nn                          Create/open today's journal
  nn <name>                   Create named note
  nn -T <template> [name]     Create from template
  nn -a "text"                Quick append to today's journal
  nn -i [name]                Pipe stdin to note

NAVIGATION
  nn -y, --yesterday          Open yesterday's journal
  nn -Y, --tomorrow           Open tomorrow's journal (prep)
  nn +N / -N                  Jump N days forward/back (e.g., nn -3)

BROWSE & SEARCH
  nn -l, --list               List today's notes
  nn -r, --recent [n]         Recent notes (default: 10)
  nn -o, --open               Open note with fzf
  nn -s, --search <term>      Search content (grep/rg)
  nn -f, --find <pattern>     Find by filename
  nn -t, --tree               Tree view
  nn --latest                 Open most recent note

GIT SYNC
  nn --sync                   Commit and push changes
  nn --git-init               Initialize git repo in notes dir

UTILITY
  nn -p, --path               Print today's path
  nn -e, --view [name]        Open in pager (read-only)
  nn -m, --markdown           Markdown cheat sheet
  nn --stats                  Show statistics
  nn --completions            Output shell completions
  nn -h, --help               This help
  nn -v, --version            Version info
```

## Configuration

Environment variables:

```bash
export NOTES_ROOT="$HOME/journal"  # Base directory (default: ~/journal)
export EDITOR="vim"                # Editor (default: vim)
```

## Workflows

### Morning Routine
```bash
nn                    # Open today's journal
# Write intentions, energy check
```

### During Work
```bash
nn -a "deployed v2.3.1 to prod"
nn -a "fixed memory leak in auth service"
nn -a "TODO: follow up with Sarah on API design"
```

### Incident Response
```bash
nn -T incident api-latency
# Document as you go: timeline, actions, findings
```

### End of Day
```bash
nn                    # Review/complete journal
nn --sync             # Push to git
nn --stats            # Check your streak 🔥
```

### On-Call Handoff
```bash
nn -T oncall
# Fill in: open issues, alerts fired, things to watch
# Send link to incoming oncall
```

### Capture Debug Output
```bash
kubectl describe pod foo-abc123 | nn -i pod-debug
tcpdump -c 100 -w - | nn -i packet-capture
docker logs app 2>&1 | nn -i docker-logs
```

## Tips

**Sync to mobile**: Point `NOTES_ROOT` at a Syncthing/Dropbox folder

**Search with context**: `nn -s "error" && rg -C3 "error" ~/journal`

**Weekly review**: `nn -r 50 | grep journal` to see all recent journals

**Custom templates**: Edit the `template_*` functions in the script

**Backup**: `nn --git-init` then add a private GitHub/GitLab remote

## FAQ

**Why not Obsidian/Notion/Logseq?**  
Those are great! But sometimes you just want `nn -a "thought"` without leaving the terminal.

**Why bash?**  
Zero dependencies. Works on any Unix system, in containers, over SSH.

**Why date-based folders?**  
Easy backup, easy sync, easy git history, no database needed.

**Can I use a different editor?**  
Yes: `export EDITOR=nano` or `export EDITOR="code --wait"`

## Contributing

Issues and PRs welcome. Keep it simple — this is a ~900 line bash script, not a framework.

## License

MIT — do whatever you want with it.

---

Made with ☕ by [@bellistech](https://github.com/bellistech)
