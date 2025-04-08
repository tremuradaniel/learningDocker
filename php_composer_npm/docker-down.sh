#!/bin/bash
docker-compose -f docker-compose.backend.yaml down

sudo rm -rf src/*
# TODO: bring down the frontend as well.
