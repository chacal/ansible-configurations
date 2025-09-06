#!/usr/bin/env bash
LIST_CMD='qm list | tail -n+2 | grep running | grep -v pfsense | grep -v wg-endpoint | awk "{print \"\42\" \$2 \"\42\"}" | paste -d, -s'
HESSU_VMS=$(ssh hessu.chacal.fi sudo ${LIST_CMD})
FUJARI_VMS=$(ssh fujari.chacal.fi ${LIST_CMD})

echo "{"
echo "  \"all\": {"
echo "    \"hosts\": ["
echo $HESSU_VMS,$FUJARI_VMS
echo "    ]"
echo "  }"
echo "}"
