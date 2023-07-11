#!/bin/bash

for vm_id in $(az resource list --resource-type "Microsoft.Compute/VirtualMachines" --query "[?tags.env==""dev].id" --output "json")

do

  echo "list of instances vm with id ${vm_id}"
  az vm list --show-details "${vm_id}" -o "json"

done 