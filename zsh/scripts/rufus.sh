#!/usr/bin/env bash

SESSION="rufus"

# 1. Bestehende Session anhängen, falls sie schon existiert
if tmux has-session -t "$SESSION" 2>/dev/null; then
  exec tmux attach-session -t "$SESSION"
fi

# 2. Neue Session im Hintergrund starten (Erstes Fenster: "editor")
tmux new-session -d -s "$SESSION" -n "editor"

# Befehl in Hauptfenster starten (z. B. Neovim)
tmux send-keys -t "$SESSION:editor" "nvim ." C-m

# 3. Zweites Fenster für Terminal/Server erstellen
tmux new-window -t "$SESSION" -n "terminal"

# Fenster aufteilen (Rechtes Panel für Logs/Server, linkes für Shell)
tmux split-window -h -t "$SESSION:terminal"

# Befehle in die Panels senden
tmux send-keys -t "$SESSION:terminal.1" "htop" C-m
tmux send-keys -t "$SESSION:terminal.2" "clear" C-m

# 4. Fokus auf das erste Fenster setzen und Session öffnen
tmux select-window -t "$SESSION:editor"
exec tmux attach-session -t "$SESSION"
