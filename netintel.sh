#!/bin/bash

# ============ NetIntel Security Suite™ ============ #
# Developed by Ahmed Ibrahim — Cybersecurity Developer
# Version: 1.3
# ================================================ #

# 🎨 Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# 🎬 Welcome banner
echo -e "${CYAN}"
cat << "EOF"
          _   _      _   _      _       
         | \ | | ___| |_| |_ __| |_ ___ 
         |  \| |/ _ \ __| __/ _` | / __|
         | |\  |  __/ |_| || (_| | \__ \
         |_| \_|\___|\__|\__\__,_|_|___/
                  
                N E T I N T E L ™
EOF
echo "╔══════════════════════════════════════════════════╗"
echo "║         🔐 NetIntel Security Suite™              ║"
echo "║      Developed by Ahmed Ibrahim | v1.2           ║"
echo "║       Domain → IP → ASN → CIDRs → PTR            ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${NC}"

# 📌 Usage Help
usage() {
    echo -e "${YELLOW}Usage:${NC} $0 [-u domain.com]"
    echo ""
    echo "Options:"
    echo "  -u <domain>     Specify the domain to scan"
    echo "  -h, --help      Show this help message and exit"
    exit 0
}

# 🧾 Parse Options
while [[ $# -gt 0 ]]; do
    case "$1" in
        -u)
            domain=$2
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}❌ Invalid option: $1${NC}"
            usage
            ;;
    esac
done

# 📝 Ask for domain if not provided
if [ -z "$domain" ]; then
echo -e "${YELLOW}Usage:${NC} $0 [-u domain.com]"
echo ""
echo "Options:"
echo "  -u <domain>     Specify the domain to scan"
echo "  -h, --help      Show this help message and exit"
exit 0
    read -p "🔹 Please enter the domain name (e.g., example.com): " domain
    if [ -z "$domain" ]; then
        echo -e "${RED}❌ No domain entered. Exiting...${NC}"
        exit 1
    fi
fi

# 🌐 Resolve Domain to IP
echo -e "${YELLOW}🔍 Resolving IP address for domain...${NC}"
ip_of_domain=$(dig +short "$domain" | head -n 1)

if [ -z "$ip_of_domain" ]; then
    echo -e "${RED}❌ Unable to resolve IP for $domain.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ IP Resolved: $ip_of_domain${NC}"

# 🛰️ Get ASN from IP
echo -e "${YELLOW}🔍 Retrieving ASN for IP...${NC}"
asn_number=$(whois -h whois.radb.net "$ip_of_domain" 2>/dev/null | grep -i 'origin' | tr -s " " | cut -d " " -f2 | head -n 1)

if [ -z "$asn_number" ]; then
    echo -e "${RED}❌ Could not retrieve ASN for IP.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ ASN Found: $asn_number${NC}"

# 📡 Get CIDRs
echo -e "${YELLOW}📡 Looking up CIDR ranges for ASN...${NC}"
cidrs=$(whois -h whois.radb.net -- "-i origin $asn_number" 2>/dev/null \
| grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+' \
| sort -u)

# 🔁 Fallback if RADb fails
if [ -z "$cidrs" ]; then
    echo -e "${YELLOW}⚠️ RADb lookup failed. Trying BGPView.io API...${NC}"
    cidrs=$(curl -s "https://api.bgpview.io/asn/${asn_number}/prefixes" \
        | jq -r '.data.ipv4_prefixes[].prefix')

    if [ -z "$cidrs" ]; then
        echo -e "${RED}❌ No CIDRs found from BGPView API.${NC}"
        exit 1
    fi

    echo -e "${GREEN}✅ Fallback successful. CIDRs retrieved:${NC}"
else
    echo -e "${GREEN}✅ CIDRs retrieved from RADb:${NC}"
fi

echo "$cidrs"

# 🔄 Reverse DNS
echo -e "${YELLOW}🔄 Performing PTR lookups using mapcidr + dnsx...${NC}"
for cidr in $cidrs; do
    echo -e "${CYAN}➡️ $cidr${NC}"
    echo "$cidr" | mapcidr -silent | dnsx -ptr -resp-only -silent
done

# 💾 Save results
echo -e "\n${YELLOW}💾 Do you want to save this report to a file? (y/n)${NC}"
read -r save_choice

if [[ "$save_choice" =~ ^[Yy]$ ]]; then
    filename="netintel_report_${domain}_$(date +%F).txt"
    {
        echo "🔐 NetIntel Report"
        echo "Developed by: Ahmed Ibrahim"
        echo "Domain: $domain"
        echo "Resolved IP: $ip_of_domain"
        echo "ASN: $asn_number"
        echo ""
        echo "CIDR Blocks:"
        echo "$cidrs"
        echo ""
        echo "Reverse DNS Results:"
        for cidr in $cidrs; do
            echo "➡️ CIDR: $cidr"
            echo "$cidr" | mapcidr -silent | dnsx -ptr -resp-only
        done
        echo ""
        echo "Generated on: $(date)"
    } > "$filename"

    echo -e "${GREEN}✅ Report saved: $filename${NC}"
else
    echo -e "${BLUE}ℹ️ Report not saved.${NC}"
fi

# 🏁 Done
echo -e "${CYAN}✔️ All tasks completed. Stay secure!${NC}"
