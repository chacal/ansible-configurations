#!/usr/bin/env bash
LIST_CMD='qm list | tail -n+2 | grep running | grep -v pfsense | awk "{print \"\42\" \$2 \"\42\"}" | paste -d, -s'
WARIO_VMS=$(ssh wario.chacal.fi sudo ${LIST_CMD})
FUJARI_VMS=$(ssh fujari.chacal.fi ${LIST_CMD})

echo "{"
echo "  \"all\": {"
echo "    \"hosts\": ["
echo $WARIO_VMS,$FUJARI_VMS
echo "    ]"
echo "  }"
echo "}"
