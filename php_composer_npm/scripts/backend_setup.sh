#!/bin/bash
function backendSetup() {
    echo -e "${YELLOW}Setting up backend${NC}"

    echo -e "${YELLOW}git setup${NC}"
    docker-compose -f docker-compose.backend.yaml exec php git config --global user.name "${GIT_USERNAME}"
    docker-compose -f docker-compose.backend.yaml exec php git config --global user.email "${GIT_EMAIL}"


    backend_path="/var/www/${APP_NAME}"

    echo "path"
    echo $backend_path  

    # Check if the backend folder is created
    if [ -d "$backend_path" ] && [ "$(ls -A $backend_path)" ]; then
        echo -e "Backend already set. No action needed."
    else
        # Ask the user for the application name
        read -p "Enter the name of your new app: " app_name

        # Create the project (for example, using Symfony CLI or a similar tool)
        echo "Creating project $app_name..."
        
        # Run the command to create the app (e.g., using Symfony CLI)
        docker-compose -f docker-compose.backend.yaml exec php symfony new "$backend_path/$app_name"

        echo "Project $app_name created successfully!"
    fi
}