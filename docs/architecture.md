# Kiến Trúc Hệ Thống OneClick Platform

## 1. Tại sao chọn Microservices?
- **Khả năng mở rộng độc lập:** Các dịch vụ Auth và Recruitment có thể được scale riêng biệt tùy thuộc vào lượng tải.
- **Phát triển linh hoạt:** Dễ dàng bảo trì và cập nhật các service mà không ảnh hưởng đến toàn bộ hệ thống.
- **Lựa chọn công nghệ đa dạng:** Mỗi service có thể sử dụng stack công nghệ phù hợp nhất (hiện tại dùng chung Spring Boot, tương lai có thể thêm NodeJS, Go...).

## 2. Giao tiếp qua Eureka (Service Discovery)
- **Eureka Server** hoạt động như một danh bạ. Khi Auth Service hoặc Recruitment Service khởi động, chúng sẽ tự động đăng ký với Eureka.
- **API Gateway** lấy thông tin địa chỉ IP của các service từ Eureka để định tuyến request, đảm bảo không cần fix cứng địa chỉ IP trong cấu hình.

## 3. Flow xác thực JWT
1. Người dùng login qua **Auth Service**.
2. **Auth Service** sinh ra token JWT, lưu (hoặc đối chiếu session) vào **Redis (redis-auth)**.
3. Khi người dùng gọi tới **Recruitment Service**, request phải đi qua **API Gateway**.
4. **API Gateway** sẽ kiểm tra tính hợp lệ của token trước khi chuyển request tới **Recruitment Service**.

## 4. Cơ chế cache Redis
Hệ thống sử dụng Redis cho 3 mục đích tách biệt để tối ưu hiệu năng:
- **redis-gateway (6378):** Quản lý rate-limiting và cache route cho API Gateway.
- **redis-auth (6379):** Lưu session, OTP, token blacklist của người dùng.
- **redis-recruitment (6380):** Cache dữ liệu tĩnh và dữ liệu hay truy cập của module tuyển dụng (như danh sách ứng viên, thông tin công việc).

## 5. Storage với MinIO
- Sử dụng MinIO thay thế cho AWS S3 để lưu trữ file (CV, avatar) một cách cục bộ với API tương thích S3.
