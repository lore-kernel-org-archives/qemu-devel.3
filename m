Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82536CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvE-0006GN-Ns; Tue, 23 Jun 2026 03:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv9-0006Fe-WD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:48 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv8-0000hV-2p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtJbDEvsEelxghgYKMEnBfyL3n3AF+Gj0wDPtjV3XrOfylYqtTaZL9c2GOQmvTylU2A/ucTHr0yZaWQ3AF5qi1HgwwP+CUX48tus1UWGuWASVm5XB6nRRUWGgjQV4KZOmiyR/JjhU1mAUIwrd98h1EBnAICFTaa9dYYHfGpDGV2F8Lh+0M4sR92ExJ5plC5nBaxrI9BaIM3+gfS9958cf3HrPqNc7XCzWM5FY7vm5cT0Bo36OdwOfvtlyISlpbwcRgZXGCwSAmm7CjQYAsPjmGHHdXRNKyyBh34u+cKgyAIVy6TerhCmRFpyO325F8Sc665RVQQEl2xrt2L/lp/RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLr26veEEN6L5LsbtaQLzbD1Y8Kev6iUaUeI+r4jQ8E=;
 b=P4j/aJnKWN040V555EPE3YFfL0WduQ26NT/lL4YRkm1YYZt+HPWK6YzrTNcId/Y6LCmt9gbeOnr91ZNHYavq1VtqjGNyNF4ro+pNzYOqnBob88Ci6trdeGNUKn8XLNt0R08ny1eZquahIFs+SkIT5MwpTeZAloMVi9gXrs2+lYAEl2JTkVIqNLoL25Xh99yWe5jh1IpqPAxq5za7fICVqwRmK5zbZHhIKVtPQ2euw1rgCqisig/NlBWJbSO6iMWTWXS9iqMcsZ8K/KhOJF6vOL4VMdAIsxnLF9rYRRniqzkWj9n0LEi5izDfRIt2zWG43wi/Ikeph8EMoDXam6BNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLr26veEEN6L5LsbtaQLzbD1Y8Kev6iUaUeI+r4jQ8E=;
 b=VhsBNpK/NJZgVpvX6HXyDFrG+cS8GTHpxKaNcYy3f4kbqPz7dulzslsZ1jb3ZkUWJ6WxFDy4IAI/XHbQNpotQfo2zl2NxncXPh/A0MAiR9K5bM379ualrJOekt7E12tu+R4Ov9dHEzD3x+hn2uFrr406F34Jm/o+NQviPMzFxjI=
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:51:35 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::4c) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 07:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:34 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:31 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 03/10] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
Date: Tue, 23 Jun 2026 15:50:44 +0800
Message-ID: <20260623075051.3797975-4-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 327cd9a5-409a-4a72-08a9-08ded0fc3f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006|6133799003|43062017;
X-Microsoft-Antispam-Message-Info: NlgjcQmKhgayR3/9CxD4d2Th7aBHb34tyStIrmyWIEY/FcwOJkBCaj3J8U6tN5l629p8zQjro8ZftBbrvemWJR+OYrt7ekK/+RUHUXW7y3tPXIxNy4oKJW3E0dCW/fnvhmGYaa0R9NfusLcQaYosNEzAsDsHYEBYwFo/uuOhSPlgdokKg1UVJc3eHRaa/8wgiGAjQRt+a8+HKjNoPi5LuXXB9M627NokJMX/wscy7S2s3Gr6ONJlMndtHndGCec5oyxy+mwTO1AugYpcA2DBz/kXBDyO2i1CV+pc9YJx33Q2RDvkMchZKgudclMBHHGPdftK0owbnN1toGBzekzxRIYhgdqkVPIv7Ve1I3g2lldPjS5eblvWx0wcdvdtZy+4xqNo2DNY9+6lHUBt9RZ/V+JoKprOOdib45fCzeydyQbuoC9jnwQDHZjYG0CbZ7uKBwREYLc98vnS4I7fVGhHOwZEKHRJdud24rlGrpByWymIC2Jt3ZeYyv8Rhwz1qM7YlACZuiAVgTFL9lukulsmykmQUS9URZm/2JI1iGR0PYjdAkpZJWIp9ktDutudmpwMfQ56pMSpThPbE/xDYudKgl5K9cWyYJH/DqcRxqxyoDD6lfL9XpTsGwYztofVDmRN76cbEz3RcGaPN+zylTgsmkLgRI3w28BS6m5svzOtQUd/o+6x/fBIvU0Zo5r3TFdmx/FoCwfFgYuru3ujM1GMPfa1sfHiu/QelQ5I5wxO/tS0+3zfeRs7TQe0QMtCqnrV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LJIpvtzCVQjc3PGr3xIsx4KVHA6opxQJKEpwvK0npg4VBis/amekd1G+vO6rTJj6Vfhvwov4iGk1k7bXmEVPywl7ol8VU9xNTFDtEODJuv56k81nbQJQWp/wpghDi3mzW89l5gr3cnZuY0QzdRGEU0oaCQ4uO0rJqoLtzgGQofQ4eqFVi0lhFnh6CftlwgfLbZtm2POzqk4DNHSwy84rnWXoDVLRoHqjKJVa+A8gFwXHCw62s58v9PP1EuZpOy6CwHaxAEt4LYurN+8rUE7io8muqxjSHxW2519iKz8206aS1durw/b+2J7EsMqBFFmGsoXhpp8DMvNfEfp7hYi41FzSpmqlhLXaf6QQ1GfLkCgXxhjeyhDs/0FlM01RkCwy7ncBi3niaNohQmxaeRK48tzoQ6X7joF/TnDEo8J7NTshq/0kqb3pouqb93OenGTI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:34.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327cd9a5-409a-4a72-08a9-08ded0fc3f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
placeholders at the highest PXM, preserving the existing umbrella
convention.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 96 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2ee061558c..8837b69687 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -52,6 +52,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/sp-mem.h"
 #include "system/numa.h"
 #include "system/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -1351,6 +1352,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 }
 #endif
 
