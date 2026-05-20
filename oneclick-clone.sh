#!/bin/bash

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Bắt đầu quá trình clone/update services ===${NC}"

# Check for git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Lỗi: Git chưa được cài đặt. Vui lòng cài đặt Git trước khi tiếp tục.${NC}"
    exit 1
fi

SERVICES_DIR="./services"
mkdir -p "$SERVICES_DIR"

REPOS=(
    "https://github.com/Shinx99/OneClick-authService-be.git"
    "https://github.com/Shinx99/OneClick-authService-fe.git"
    "https://github.com/Shinx99/OneClick-recruitmentService-be.git"
    "https://github.com/Shinx99/OneClick-gatewayService.git"
)

for REPO in "${REPOS[@]}"; do
    # Lấy tên repo từ URL
    REPO_NAME=$(basename "$REPO" .git)
    TARGET_DIR="$SERVICES_DIR/$REPO_NAME"
    
    if [ -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}Repo $REPO_NAME đã tồn tại. Đang cập nhật (git pull)...${NC}"
        cd "$TARGET_DIR" || exit
        git pull
        cd ../../
    else
        echo -e "${GREEN}Đang clone $REPO_NAME...${NC}"
        git clone "$REPO" "$TARGET_DIR"
    fi
done

echo -e "${GREEN}=== Hoàn tất quá trình clone/update services ===${NC}"
