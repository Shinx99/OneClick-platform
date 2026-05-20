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
    echo "  start   - Clone toàn bộ các services (nếu chưa có)"
    echo "  update  - Kéo code mới nhất (git pull) từ tất cả các repo"
    echo ""
}

start_services() {
    echo -e "${CYAN}[1/2] Đang clone mã nguồn...${NC}"
    bash ./oneclick-clone.sh
    
    echo -e "${CYAN}[2/2] Hoàn tất!${NC}"
    echo -e "${GREEN}Tất cả các services đã được clone vào thư mục ./services/${NC}"
    echo ""
    echo -e "${YELLOW}Vui lòng vào từng thư mục để setup môi trường và chạy dự án theo README của mỗi service.${NC}"
}

case "$1" in
    start)
        print_banner
        start_services
        ;;
    update)
        print_banner
        bash ./oneclick-clone.sh
        ;;
    *)
        print_banner
        show_help
        ;;
esac
