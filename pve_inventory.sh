#!/usr/bin/env bash
WARIO_VMS=$(ssh wario.chacal.fi "sudo qm list | tail -n+2 | grep running | awk '{print \$2}'")
FUJARI_VMS=$(ssh fujari.chacal.fi "qm list | tail -n+2 | grep running | awk '{print \$2}'")

echo "{"
echo "  \"all\": {"
echo "    \"hosts\": ["
while IFS= read -r line; do
    echo "      \"$line\","
done <<< "${WARIO_VMS}"
while IFS= read -r line; do
    echo "      \"$line\","
done <<< "${FUJARI_VMS}"
echo "    ]"
echo "  }"
echo "}"
