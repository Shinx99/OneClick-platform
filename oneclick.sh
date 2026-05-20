#!/bin/bash

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print Banner
print_banner() {
    echo -e "${CYAN}"
    echo "  ___             ____ _ _      _       ____  _       _    __                     "
    echo " / _ \ _ __   ___/ ___| (_) ___| | __  |  _ \| | __ _| |_ / _| ___  _ __ _ __ ___ "
    echo "| | | | '_ \ / _ \ |   | | |/ __| |/ /  | |_) | |/ _\` | __| |_ / _ \| '__| '_ \` _ \\"
    echo "| |_| | | | |  __/ |___| | | (__|   <   |  __/| | (_| | |_|  _| (_) | |  | | | | | |"
    echo " \___/|_| |_|\___|\____|_|_|\___|_|\_\  |_|   |_|\__,_|\__|_|  \___/|_|  |_| |_| |_|"
    echo -e "${NC}"
    echo -e "${BLUE}================================================================================${NC}"
    echo -e "${GREEN}                  Master Control Script - OneClick Platform                     ${NC}"
    echo -e "${BLUE}================================================================================${NC}"
    echo ""
}

DOCKER_COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
fi

show_help() {
    echo -e "${YELLOW}Cách sử dụng:${NC} ./oneclick.sh [command]"
    echo ""
    echo -e "${GREEN}Các lệnh khả dụng:${NC}"
    echo "  start   - Clone (nếu chưa có), tạo network, build và khởi động toàn bộ services"
    echo "  stop    - Dừng toàn bộ services (sẽ hỏi trước khi dọn dẹp)"
    echo "  restart - Khởi động lại toàn bộ services"
    echo "  build   - Chỉ build Docker images"
    echo "  status  - Xem trạng thái các containers"
    echo "  logs    - Xem logs của toàn bộ hệ thống"
    echo "  update  - Cập nhật code mới nhất từ các repo"
    echo "  clean   - Xóa toàn bộ containers, network và volumes"
    echo ""
}

start_services() {
    echo -e "${CYAN}[1/4] Kiểm tra mã nguồn...${NC}"
    bash ./oneclick-clone.sh
    
    echo -e "${CYAN}[2/4] Cấu hình và Build...${NC}"
    bash ./oneclick-build.sh
    
    echo -e "${CYAN}[3/4] Khởi động services...${NC}"
    $DOCKER_COMPOSE_CMD up -d
    
    echo -e "${CYAN}[4/4] Hoàn tất!${NC}"
    echo -e "${GREEN}Hệ thống đang chạy ngầm. Dưới đây là các đường dẫn truy cập:${NC}"
    echo -e "  - Auth Frontend:        ${BLUE}http://localhost:3000${NC}"
    echo -e "  - Eureka Server:        ${BLUE}http://localhost:8761${NC}"
    echo -e "  - API Gateway:          ${BLUE}http://localhost:8080${NC}"
    echo -e "  - Auth Service:         ${BLUE}http://localhost:8081${NC}"
    echo -e "  - Recruitment Service:  ${BLUE}http://localhost:8082${NC}"
    echo -e "  - MinIO Console:        ${BLUE}http://localhost:9001${NC}"
    echo ""
    echo -e "${YELLOW}Dùng lệnh './oneclick.sh logs' để xem log hệ thống.${NC}"
}

case "$1" in
    start)
        print_banner
        start_services
        ;;
    stop)
        bash ./oneclick-stop.sh
        ;;
    restart)
        bash ./oneclick-stop.sh
        start_services
        ;;
    build)
        bash ./oneclick-build.sh
        ;;
    status)
        $DOCKER_COMPOSE_CMD ps
        ;;
    logs)
        $DOCKER_COMPOSE_CMD logs -f
        ;;
    update)
        bash ./oneclick-clone.sh
        ;;
    clean)
        echo -e "${RED}Cảnh báo: Hành động này sẽ xóa toàn bộ data (Database, Minio).${NC}"
        echo -e "${YELLOW}Bạn có chắc chắn muốn xóa? (y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            $DOCKER_COMPOSE_CMD down -v
            echo -e "${GREEN}Đã xóa toàn bộ containers, network và volumes.${NC}"
        else
            echo -e "${GREEN}Đã hủy thao tác.${NC}"
        fi
        ;;
    *)
        print_banner
        show_help
        ;;
esac
