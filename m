Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482DACD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKlF-00038l-II; Tue, 02 Jun 2026 04:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKlD-00037Z-Mm
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:07 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKl8-0004P4-LJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPIpHoZGTRa20xyccPAX+UejdYB11HFsl87k17RLDOUD5crgGO56zjKDqkB2TgAnZsQmtV+rNjGyXnc4oUixrKV8nBhuTzIUGhf6Jd9uZCStYXL0uDf/DXJVIMumRyiypqk/aar+or5eD30zY/TDB3wzFP1EgmDB2lxIDmWp1ZHWn2ltdbZWfK0pbLlBl6BkhmcZb27Ft6zgub634CHbspOn94HWIIcegYykT3tVSZmu1XgHfz8hHud1xMbeWz4NboKlXDvNLa/S+oKFlQoSTIkNhAMZZDBYrhTLxU8g4EMuMsWlrKuz5jby8U64hEEZIN87ItgQYMoe2LDTGluTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiHfKO1EzROq2cGVjN/AEvULKHJcjaKm4u9uTgX2dHE=;
 b=k7ezij6NEu5JIsmLclTQ0Fy4wnt3CzI5+CIY4j/HDj2JuHApqlYm8mFhbBkEWPJgxAHZq+bXn72kHojbG3Bemt/2N3YL5gai9ntJAMTRcCTApFnbK7RiXi9rHrVwUK8uFCdY16+bliEkWs7y8CCTXjhlviiySh1NUCndloMnKhwF1JtMkMa9SsENL37q4BuLY305t8b7dLDyS4Qgvu9uddKygvGhCS8YJMrClG9Y4JmzFTObZ6lfag2UtN5Rsb0s5tIykALw1RxqYKY417KUONqoJ+4TmI5h3R7gHx0rs+d83OHvgMTEElrH57ys+UFnGb53tUXLtKDjkUM+r6EZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiHfKO1EzROq2cGVjN/AEvULKHJcjaKm4u9uTgX2dHE=;
 b=nhoOc1k1XbWspraeXLHE/lrtKFq5FlpImIQhbozTJ9cMTIPxfjz9ivsr5c5jalzbplwORIBbs772NdrYgrt7+YGkykdV8fC4ir3mjZurUNdRhnL+nkIzuL1IOy6LZfY+9z/Jjh+y7t3lIr5gBIz3y0iDrbrQUcAP7Ibz/WcQZo8=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 08:45:53 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::41) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 08:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:45:53 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:45:50 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v9 2/4] i386/acpi-build: partition device_memory SRAT umbrella
 for SPM
