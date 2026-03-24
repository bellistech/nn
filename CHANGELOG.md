# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.0.0] - 2026-01-28

### Added
- **Day navigation**: `nn -y` (yesterday), `nn -Y` (tomorrow), `nn +N`/`nn -N` (offset days)
- **Git sync**: `nn --sync` commits and pushes, `nn --git-init` initializes repo
- **YAML frontmatter**: All notes now include metadata (title, date, template, tags)
- **Shell completions**: `nn --completions` outputs bash/zsh completions
- **Latest symlink**: `~/.journal/.latest` always points to most recent note
- **Markdown cheatsheet**: `nn -m` displays quick reference

### Fixed
- Subshell variable bug in `search_notes()` and `find_notes()` - results now display correctly
- Streak calculation breaking on first iteration with `set -e`
- Cross-platform date arithmetic (GNU + BSD/macOS compatibility)

## [3.0.0] - 2026-01-27

### Added
- **9 SRE templates**: journal, incident, postmortem, oncall, runbook, standup, 1on1, meeting, retro
- **Quick append**: `nn -a "text"` appends to journal without opening editor
- **Stdin capture**: `command | nn -i name` captures output to note
- **fzf integration**: `nn -o` fuzzy finds and opens notes
- **Statistics**: `nn --stats` shows note counts and streak tracking
- **Read-only view**: `nn -e name` opens in pager
- **Recent notes**: `nn -r N` lists N most recent notes

### Changed
- Directory structure changed to `~/journal/YYYY/MM/DD/`
- Default note name uses datestamp instead of timestamp

## [2.1.0] - 2026-01-27

### Fixed
- Removed `local` keyword outside function (bash error on line 199)
- Fixed `ssh-keygen` passphrase prompt (removed `-N ""` flag)

## [2.0.0] - 2026-01-27

### Added
- Hierarchical date-based folder structure
- Auto email detection from git config
- SSH config alias management
- Clipboard support (pbcopy/xclip/wl-copy)
- Key backup before overwrite
- Colorized output with Unicode glyphs

### Changed
- Complete rewrite with modern bash patterns
- Smart defaults based on current directory name

## [1.0.0] - 2026-01-26

### Added
- Initial release
- Basic note creation with date prefix
- Simple editor integration
