#!/bin/bash

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== Dừng toàn bộ services OneClick Platform ===${NC}"

DOCKER_COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
fi

echo -e "${YELLOW}Đang dừng các containers...${NC}"
$DOCKER_COMPOSE_CMD stop

echo -e "${YELLOW}Bạn có muốn xóa containers, networks, và volumes không? (y/N)${NC}"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${YELLOW}Đang dọn dẹp hệ thống...${NC}"
    $DOCKER_COMPOSE_CMD down -v
    echo -e "${GREEN}Đã dọn dẹp xong.${NC}"
else
    echo -e "${GREEN}Đã dừng services. Các containers vẫn được giữ lại.${NC}"
fi