+typedef struct {
+    uint64_t addr;
+    uint64_t size;
+    uint32_t node;
+} SpMemRange;
+
+static int sp_mem_collect_ranges_cb(Object *obj, void *opaque)
+{
+    GArray *ranges = opaque;
+    SpMemDevice *spm;
+    MemoryDeviceClass *mdc;
+    SpMemRange r;
+
+    if (!object_dynamic_cast(obj, TYPE_SP_MEM)) {
+        return 0;
+    }
+    spm = SP_MEM(obj);
+    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
+    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
+    r.size = memory_region_size(
+                 host_memory_backend_get_memory(spm->hostmem));
+    r.node = spm->node;
+    g_array_append_val(ranges, r);
+    return 0;
+}
+
+static gint sp_mem_range_compare(gconstpointer a, gconstpointer b)
+{
+    const SpMemRange *range_a = a;
+    const SpMemRange *range_b = b;
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
+ * For each plugged TYPE_SP_MEM device, emit an ENABLED entry at the
+ * device's own proximity_domain.  All remaining sub-ranges (gaps
+ * between sp-mem devices, leading and trailing padding, and ranges
+ * occupied by other memory devices) are covered by HOTPLUGGABLE |
+ * ENABLED placeholder entries at PXM = nb_numa_nodes - 1.
+ */
+static void build_srat_device_memory(GArray *table_data, MachineState *ms)
+{
+    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpMemRange));
+    uint32_t hotplug_pxm = ms->numa_state->num_nodes - 1;
+    uint64_t region_start, region_end;
+    guint i;
+
+    region_start = ms->device_memory->base;
+    region_end = region_start + memory_region_size(&ms->device_memory->mr);
+
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   sp_mem_collect_ranges_cb, ranges);
+    g_array_sort(ranges, sp_mem_range_compare);
+
+    for (i = 0; i < ranges->len; i++) {
+        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
+
+        if (region_start < r->addr) {
+            build_srat_memory(table_data, region_start, r->addr - region_start,
+                              hotplug_pxm,
+                              MEM_AFFINITY_HOTPLUGGABLE |
+                              MEM_AFFINITY_ENABLED);
+        }
+        build_srat_memory(table_data, r->addr, r->size, r->node,
+                          MEM_AFFINITY_ENABLED);
+        region_start = r->addr + r->size;
+    }
+
+    /*
+     * Cover the rest of the device_memory window that no sp-mem device
+     * occupies. Keeping it HOTPLUGGABLE preserves the umbrella entry's
+     * role for future pc-dimm / virtio-mem hot-add into this window.
+     */
+    if (region_start < region_end) {
+        build_srat_memory(table_data, region_start, region_end - region_start,
+                          hotplug_pxm,
+                          MEM_AFFINITY_HOTPLUGGABLE |
+                          MEM_AFFINITY_ENABLED);
+    }
+}
+
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
@@ -1487,10 +1578,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * providing _PXM method if necessary.
      */
     if (machine->device_memory) {
-        build_srat_memory(table_data, machine->device_memory->base,
-                          memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+        build_srat_device_memory(table_data, machine);
     }
 
     acpi_table_end(linker, &table);
-- 
2.34.1


