Target của phạm vi này thường thì phạm vi wildcard (wildcard scope) sẽ được cung cấp.

**Example**: *.harshbothra.tech

***All the things that you do in Small Scope Recon and a few add-ons:***

## **1. Subdomain Enumeration**

Thu thập các subdomain

**Tools**:

- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [Assetfinder](https://github.com/tomnomnom/assetfinder)
- [Amass](https://github.com/OWASP/Amass)
- [Chaos](https://github.com/projectdiscovery/chaos-client)
- [Sudomy](https://github.com/Screetsec/Sudomy)
- [Sublister](https://github.com/aboul3la/sublist3r)

## **2. Subdomain Bruteforcing**

Thu thập các subdomain bằng wordlist

**Tools**:

- [dnsx](https://github.com/projectdiscovery/dnsx)
- [DNS Validator (To generate resolvers list)](https://github.com/vortexau/dnsvalidator)

## **3. Subdomain Takeover**

**Tools**:

- Nuclei Templates
- [Subdomain Takeover](https://github.com/antichown/subdomain-takeover)
- [Takeover](https://github.com/m4ll0k/takeover)
- [Osmedeus Takeover Module](https://github.com/j3ssie/Osmedeus)

## **4. Probing**

Lọc ra những subdomain còn hoạt động

**Tools**:

- [HTTPX](https://github.com/projectdiscovery/httpx)
- [HTTProbe](https://github.com/tomnomnom/httprobe)

## **5. Template Based Scanning**

Nó sẽ scan target với cái template, trong template có các chữ ký để phát hiện lỗ hỏng. Nếu scan target khớp thì suy ra target dính lỗ hỏng.

**Tools**:

- [Nuclei](https://github.com/projectdiscovery/nuclei)
- [Jaeles](https://github.com/jaeles-project/jaeles)

## **6. Internet Search Engine Discovery**

Đây là công cụ tìm kiếm bên thứ 3. Bạn đưa 1 tên phần mềm hay version service thì các công cụ nó sẽ tìm kiếm các máy chủ chạy cái phần mềm hay version service bạn tìm kiếm.

**Websites**:

- [Shodan](https://www.shodan.io/)
- [Spyse](http://spyse.com/)
- [Censys](https://censys.io/)
- [Fofa](https://fofa.so/)
- [BinaryEdge](https://www.binaryedge.io/)

## **7. Potential Pattern Extraction with GF**

A wrapper around grep to avoid typing common patterns. You can further automate those URLs to perform automated detection of vulnerabilities while you work on them manually.

**Tools**:

- [GF](https://github.com/tomnomnom/gf)
- [GF Patterns](https://github.com/1ndianl33t/Gf-Patterns)

## **8. Heartbleed Scanning**

Scan các lỗ hỏng đã biết trong SSL/TLS của ứng dụng

**Tools**:

- [MassBleed](https://github.com/1N3/MassBleed)

## **9. General Security Misconfiguration Scanning**

Apart from all of the above, you can always automate scanning for various other general misconfiguration such as:

- CORS Scanning
- Security Headers Scanning
- SPF Record Scanning
- CRLF Injection Scanning
- HTTP Request Smuggling Detection (High Chance of False Positives in Automation)
