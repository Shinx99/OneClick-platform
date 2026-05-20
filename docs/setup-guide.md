# Hướng Dẫn Cài Đặt Chi Tiết OneClick Platform

## 1. Yêu Cầu Hệ Thống
- RAM: Tối thiểu 4GB (Khuyến nghị 8GB)
- Hệ điều hành: Linux/macOS/Windows (kèm WSL2)
- Phần mềm:
  - Git
  - Docker & Docker Compose

## 2. Các Bước Cài Đặt

1. **Clone repository này (Repo quản lý)**
   ```bash
   git clone https://github.com/Shinx99/OneClick-platform.git
   cd OneClick-platform
   ```

2. **Cấp quyền thực thi cho các script**
   ```bash
   chmod +x *.sh
   ```

3. **Khởi động hệ thống (Chỉ 1 lệnh duy nhất)**
   ```bash
   ./oneclick.sh start
   ```
   Lệnh này sẽ tự động:
   - Clone tất cả mã nguồn các services con về thư mục `services/`.
   - Tạo network Docker chung.
   - Build các Docker image.
   - Khởi động tất cả database, redis, minio và các services.

## 3. Khắc Phục Sự Cố
- Nếu gặp lỗi port đã được sử dụng: Hãy dừng các ứng dụng đang dùng port `5432, 6379, 8080, ...` hoặc dùng lệnh `./oneclick.sh stop` sau đó đổi port trong file `.env` (tuy nhiên cần đổi cả trong cấu hình của từng service tương ứng).
- Lỗi không kết nối được Database: Kiểm tra log của database bằng lệnh `docker compose logs -f postgres-auth` để xem nguyên nhân.
