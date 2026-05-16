# Work Flow Recon

Vì task này là chọn 1 subdomain để recon nên sẽ chia thành 2 đợt recon như sau:

## 1. Recon Domain

Recon domain này thì sẽ chia thành Active và Passive.

* **Passive:** Là dùng bên thứ 3 để thu thập thông tin có sẵn trên internet về target.
* **Active:** Là chạm trực tiếp vào mục tiêu để lấy các thông tin từ target.

Từ việc recon Passive và Active xong ta được lượng lớn subdomain và các thông tin liên quan đến target. Thì lúc này ta nên lọc các subdomain còn hoạt động. Và chọn ra 1 subdomain có nhiều tính năng nhất để recon chi tiết.

### Subdomain Enumeration

Thu thập càng nhiều subdomain thì càng mở nhiều bề mặt tấn công target.

* **Passive Tools:**
* Subfinder
* Crt
* Virustotal
* Osmedeus


* **Active Tools:**
* Knockpy
* Nmap
* Gobuster



### Subdomain Live

Dùng để lọc ra những subdomain còn hoạt động dựa trên đám subdomain vừa mới enum trên.

* **Tools:**
* HTTPX
* HTTProbe



Có thể bước này sẽ dẫn đến các Subdomain có các mã 200, 300, 400, 500. Nhưng chúng ta chỉ nhắm vào các mã của 200 và 300 thôi.

* Mã 200 giữ lại thành 1 file riêng.
* Các mã 300 cần dùng HTTPX để biết chính xác nó chuyển hướng đến subdomain nào, và cần đệ quy nhiều lần để tìm ra subdomain có mã 200. Rồi cho các subdomain từ việc đệ quy lần cuối vào cái file mã 200 ban đầu.

### Template Based Scanning

Từ các subdomain live đó lần lượt scan bằng các công cụ có sẵn bằng các bộ quy tắc (templates) định nghĩa sẵn để phát hiện nhanh các lỗ hổng bảo mật đã biết (CVEs), lỗi cấu hình (misconfigurations) và các tệp tin nhạy cảm.

* **Tools:**
* Nuclei



---

## 2. Recon Subdomain Detail

Lúc này ta chọn được target từ Recon Domain trên thì tới lúc chọn Scope Recon để có 1 cái mindmap thực hiện recon mục tiêu mà không bị sao nhãn. Điều này giúp đỡ tốn thời gian, và mình biết chính xác điều mình làm là gì.

### Technology Fingerprinting

Nhận diện các service, framework, thư viện (libraries) và các thành phần của bên thứ ba (third-party components) đang được sử dụng để xây dựng và vận hành ứng dụng web. Việc phân tích footprint của hệ thống giúp phát hiện các thành phần đã lỗi thời (outdated) và có thể tồn tại các lỗ hổng bảo mật đã biết.

* **Tools:**
* Wappalyzer Plugin
* Whatweb



### CVEs

Dựa trên footprint và các thông tin về phiên bản (version) của các framework, plugin hay service đã định danh ở bước trên, tiến hành đối chiếu chéo (cross-reference) với các cơ sở dữ liệu lỗ hổng (vulnerability databases) để xác định xem các thành phần này có dính các lỗ hổng (CVE) đã được công bố hay không.

* **Websites:**
* [https://cve.mitre.org/](https://cve.mitre.org/)
* [https://www.cvedetails.com/](https://www.cvedetails.com/)
* [https://www.exploit-db.com/](https://www.exploit-db.com/)
* [https://snyk.io/](https://snyk.io/)
* [https://www.cybersecurity-help.cz/vdb/](https://www.cybersecurity-help.cz/vdb/)



### Directory Enumeration

Thực hiện brute-force hoặc fuzzing để dò tìm toàn bộ các thư mục (directories), file ẩn và endpoint trên ứng dụng web mục tiêu. Quá trình enumeration này nên được thực hiện ở cả hai trạng thái: không có session (unauthenticated) và có session (authenticated) để phát hiện các dữ liệu nhạy cảm bị rò rỉ, các tính năng ẩn (hidden features) của admin, hoặc để kiểm tra các lỗ hổng về phân quyền (Broken Access Control / Insecure Direct Object References).

* **Tools & Wordlists:**
* Dirsearch
* FFUF
* Nikto
* Gobuster


* **Wordlists:**
* Seclists



### JS Files for Hardcoded APIs & Secrets

Thực hiện phân tích tĩnh (static analysis) các tệp JS phía client để trích xuất dữ liệu nhạy cảm và mở rộng bề mặt tấn công.

#### Discovery/Crawling JS URLs

Mục tiêu là gom toàn bộ các đường dẫn trỏ đến tệp JS của mục tiêu.

* **Tools:**
* Katana
* Hakrawler



Nếu dùng cả 2 tool trên hoặc nhiều hơn thì cần gộp nó lại:

```bash
sort -u katana.txt hakrawler.txt … > merged_js.txt

```

Lọc ra các JS URLs vì 2 tool trên sẽ craw 1 đống path lẫn js vào:

```bash
grep -E "\.js($|\?)" merged_js.txt > pure_js_urls.txt
grep -vE 'wp-includes|wp-content/plugins|wp-admin|jquery|bootstrap|purify\.min\.js|select2' pure_js_urls.txt > custom_js_urls.txt

```

#### Live Probing JS URLs

Từ việc craw ở trên thì chắc ta có kha khá tệp JS, nhưng nhiều tệp đã bị xóa (404), cần lọc các tệp JS này ra thì ta nên lọc ra những tệp JS nào còn hoạt động.

* **Tools:**
* HTTPX



### Parameter Discovery

Thực hiện fuzzing để phát hiện các tham số (parameters) không hiển thị trên client nhưng vẫn được backend xử lý. Các tham số ẩn này thường thiếu cơ chế kiểm tra (validation), là mục tiêu tiềm năng để khai thác các lỗ hổng như SSRF, Open Redirection, XSS, SQLi, IDOR...

* **Tools:**
* Arjun
* ParamSpider
* Param Miner



### Wayback History

Truy xuất các kho lưu trữ web (như Wayback Machine) để dò tìm các endpoint cũ (legacy endpoints) không còn được liên kết trên giao diện nhưng vẫn đang hoạt động. Phương pháp này giúp mở rộng bề mặt tấn công (attack surface) và phát hiện các trang cache làm rò rỉ dữ liệu nhạy cảm.

* **Tools & Websites:**
* Wayback Machine
* Waybackurls
* Gau
