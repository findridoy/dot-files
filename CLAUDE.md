# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview
This is a personal dotfiles repository containing configuration files for development tools and system setup on macOS. The primary configuration management is handled through Nix Darwin flake for declarative system configuration.

## System Architecture
- **Nix Darwin Flake**: Primary system configuration in `.config/nix/flake.nix`
  - Manages system packages (Go, Claude Code, GitHub CLI, Neovim)
  - Configures system defaults (dock, trackpad, keyboard repeat rates)
  - Manages Homebrew casks for GUI applications
  - Sets up shell environment with Zsh
- **Neovim Configuration**: NvChad-based setup in `.config/nvim/`
  - Uses Lazy.nvim for plugin management
  - Configured for Go, Lua, HTML, CSS, PHP development
  - LSP support with Mason for language servers
- **WezTerm Configuration**: Terminal emulator config in `.config/wezterm/wezterm.lua`
  - Custom keybindings for tab navigation (Alt+1-9)

## Common Commands

### System Management
```bash
# Apply Nix Darwin configuration changes
darwin-rebuild switch --flake .config/nix#hriduair

# Build configuration without applying
darwin-rebuild build --flake .config/nix#hriduair

# Show what would change
darwin-rebuild build --flake .config/nix#hriduair --show-trace
```

### Development Environment
The system includes these development tools via Nix:
- Go programming language
- Claude Code CLI
- GitHub CLI (gh)
- Neovim with full language support

Language servers and formatters are managed through Mason within Neovim:
- lua-language-server, stylua
- html-lsp, css-lsp, prettier  
- pyre (Python)
- gofmt, goimports (Go)
- phpactor (PHP)

## Configuration Structure
- `.config/nix/flake.nix` - System-level configuration and package management
- `.config/nvim/` - Complete Neovim setup with NvChad framework
- `.config/wezterm/` - Terminal emulator configuration
- `.config/zed/` - Zed editor configuration
- `.config/Code/` - VS Code settings

## Key Features
- Touch ID authentication for sudo
- Optimized keyboard repeat rates for development
- Auto-hiding dock with fast animations  
- Comprehensive development toolchain for Go, web development, and more
- Dotfiles and git-ignored files visible in nvim-tree file explorer