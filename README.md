# OneClick Platform 🚀

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://java.com/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-green.svg)](https://spring.io/projects/spring-boot)
[![Next.js](https://img.shields.io/badge/Next.js-14-black.svg)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-18-blue.svg)](https://react.dev/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)

Đây là repository cấu hình tổng (Home Repo) của dự án **OneClick Platform**. Repository này quản lý toàn bộ cấu hình hạ tầng và cho phép khởi chạy hệ thống Microservices chỉ với một lệnh duy nhất.

## 📐 Kiến Trúc Hệ Thống

```mermaid
graph TD
    Client[Next.js Frontend\n:3000] -->|HTTP Request| Gateway[Spring Cloud Gateway\n:8080]
    
    Gateway -->|Route| Auth[Auth Service\n:8081]
    Gateway -->|Route| Recruit[Recruitment Service\n:8082]
    
    Auth -.->|Register/Discover| Eureka[Eureka Server\n:8761]
    Recruit -.->|Register/Discover| Eureka
    Gateway -.->|Register/Discover| Eureka
    
    Auth --> DB_Auth[(PostgreSQL Auth\n:5432)]
    Auth --> Redis_Auth[(Redis Auth\n:6379)]
    
    Recruit --> DB_Recruit[(PostgreSQL Recruit\n:5433)]
    Recruit --> Redis_Recruit[(Redis Recruit\n:6380)]
    Recruit --> MinIO[(MinIO Object Storage\n:9000)]
    
    Gateway --> Redis_Gateway[(Redis Gateway\n:6378)]
```

## 🧩 Danh Sách Các Services

| Service Name | Công Nghệ | Port | Mô tả | Repository |
|--------------|-----------|------|-------|------------|
| **Auth Frontend** | Next.js / React | `3000` | Giao diện người dùng | [OneClick-authService-fe](https://github.com/Shinx99/OneClick-authService-fe) |
| **API Gateway** | Spring Cloud Gateway | `8080` | Điểm vào của mọi API, xử lý route | [OneClick-gatewayService](https://github.com/Shinx99/OneClick-gatewayService) |
| **Auth Backend** | Spring Boot | `8081` | Quản lý User, Authentication (JWT) | [OneClick-authService-be](https://github.com/Shinx99/OneClick-authService-be) |
| **Recruitment Backend** | Spring Boot | `8082` | Quản lý việc làm, CV, ứng viên | [OneClick-recruitmentService-be](https://github.com/Shinx99/OneClick-recruitmentService-be) |

*Các thành phần hạ tầng (Eureka, PostgreSQL, Redis, MinIO) được cấu hình tự động thông qua Docker Compose.*

## 📸 Giao Diện Ứng Dụng (Screenshots)

Dưới đây là một số hình ảnh thực tế của hệ thống OneClick Platform (bạn hãy thay thế đường dẫn ảnh bằng ảnh thật của dự án):

### 1. Trang Chủ (Home)
![Trang Chủ](docs/images/home.png)

### 2. Trang Tuyển Dụng
![Trang Tuyển Dụng](docs/images/recruitment.png)

### 3. Trang Quản Lý của Nhà Tuyển Dụng (Recruiter Dashboard)
![Quản Lý Recruiter](docs/images/recruiter-dashboard.png)

### 4. Trang Quản Lý của Admin (Admin Dashboard)
![Quản Lý Admin](docs/images/admin-dashboard.png)

### 5. Trang Quản Lý CV (CV Management)
![Quản Lý CV](docs/images/cv-management.png)

### 6. Trang Hồ Sơ Người Dùng (User Profile)
![Hồ Sơ Người Dùng](docs/images/user-profile.png)

## ⚙️ Yêu Cầu Hệ Thống

- **Git** (Để clone source code)
- **Docker & Docker Compose**
- Ít nhất **4GB RAM** trống.

## 🚀 Hướng Dẫn Cài Đặt Nhanh

Chỉ với 3 lệnh đơn giản, hệ thống sẽ tự động được tải về, thiết lập và chạy:

```bash
# 1. Cấp quyền thực thi cho các script (Linux/macOS)
chmod +x *.sh

# 2. Tạo file biến môi trường và sửa đổi (tuỳ chọn)
cp .env.example .env

# 3. Khởi chạy toàn bộ hệ thống
./oneclick.sh start
```

## 🛠 Cách Sử Dụng Master Script (`oneclick.sh`)

Sử dụng script `./oneclick.sh [command]` để điều khiển hệ thống:

- `start`: Tự động clone các services, build image và chạy toàn bộ container.
- `stop`: Dừng toàn bộ hệ thống (có thể tùy chọn xóa hoặc giữ dữ liệu).
- `restart`: Khởi động lại toàn bộ hệ thống.
- `build`: Thực hiện build lại các Docker images (dùng khi code thay đổi).
- `update`: Kéo (pull) code mới nhất từ tất cả các repository con.
- `status`: Xem trạng thái các containers đang chạy.
- `logs`: Xem logs (thời gian thực) của tất cả services.
- `clean`: **NGUY HIỂM** - Xóa sạch container, network và các volumes (xóa database).

## 📚 Tài Liệu Chi Tiết

- [Kiến trúc hệ thống](docs/architecture.md)
- [Hướng dẫn cài đặt chi tiết](docs/setup-guide.md)