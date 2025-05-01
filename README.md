# 🔐 NetIntel Security Suite™

> Developed by **Ahmed Ibrahim** – Cybersecurity Developer  
> Version: v1.2

NetIntel is a Bash-based tool designed to streamline network intelligence gathering. Starting with a domain, it automatically resolves the IP, extracts ASN information, gathers associated CIDR blocks, performs reverse DNS lookups, and optionally saves the results into a clean report.

---

## 🧰 Features

#####         _   _      _   _      _       
#####        | \ | | ___| |_| |_ __| |_ ___ 
#####        |  \| |/ _ \ __| __/ _` | / __|
#####        | |\  |  __/ |_| || (_| | \__ \
#####        |_| \_|\___|\__|\__\__,_|_|___/
                  
#####               N E T I N T E L ™
##### ╔══════════════════════════════════════════════════╗
##### ║         🔐 NetIntel Security Suite™              ║
##### ║      Developed by Ahmed Ibrahim | v1.2           ║
##### ║       Domain → IP → ASN → CIDRs → PTR            ║
##### ╚══════════════════════════════════════════════════╝
Usage: ./netintel.sh [-u domain.com]

Options:
-u <domain>     Specify the domain to scan
-h, --help      Show this help message and exit
    
- 🌐 **Domain to IP** Resolution  
- 🛰️ **ASN Lookup** (via RADb + fallback to BGPView)  
- 📡 **CIDR Block Extraction**  
- 🔄 **Reverse DNS Lookup** using mapcidr + dnsx  
- 💾 **Optional Report Saving**  

---

## ⚙️ Installation

### 📦 Required Dependencies

| Tool     | Install Command                                     |
|----------|-----------------------------------------------------|
| dig      | Usually pre-installed (bind-utils / dnsutils)       |
| whois    | `sudo apt install whois` or `sudo pacman -S whois` |
| curl     | `sudo apt install curl`                             |
| jq       | `sudo apt install jq`                               |
| mapcidr  | `go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest` |
| dnsx     | `go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest` |

> ☑️ Make sure **Go** is installed for mapcidr and dnsx:
```bash
sudo apt install golang -y

```

#### Then add this to your .bashrc or .zshrc:
```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

#### Reload shell:
```bash
source ~/.bashrc
```

## 🚀 Usage
```bash
chmod +x netintel.sh
./netintel.sh
```

## 📄 Example Output
```yaml
🔐 NetIntel Report
Developed by: Ahmed Ibrahim
Domain: example.com
Resolved IP: 93.184.216.34
ASN: AS15133

CIDR Blocks:
93.184.216.0/24

Reverse DNS Results:
➡️ 93.184.216.34 → edge.example.com
```

👨‍💻 Author
Ahmed Ibrahim
Cybersecurity Developer
GitHub

