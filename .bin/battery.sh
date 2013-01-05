#!/bin/sh

echo `acpi | sed 's/Battery 0: Discharging,//'`
