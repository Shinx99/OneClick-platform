#!/bin/bash

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Bắt đầu cấu hình và build môi trường ===${NC}"

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Lỗi: Docker chưa được cài đặt.${NC}"
    exit 1
fi

# Check for Docker Compose (docker-compose or docker compose)
DOCKER_COMPOSE_CMD=""
if docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
else
    echo -e "${RED}Lỗi: Docker Compose chưa được cài đặt.${NC}"
    exit 1
fi

# Create network if not exists
NETWORK_NAME="oneclick-network"
if ! docker network ls | grep -q "$NETWORK_NAME"; then
    echo -e "${YELLOW}Tạo network: $NETWORK_NAME...${NC}"
    docker network create "$NETWORK_NAME"
else
    echo -e "${GREEN}Network $NETWORK_NAME đã tồn tại.${NC}"
fi

# Create .env from .env.example if not exists
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        echo -e "${YELLOW}Tạo file .env từ .env.example...${NC}"
        cp .env.example .env
    else
        echo -e "${RED}Cảnh báo: Không tìm thấy file .env.example.${NC}"
    fi
else
    echo -e "${GREEN}File .env đã tồn tại.${NC}"
fi

echo -e "${GREEN}Đang build Docker images...${NC}"
$DOCKER_COMPOSE_CMD build

echo -e "${GREEN}=== Hoàn tất build môi trường ===${NC}"
