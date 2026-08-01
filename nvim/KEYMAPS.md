### Buffer/Tab Management

| Keymap      | Action                   | Priority    |
| ----------- | ------------------------ | ----------- |
| `<leader>x` | Close current buffer/tab | 🔴 CRITICAL |
| `<Tab>`     | Go to next buffer        | 🔴 CRITICAL |
| `<S-Tab>`   | Go to previous buffer    | 🔴 CRITICAL |
| `<C-u>zz`   | Scroll up (centered)     | 🟠 HIGH     |
| `<C-d>zz`   | Scroll down (centered)   | 🟠 HIGH     |

### Window Management

| Keymap       | Action                    | Priority  |
| ------------ | ------------------------- | --------- |
| `<leader>sv` | Split window vertically   | 🟠 HIGH   |
| `<leader>sh` | Split window horizontally | 🟠 HIGH   |
| `<leader>se` | Make splits equal size    | 🟠 HIGH   |
| `<leader>sx` | Close current split       | 🟠 HIGH   |
| `<C-Up>`     | Increase split height     | 🟡 MEDIUM |
| `<C-Down>`   | Decrease split height     | 🟡 MEDIUM |
| `<C-Left>`   | Make split narrower       | 🟡 MEDIUM |
| `<C-Right>`  | Make split wider          | 🟡 MEDIUM |

### Search & Find (Telescope)

| Keymap       | Action                                   | Priority    |
| ------------ | ---------------------------------------- | ----------- |
| `<leader>ff` | Find files                               | 🔴 CRITICAL |
| `<leader>fw` | Find string in current working directory | 🔴 CRITICAL |
| `<leader>fc` | Find string under cursor                 | 🟠 HIGH     |

---

## 📋 LSP & Code Navigation

### Go To / Navigation

| Keymap | Action                   | Source    |
| ------ | ------------------------ | --------- |
| `gd`   | Go to definition         | lspconfig |
| `gD`   | Go to declaration        | lspconfig |
| `gR`   | Show LSP references      | lspconfig |
| `gi`   | Show implementations     | lspconfig |
| `gt`   | Show type definitions    | lspconfig |
| `K`    | Show documentation/hover | lspconfig |

### Diagnostics / Errors

| Keymap      | Action                              | Source    |
| ----------- | ----------------------------------- | --------- |
| `<leader>d` | Show line diagnostics (float)       | lspconfig |
| `<leader>D` | Show buffer diagnostics (Telescope) | lspconfig |
| `[d`        | Go to previous diagnostic           | lspconfig |
| `]d`        | Go to next diagnostic               | lspconfig |

### Code Actions & Refactoring

| Keymap       | Action                     | Source    |
| ------------ | -------------------------- | --------- |
| `<leader>ca` | See available code actions | lspconfig |
| `<leader>rn` | Smart rename               | lspconfig |
| `<leader>rs` | Restart LSP                | lspconfig |

### LSP Info & Calls

| Keymap       | Action                   | Source    |
| ------------ | ------------------------ | --------- |
| `<leader>ci` | Find incoming calls      | lspconfig |
| `<leader>co` | Find outgoing calls      | lspconfig |
| `<leader>ch` | Find implementations     | lspconfig |
| `<leader>cu` | Find usages (references) | lspconfig |

---

## 🎨 Theme & UI

| Keymap       | Action         | Source  |
| ------------ | -------------- | ------- |
| `<leader>ts` | Select theme   | keymaps |
| `<leader>tn` | Next theme     | keymaps |
| `<leader>tp` | Previous theme | keymaps |

---

## 📁 File Management

| Keymap      | Action                          | Source    |
| ----------- | ------------------------------- | --------- |
| `<C-n>`     | Toggle file explorer (NvimTree) | nvim-tree |
| `<leader>e` | Focus file explorer             | nvim-tree |

---

## 🗂️ Buffer Operations

| Keymap      | Action            | Source     |
| ----------- | ----------------- | ---------- |
| `<leader>h` | Move buffer left  | bufferline |
| `<leader>l` | Move buffer right | bufferline |
| `<leader>n` | New buffer        | keymaps    |
| `<leader>N` | New tab           | keymaps    |

---

## 🐛 Debugger (DAP)

### Debug Control

| Keymap       | Action             | Source |
| ------------ | ------------------ | ------ |
| `<leader>dc` | Continue execution | dap    |
| `<leader>db` | Toggle breakpoint  | dap    |
| `<leader>ds` | Step over          | dap    |
| `<leader>di` | Step into          | dap    |
| `<leader>do` | Step out           | dap    |
| `<leader>dr` | Restart debugger   | dap    |
| `<leader>dt` | Terminate debugger | dap    |

### Debug UI

| Keymap       | Action               | Source |
| ------------ | -------------------- | ------ |
| `<leader>du` | Toggle DAP UI        | dap-ui |
| `<leader>dw` | Add watch expression | dap-ui |
| `<leader>dW` | Remove watch         | dap-ui |
| `<leader>dC` | Clear all watches    | dap-ui |

---

## 🤖 AI / Copilot

| Keymap                | Action                    | Source  |
| --------------------- | ------------------------- | ------- |
| `<C-g>` (Insert mode) | Accept Copilot suggestion | copilot |

---

## 🎯 Terminal

| Keymap                  | Action             | Source  |
| ----------------------- | ------------------ | ------- |
| `<Esc>` (Terminal mode) | Exit terminal mode | keymaps |

---

## 📝 Command Mode Shortcuts

| Command | Action                          |
| ------- | ------------------------------- |
| `:W`    | Save (alias for `:w`)           |
| `:Wq`   | Save and quit (alias for `:wq`) |

---

## 🔍 How to Use This Guide

- 🔴 **CRITICAL**: Use these daily, learn them by heart
- 🟠 **HIGH**: Very useful, worth learning
- 🟡 **MEDIUM**: Convenient but not essential
- Source column shows which plugin/config file the keymap comes from

---

**Last Updated**: 2026-07-21