Date: Tue, 2 Jun 2026 16:44:45 +0800
Message-ID: <20260602084447.1100554-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cd31f5-b0f9-4b0f-c2a4-08dec0835ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|6133799003|11063799006|3023799007|18002099003|56012099006|22082099003|43062017;
X-Microsoft-Antispam-Message-Info: EecWunHazcWQCHSfxJJXfX4eBlBct8r7nkhxQeYbgP4hsaZXb+QorXMRiXk1W0aJbIUfe+9IWLxH+kxlqV2wMpvLhyqMTQu8cCi0cAkF4sHToYWBbeKr5xmyltcuGD/Srq6HW6Es551/I9cwK+CWXceGNELehMakZ8SJgtRFN3nzVOhg8Sf8/geVQdus4pyw91q3PY6j3QXE+xEZfI1NoNW62XU4e16x0uKrl45jNL/hvJdbrsxRH+IT8imMUywe2QGRiylnZduCxZkg68fmypIQy6TatHFFXQAI4chuaelnlQW7H1/An+mixAQMxSpoGlt69XG1Nbl83F7qrGU5txUR5PmPMrQFsTQzMJsrmWBKdPp8a3RMRcWueLhJu1yOVNFx7IFkDc1ABLNWnlF/dySeVqyakwrkWHjqaBaEDe51op4b7gEkDVGCTgOdCndtyESbjBSqFmk7QRqWvMPKw08HgKXGFztaA2R0g4G9zi3oJQiWqwMMd1NwWeuQpKhD0dxBoii2FIP73GTUmFr3NYbZk0PHp2r5RNNH94ehrsLt/HvtnXnPWtSzXvFjB9uZy6T6Tv5+sWGk2aHaHIhsHt6qLQH94BzEJIa7ywYWse1aH3Jhs/l9lCBM33bea6pce+Oo7I6qp/Xms8K00nMxG3WjfjzcxDwwsnUP4BePORc+V25X0Kxqv1XY/eDUUcuo+IJTZvzRGUhtinMf8nsWw/gKKgPm4l/bwax3lcxe/zEvbvpcRnpY/D7+H1mUESNHfRTFLxBY6fC1npwlXoT4sur3jZlxi391C0z3LPMixIc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(11063799006)(3023799007)(18002099003)(56012099006)(22082099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o1JvQ3+edxyyBhMCIOZLwntKOFLwq6wH9HbpWl0FQ06y5ZJT1tCewZbgNqVyMah/T1xyvGD+jFgfip1qGhvWi3IpfB8f+OWGWPqD9hR0ttbEFlvLMmyoZtf1VsZKWVQq1ISqSYF5/R2g0nfHAv6U/8UfoQp0dDsfBORrVmMuRSj3mySJGFTYOakXzXKYpf4zV1G9zXnH0c6cADkKoPnPmxR+w/9dcENKfqTD5S5In82rlEqwWcp3sikN/Ca7jhWmt0Wr+LEPzopX3VQYsduUkQYRDUnAYObuHGO2MQhpj8Tsd+M2L/rArvjec3NGiRf9UTtAkblsuqmKw5TqIl/ydScXUYF4aewyMytkHZlMk23MGB3HBeL1Spd4A4THR2suUNn9k8XdeNdi9g9uYko5LRTqF4m3yZEbV0LuWf98A2gvUbPpvHYxmAHjnRyDOwFH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:45:53.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cd31f5-b0f9-4b0f-c2a4-08dec0835ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Restructure the device_memory SRAT umbrella entry into a per-kind
partition: each TYPE_SPM_MEMORY device gets an ENABLED entry at its
own proximity_domain; the remaining sub-ranges get HOTPLUGGABLE |
ENABLED placeholders at the highest PXM, preserving the upstream
convention required by Windows hotplug and Linux SWIOTLB.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 hw/i386/acpi-build.c | 98 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0d7c83d5e9..17de9768a1 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -52,6 +52,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/spm-memory.h"
 #include "system/numa.h"
 #include "system/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -1346,6 +1347,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 }
 #endif
 
+typedef struct {
+    uint64_t addr;
+    uint64_t size;
+    uint32_t node;
+} SpmRange;
+
+static int collect_spm_ranges_cb(Object *obj, void *opaque)
+{
+    GArray *ranges = opaque;
+    SpmMemoryDevice *spm;
+    MemoryDeviceClass *mdc;
+    SpmRange r;
+
+    if (!object_dynamic_cast(obj, TYPE_SPM_MEMORY)) {
+        return 0;
+    }
+    spm = SPM_MEMORY(obj);
+    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
+    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
+    r.size = memory_region_size(
+                 host_memory_backend_get_memory(spm->hostmem));
+    r.node = spm->node;
+    g_array_append_val(ranges, r);
+    return 0;
+}
+
+static gint spm_range_compare(gconstpointer a, gconstpointer b)
+{
+    const SpmRange *range_a = a;
+    const SpmRange *range_b = b;
+
+    if (range_a->addr < range_b->addr) {
+        return -1;
+    }
+    if (range_a->addr > range_b->addr) {
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * Emit SRAT memory-affinity entries covering the device_memory region.
+ *
+ * For each plugged TYPE_SPM_MEMORY device, emit an ENABLED entry at the
+ * device's own proximity_domain.  All remaining sub-ranges (gaps between
+ * SPM devices, leading and trailing padding, ranges occupied by non-SPM
+ * memory devices) are covered by HOTPLUGGABLE|ENABLED placeholder entries
+ * at PXM = nb_numa_nodes - 1.
+ */
+static void build_srat_device_memory(GArray *table_data, MachineState *ms)
+{
+    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpmRange));
+    uint64_t cursor, end;
+    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
+    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;
+    guint i;
+
+    if (!ms->device_memory) {
+        return;
+    }
+
+    cursor = ms->device_memory->base;
+    end = cursor + memory_region_size(&ms->device_memory->mr);
+
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   collect_spm_ranges_cb, ranges);
+    g_array_sort(ranges, spm_range_compare);
+
+    for (i = 0; i < ranges->len; i++) {
+        SpmRange *r = &g_array_index(ranges, SpmRange, i);
+
+        if (cursor < r->addr) {
+            build_srat_memory(table_data, cursor, r->addr - cursor,
+                              hotplug_pxm,
+                              MEM_AFFINITY_HOTPLUGGABLE |
+                              MEM_AFFINITY_ENABLED);
+        }
+        build_srat_memory(table_data, r->addr, r->size, r->node,
+                          MEM_AFFINITY_ENABLED);
+        cursor = r->addr + r->size;
+    }
+
+    if (cursor < end) {
+        build_srat_memory(table_data, cursor, end - cursor,
+                          hotplug_pxm,
+                          MEM_AFFINITY_HOTPLUGGABLE |
+                          MEM_AFFINITY_ENABLED);
+    }
+}
+
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
@@ -1481,12 +1572,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * Memory devices may override proximity set by this entry,
      * providing _PXM method if necessary.
      */
-    if (machine->device_memory) {
-        build_srat_memory(table_data, machine->device_memory->base,
-                          memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-    }
+    build_srat_device_memory(table_data, machine);
 
     acpi_table_end(linker, &table);
 }
-- 
2.34.1


