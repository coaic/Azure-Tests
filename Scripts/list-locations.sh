#!/bin/bash
#
az account list-locations --query '[].name' -o tsv
