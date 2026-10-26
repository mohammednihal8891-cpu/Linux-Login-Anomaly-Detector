
# 🔐 Linux Login Anomaly Detector

A Bash-based Cybersecurity project built on Kali Linux.

## 📌 About the Project

Linux Login Anomaly Detector analyzes Linux authentication logs to identify repeated failed SSH login attempts.

It groups failed attempts by source IP address and flags IPs with five or more failed attempts as HIGH risk.

## ✨ Features

- Authentication log analysis
- Failed SSH login detection
- Source IP identification
- HIGH and LOW risk classification
- Interactive terminal menu
- Text report generation
- View previous scan reports

## 🛠️ Technologies Used

- Kali Linux
- Bash Scripting
- Linux Journal Logs
- AWK and GREP

## ▶️ How to Run

Clone or download this repository, then enter the project directory.

Run:

```bash
bash detector.sh
```

The script may ask for your Kali Linux password to read system logs.

## 📄 Report

The scan report is saved as `login_report.txt`.

## ⚠️ Disclaimer

This project is for educational and defensive cybersecurity purposes. Risk levels are based on failed login counts and do not prove that an attack occurred.

## 👨‍💻 Author

Mohammed Nihal

Cybersecurity Student
