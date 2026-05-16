Dưới đây là phần nội dung README đã được cập nhật, bổ sung rõ yêu cầu phải đặt và thực thi Script 2 bên trong thư mục `httpx_results` do Script 1 tạo ra để luồng xử lý (workflow) diễn ra liền mạch.

---

# Bộ công cụ Quét và Phân tích Subdomain

Bộ công cụ gồm 2 script bash giúp kiểm tra trạng thái hoạt động của subdomain và tự động theo dõi đệ quy các chuỗi chuyển hướng (redirect) để tìm HTTP status cuối cùng.

## Yêu cầu hệ thống

* **Công cụ cốt lõi:** [httpx](https://github.com/projectdiscovery/httpx) (Đường dẫn yêu cầu: `$HOME/go/bin/httpx` hoặc `/go/bin/httpx`).
* **Xử lý JSON:** `jq` (Cài đặt: `sudo apt install jq`).

---

## 1. Script 1: Phân loại trạng thái Subdomain

Kiểm tra hàng loạt danh sách subdomain và tự động phân loại kết quả vào các tệp riêng biệt dựa trên mã trạng thái HTTP (200, 301, 403, 500, v.v.).

* **Đầu vào:** Tệp `subdomains_merged.txt` chứa danh sách subdomain (đặt cùng cấp với script).
* **Đầu ra:** Thư mục `httpx_results/` chứa:
* `raw_results.txt` (Dữ liệu quét tổng hợp thô).
* Các tệp đã phân loại: `sub_200.txt`, `sub_301.txt`, `sub_404.txt`,...


* **Sử dụng:**
```bash
chmod +x script1.sh
./script1.sh

```



---

## 2. Script 2: Đệ quy theo dõi Redirect (Chống Loop)

Quét sâu các URL có mã chuyển hướng (3xx) để tìm điểm đến cuối cùng. Script hỗ trợ đệ quy tối đa 7 vòng và có cơ chế ghi nhớ lịch sử quét toàn cục để ngăn chặn tình trạng lặp vô hạn (Infinite Loop).

* **Lưu ý quan trọng:** Script này thiết kế để đọc các tệp `sub_30*.txt` tại thư mục hiện hành. Do đó, **bắt buộc phải đặt và chạy script này bên trong thư mục `httpx_results/**` (được tạo ra từ Script 1).
* **Đầu vào:** Tự động thu thập từ các tệp `sub_30*.txt` có sẵn trong thư mục `httpx_results/`.
* **Đầu ra:** Các thư mục con `round_1/`, `round_2/`,... nằm ngay trong `httpx_results/`, chứa dữ liệu phân tích của từng vòng đệ quy:
* `redirect_destinations.txt`: Danh sách các URL đích được trỏ tới.
* `alive_destinations.txt`: Mã trạng thái và tiêu đề (Title) của các URL đích.
* `sub_3xx.txt`: Các chuyển hướng mới phát sinh để đưa vào vòng quét tiếp theo.


* **Sử dụng:**

```bash
  # Di chuyển script 2 vào thư mục kết quả của script 1
  cp script2.sh httpx_results/
  cd httpx_results/
  
  # Cấp quyền thực thi và khởi chạy
  chmod +x script2.sh
  ./script2.sh

```

```

```