#!/usr/bin/env bash
LIST_CMD="qm list | tail -n+2 | grep running | grep -v pfsense | awk '{print \$2}'"
WARIO_VMS=$(ssh wario.chacal.fi "sudo ${LIST_CMD}")
FUJARI_VMS=$(ssh fujari.chacal.fi "${LIST_CMD}")

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
