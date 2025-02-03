#!/bin/bash
source scripts/sh_helper.sh
source scripts/config.sh
source scripts/backend_setup.sh
source scripts/frontend_setup.sh
source .env

echo -e "${YELLOW}docker-compose -f docker-compose.backend.yaml up --build -d ${NC}"
docker-compose -f docker-compose.backend.yaml up --build -d

# initial backend setup
backendSetup
frontendSetup

echo -e "${YELLOW}DONE!${NC}"