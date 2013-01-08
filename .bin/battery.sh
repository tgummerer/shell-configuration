#!/bin/sh

echo `acpi | sed 's/Battery 0: //' | sed 's/Discharging, //' | sed 's/ remaining//'`
