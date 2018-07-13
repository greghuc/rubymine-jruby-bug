#!/usr/bin/env bash

# Output software versions

echo -e "\n"
echo "========="
echo "== Box =="
echo "========="
echo "Processors: $(grep 'model name' /proc/cpuinfo | wc -l)"
echo "Memory:     $(grep MemTotal /proc/meminfo | sed -re 's/^MemTotal:\s+//g')"

echo -e "\n"
echo "========"
echo "== OS =="
echo "========"
echo "$(lsb_release -a)"

echo -e "\n"
echo "=========="
echo "== Java =="
echo "=========="
echo "$(java -version 2>&1)"

echo -e "\n"
echo "=========="
echo "== Ruby =="
echo "=========="
echo "$(rbenv versions)"

