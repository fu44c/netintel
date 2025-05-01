# NetIntel Security Suite™ 🔐

A Bash-based OSINT tool that collects intelligence on a given domain name by resolving it to its IP, retrieving the ASN, collecting CIDR ranges, and performing reverse DNS (PTR) lookups.

---

## 🛠 Features

- 🌍 Domain → IP
- 📡 IP → ASN
- 🧱 ASN → CIDRs
- 🔁 CIDRs → PTR (Reverse DNS)
- 🧾 Optional saving of full reports
- 🎨 Colorful and user-friendly terminal UI

---

## ⚙️ Requirements

Make sure the following tools are installed:

- [`dig`](https://linux.die.net/man/1/dig)
- [`whois`](https://linux.die.net/man/1/whois)
- [`curl`](https://curl.se/)
- [`jq`](https://stedolan.github.io/jq/)
- [`mapcidr`](https://github.com/projectdiscovery/mapcidr)
- [`dnsx`](https://github.com/projectdiscovery/dnsx)

### 📦 Install required tools (Debian/Ubuntu-based systems):

```bash
sudo apt update
sudo apt install -y dnsutils whois curl jq

# Install mapcidr and dnsx from ProjectDiscovery:
GO111MODULE=on go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
GO111MODULE=on go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# Make sure GOPATH is in your PATH:
export PATH=$PATH:$(go env GOPATH)/bin
```

## 🚀 Usage
```
chmod +x netintel.sh

# Run with domain directly:
./netintel.sh -u example.com

# Or run and enter domain manually:
./netintel.sh

# Help:
./netintel.sh --help
```
## 📁 Example Output

*🔍 Resolving IP address for domain...
*✅ IP Resolved: 93.184.216.34
*🔍 Retrieving ASN for IP...
*✅ ASN Found: AS15133
*📡 Looking up CIDR ranges for ASN...
*✅ CIDRs retrieved:
*93.184.216.0/24
*🔄 Performing PTR lookups...

