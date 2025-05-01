# 🔐 NetIntel Security Suite™

> Developed by **Ahmed Ibrahim** – Cybersecurity Developer  
> Version: `v1.0`

NetIntel is a Bash-based tool designed to streamline network intelligence gathering. Starting with a domain, it automatically resolves the IP, extracts ASN information, gathers associated CIDR blocks, performs reverse DNS lookups, and optionally saves the results into a clean report.

---

## 🧰 Features

- 🌐 **Domain to IP** Resolution
- 🛰️ **ASN Lookup** (via RADb + fallback to BGPView)
- 📡 **CIDR Block Extraction**
- 🔄 **Reverse DNS Lookup** using `mapcidr` + `dnsx`
- 💾 **Optional Report Saving**

---

## ⚙️ Installation

### 📦 Required Dependencies

| Tool     | Install Command                                     |
|----------|-----------------------------------------------------|
| `dig`    | Usually pre-installed (`bind-utils` / `dnsutils`)   |
| `whois`  | `sudo apt install whois` or `sudo pacman -S whois`  |
| `curl`   | `sudo apt install curl`                             |
| `jq`     | `sudo apt install jq`                               |
| `mapcidr`| `go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest` |
| `dnsx`   | `go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest` |

> ☑️ Make sure **Go** is installed for `mapcidr` and `dnsx`:
```bash
sudo apt install golang -y
