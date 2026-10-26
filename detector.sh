
#!/bin/bash

CYAN='\033[1;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'

while true; do
    clear
    echo -e "${CYAN}"
    echo "======================================"
    echo "   LINUX LOGIN ANOMALY DETECTOR"
    echo "======================================"
    echo -e "${RESET}"
    echo "1. Scan Login Logs"
    echo "2. View Previous Report"
    echo "3. Exit"
    echo
    read -rp "Enter your choice: " choice

    case "$choice" in
        1)
            echo
            echo "[+] Scanning authentication logs..."

            LOGS=$(sudo journalctl --no-pager -q -o cat |
                grep -E 'Failed password.*from [0-9a-fA-F:.]+')

            {
                echo "LINUX LOGIN ANOMALY DETECTOR"
                echo "Report generated: $(date)"
                echo "======================================"

                if [ -z "$LOGS" ]; then
                    echo "No failed SSH login attempts found."
                else
                    echo "$LOGS" | awk -v threshold=5 '
                    {
                        for (i=1; i<=NF; i++) {
                            if ($i == "from") {
                                ip=$(i+1)
                                count[ip]++
                            }
                        }
                    }
                    END {
                        for (ip in count) {
                            print "Source IP:", ip
                            print "Failed Attempts:", count[ip]

                            if (count[ip] >= threshold)
                                print "Risk Level: HIGH"
                            else
                                print "Risk Level: LOW"

                            print "-----------------------------"
                        }
                    }'
                fi
            } | tee login_report.txt

            echo
            echo -e "${GREEN}[+] Report saved!${RESET}"
            read -rp "Press Enter to continue..."
            ;;
        2)
            echo
            if [ -f login_report.txt ]; then
                cat login_report.txt
            else
                echo "No report found. Scan logs first."
            fi
            echo
            read -rp "Press Enter to continue..."
            ;;
        3)
            echo "Exiting detector. Goodbye!"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice! Try again.${RESET}"
            sleep 2
            ;;
    esac
done
