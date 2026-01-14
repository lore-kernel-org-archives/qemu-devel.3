Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9310CD31A28
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwDh-000287-Ad; Wed, 14 Jan 2026 03:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vfwDd-00027Z-6q
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:27:09 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vfwDa-0003fK-Ig
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:27:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFWBP/H0huTLiAwRDA/Ub4hVKJFjeYpWS0emFlVBTCP1FJ2J/f9oEN2jox3QL7p9RBWzv5en/a3lYudSDLJ9ayxfMBxL5bNi3Ap4+dkNg77BVdEO0JBiGRJ5HRLvJdfHG+hjEUKcsJgZheSXmLi3QLF72F3qyAPXwnq1Dns5vxcX7vJ0JAafSlY3e5mRogqQCJLNnp8oPpVmo7ijG5LdTEtIB3zlGncPQceoA1mZNF0Z4ASdyCmzEVqPUbgP5j1QuKttIo9i/eIBu+zXzzpa0RGCakv4wqqE1DMaUvYrudIRHWICcUK1dwamNNVrXknyAjQgJ210qgUc6wArgddZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AkZnO5y1yZi6qDZi9Ayqyu+QhI1BMDDwRLoeWb81Es=;
 b=xaE1NwJYJqM8ybYkyWa6RwIpd/NUAoU00jM4xI/nQdWleUNZhHIvI4n2FM+OwpL/Y3eOZolIVIzBLGpLOsEuN5b+w0/v1pqlWgSc8Rw8EWNBnL/hj/82Kj5T48ViVh60sCP+mrdzzDDVhucZTWaKq0rARrPdAYLxvpHZo7IDTOIM9ipDM0wThw1AQ4VFszaPT/3d5VIcxPGQ4L7124vQpAWC+tSrMF+Q23xq3kqLvdfFVNqU/8cSWuEu//GJYr5HwHqIBebHZa16+sdkme5Ycv3Guej/3D90DCoOGkgviY0FtLXsJd1MkXW3BFP0gv3LmE2ZlsE34hMEKHcGKXoQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AkZnO5y1yZi6qDZi9Ayqyu+QhI1BMDDwRLoeWb81Es=;
 b=h8p0KTGmwZYZj9CzHepnv/t8pV88sPjdH2vzAq1+9a9BlxLRIOq9CmlcjcuKCgdmw+3BCDIPKxLjFKbHESgncn9r94fffIoKoKAlL+1U905VHQlKc4py29uI7/RSrqJoVKuM9shkn3TpadV/G+tIjvLuPNFUz0sTdxIWhUAwq94=
Received: from PH8PR05CA0024.namprd05.prod.outlook.com (2603:10b6:510:2cc::12)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 08:27:00 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::4c) by PH8PR05CA0024.outlook.office365.com
 (2603:10b6:510:2cc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 08:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Wed, 14 Jan 2026 08:26:59 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 02:26:55 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v5] numa: add 'memmap-type' option for memory type
 configuration
Date: Wed, 14 Jan 2026 16:26:33 +0800
Message-ID: <20260114082633.806629-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114082633.806629-1-FangSheng.Huang@amd.com>
References: <20260114082633.806629-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: cdeff8f4-d691-45fe-ba29-08de5346afbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtvyjBtIgUUe02gSzWqE196U77nexF9Thxx5bwn3mOob8lrd5f9D1LTshInM?=
 =?us-ascii?Q?cJeBCGjkl159zwpMY9Z4xfO5QS5GkhzZV0jvPGQqqjom8g/Ew2tnrFCSA2Ij?=
 =?us-ascii?Q?eIY6xF+QnMSUU2llaKBwOp90EGo099y9o/dpPJBRxMhRDJgV2LoAIt2UB4QA?=
 =?us-ascii?Q?ZbDgyKb/5RzMwjimu9DVWiF38hdMxG9Dg55aA9WOGuw6Dc4NQm9uy8uRo95V?=
 =?us-ascii?Q?mUFQTj3mnIOt25Z0lkvTxuKVcO4e8kgju6gWsv3Sel2CBqqy0HE5XehLTvZ2?=
 =?us-ascii?Q?lbbUSGAKj2Y/pjjEqjVRNdhJv0eauEFIW6BqO4acXBB77G8FvSwsyeADnZ7Z?=
 =?us-ascii?Q?khFlncQUdAeKGT11sxDn6ICjccgZ5Bit2/m9Eba7wqpWuQ2H0zMgIcB0sX7D?=
 =?us-ascii?Q?MrMfIT1FZxX+Gg5OT4vIGbqFBe5KFoQR4IJGWbvJCRyNdGOmK57/Sa+R+Jfb?=
 =?us-ascii?Q?5atta0RRUfvc1TUHoD7TvKvZNqbniKBlSQqmoPL9y9K5lZAQ9coX/Vuki63t?=
 =?us-ascii?Q?x0uoGV+RR77l41DVq3EeREHR4AMotnzXMiSD7y97G6wuNuz+pfgBQhIZh2T/?=
 =?us-ascii?Q?hSYoW3WmcboKKmtAgSaJSoogG4Ei/pUTt4OrDvSQpjbowilIewQM8qgAqiMT?=
 =?us-ascii?Q?gAzdhV/WNhuctpHVdV0qJPrdT2vDMBdwfug/IKJV+gFAz8cH8xy7FNmAo3lO?=
 =?us-ascii?Q?DYZyye93WuYYRs+mqL/zmm15M9cR7zP5KLH93J36KAXzD/wfy+59Pqw+jR2o?=
 =?us-ascii?Q?3WjEOedmsOUFAM5nPuXmSIu5eCTVUPPbYhhLCnBC63TvKCzS4gP5GIIOH3QP?=
 =?us-ascii?Q?Z0chN3LH7HO5Gn07GBcj7Gqk7XqO3r4MHEXgfb4HiSJYYnAOHyj5L9NqSRDf?=
 =?us-ascii?Q?CHpIk+NENTA4T350bgJ1HqA//igFf0NK8aApl3bWJS4lHYdCXg8i+m/oCkPq?=
 =?us-ascii?Q?LmEtS37S+Rff+RN/BsW6huLdwQAyC9YoMaKCnrSRhx18g5eEMONWsazhmxYl?=
 =?us-ascii?Q?8/EPchhDnIj7Q9WYlfildcdL9CHZAvPl8JRi3byd38Y5bAoYZpHFLpLSH/FD?=
 =?us-ascii?Q?wC6R1vlF+kMiuhwDfA4l57lqtq9CXKFJsWwxjELslg9nBQhMN04s/hhcN6hc?=
 =?us-ascii?Q?icdIa1PGYsyORbCIrXg2suljiEiGy8eDDwPnK7bYi0IZ4C9gnI1EPpvIFsVv?=
 =?us-ascii?Q?3oxKiGTq9Wzba8lObfIEBr8+MT6PD4PS4n/h6ILt8FfW1/MxlJ03WF4FLxYu?=
 =?us-ascii?Q?qf5Awp6e2qB9XFoWPedggC+RzcApTVcHa7ZlDkF+V7e1cF0RFxsHbGpEZ0eA?=
 =?us-ascii?Q?17+2R3VVzf5QWwNt36rN98+a6EddKTc0KkvdKz+V6w8neV6V9pqAHAFdSmNx?=
 =?us-ascii?Q?e49jdAPzDGZPZ6CGRUFPY+ZMluiY8MMJuZxWXCmuCTrQmU5UuITAyduzxuzA?=
 =?us-ascii?Q?fuNJ7yEYLrjLQvVHbU7UO5QkiVYZ37tk+TU/DDEK4ZSXkYRa156e8H6tTGDW?=
 =?us-ascii?Q?o+CiBpWyhnUp9ZJ289jJymTKV67/EcK1pUwAqMTicfkt0KmbP6RPpx2sFkAk?=
 =?us-ascii?Q?IhC0c8QMy6yNcHEYMj/tTCc4BZfz29xCHHoTkjs3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:26:59.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeff8f4-d691-45fe-ba29-08de5346afbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add a 'memmap-type' option to NUMA node configuration that allows
specifying the memory type for a NUMA node.

Supported values:
  - normal:   Regular system RAM (E820 type 1, default)
  - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
  - reserved: Reserved memory (E820 type 2)

The 'spm' type indicates Specific Purpose Memory - a hint to the guest
that this memory might be managed by device drivers based on guest policy.
The 'reserved' type marks memory as not usable as RAM.

Note: This option is only supported on x86 platforms.

Usage:
  -numa node,nodeid=1,memdev=m1,memmap-type=spm

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 hw/core/numa.c               | 19 ++++++++++
 hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h | 12 +++---
 hw/i386/pc.c                 | 61 ++++++++++++++++++++++++++++++
 include/system/numa.h        |  7 ++++
 qapi/machine.json            | 24 ++++++++++++
 qemu-options.hx              | 14 ++++++-
 7 files changed, 202 insertions(+), 7 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f462883c87..409b2e2bb9 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -38,6 +38,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/core/boards.h"
 #include "hw/mem/memory-device.h"
+#include "hw/i386/x86.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
@@ -164,6 +165,24 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
     }
 
+    if (node->has_memmap_type && node->memmap_type != NUMA_MEMMAP_TYPE_NORMAL) {
+        if (!object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+            error_setg(errp, "memmap-type=%s is only supported on x86 machines",
+                       NumaMemmapType_str(node->memmap_type));
+            return;
+        }
+        switch (node->memmap_type) {
+        case NUMA_MEMMAP_TYPE_SPM:
+            numa_info[nodenr].memmap_type = NUMA_MEMMAP_SPM;
+            break;
+        case NUMA_MEMMAP_TYPE_RESERVED:
+            numa_info[nodenr].memmap_type = NUMA_MEMMAP_RESERVED;
+            break;
+        default:
+            break;
+        }
+    }
+
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
     ms->numa_state->num_nodes++;
diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
index 3e848fb69c..4c62b5ddea 100644
--- a/hw/i386/e820_memory_layout.c
+++ b/hw/i386/e820_memory_layout.c
@@ -46,3 +46,75 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
     }
     return false;
 }
+
+bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
+{
+    uint64_t end = start + length;
+    assert(!e820_done);
+
+    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
+    if (new_type == E820_SOFT_RESERVED) {
+        bool range_in_ram = false;
+
+        for (size_t j = 0; j < e820_entries; j++) {
+            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
+            uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
+            uint32_t ram_type = le32_to_cpu(e820_table[j].type);
+
+            if (ram_type == E820_RAM && ram_start <= start && ram_end >= end) {
+                range_in_ram = true;
+                break;
+            }
+        }
+        if (!range_in_ram) {
+            return false;
+        }
+    }
+
+    /* Find entry that contains the target range and update it */
+    for (size_t i = 0; i < e820_entries; i++) {
+        uint64_t entry_start = le64_to_cpu(e820_table[i].address);
+        uint64_t entry_length = le64_to_cpu(e820_table[i].length);
+        uint64_t entry_end = entry_start + entry_length;
+
+        if (entry_start <= start && entry_end >= end) {
+            uint32_t original_type = e820_table[i].type;
+
+            /* Remove original entry */
+            memmove(&e820_table[i], &e820_table[i + 1],
+                    (e820_entries - i - 1) * sizeof(struct e820_entry));
+            e820_entries--;
+
+            /* Add split parts inline */
+            if (entry_start < start) {
+                e820_table = g_renew(struct e820_entry, e820_table,
+                                     e820_entries + 1);
+                e820_table[e820_entries].address = cpu_to_le64(entry_start);
+                e820_table[e820_entries].length =
+                    cpu_to_le64(start - entry_start);
+                e820_table[e820_entries].type = original_type;
+                e820_entries++;
+            }
+
+            e820_table = g_renew(struct e820_entry, e820_table,
+                                 e820_entries + 1);
+            e820_table[e820_entries].address = cpu_to_le64(start);
+            e820_table[e820_entries].length = cpu_to_le64(length);
+            e820_table[e820_entries].type = cpu_to_le32(new_type);
+            e820_entries++;
+
+            if (end < entry_end) {
+                e820_table = g_renew(struct e820_entry, e820_table,
+                                     e820_entries + 1);
+                e820_table[e820_entries].address = cpu_to_le64(end);
+                e820_table[e820_entries].length = cpu_to_le64(entry_end - end);
+                e820_table[e820_entries].type = original_type;
+                e820_entries++;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..a85b4fd14c 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -10,11 +10,12 @@
 #define HW_I386_E820_MEMORY_LAYOUT_H
 
 /* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
+#define E820_RAM            1
+#define E820_RESERVED       2
+#define E820_ACPI           3
+#define E820_NVS            4
+#define E820_UNUSABLE       5
+#define E820_SOFT_RESERVED  0xEFFFFFFF
 
 struct e820_entry {
     uint64_t address;
@@ -26,5 +27,6 @@ void e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
 bool e820_get_entry(int index, uint32_t type,
                     uint64_t *address, uint64_t *length);
 int e820_get_table(struct e820_entry **table);
+bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type);
 
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cb074c0a0..d2230966f9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -794,6 +794,64 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
     return pc_above_4g_end(pcms) - 1;
 }
 
+/*
+ * Update E820 entries for NUMA nodes with non-default memory types.
+ */
+static void pc_update_numa_memory_types(X86MachineState *x86ms)
+{
+    MachineState *ms = MACHINE(x86ms);
+    uint64_t addr = 0;
+
+    for (int i = 0; i < ms->numa_state->num_nodes; i++) {
+        NodeInfo *numa_info = &ms->numa_state->nodes[i];
+        uint64_t node_size = numa_info->node_mem;
+
+        /* Process non-normal memory types */
+        if (numa_info->memmap_type != NUMA_MEMMAP_NORMAL &&
+            numa_info->node_memdev) {
+            uint64_t guest_addr;
+            uint32_t e820_type;
+
+            switch (numa_info->memmap_type) {
+            case NUMA_MEMMAP_SPM:
+                e820_type = E820_SOFT_RESERVED;
+                break;
+            case NUMA_MEMMAP_RESERVED:
+                e820_type = E820_RESERVED;
+                break;
+            default:
+                goto next;
+            }
+
+            /* Calculate guest physical address accounting for PCI hole */
+            if (addr < x86ms->below_4g_mem_size) {
+                if (addr + node_size <= x86ms->below_4g_mem_size) {
+                    guest_addr = addr;
+                } else {
+                    error_report("NUMA node %d with memmap-type spans across "
+                                 "4GB boundary, not supported", i);
+                    exit(EXIT_FAILURE);
+                }
+            } else {
+                guest_addr = 0x100000000ULL +
+                            (addr - x86ms->below_4g_mem_size);
+            }
+
+            if (!e820_update_entry_type(guest_addr, node_size, e820_type)) {
+                warn_report("Failed to update E820 entry for node %d "
+                           "at 0x%" PRIx64 " length 0x%" PRIx64,
+                           i, guest_addr, node_size);
+            }
+        }
+
+next:
+        /* Accumulate address for next node */
+        if (numa_info->node_memdev) {
+            addr += node_size;
+        }
+    }
+}
+
 /*
  * AMD systems with an IOMMU have an additional hole close to the
  * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
@@ -910,6 +968,9 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
     }
 
+    /* Update E820 for NUMA nodes with special memory types */
+    pc_update_numa_memory_types(x86ms);
+
     if (!pcmc->has_reserved_memory &&
         (machine->ram_slots ||
          (machine->maxram_size > machine->ram_size))) {
diff --git a/include/system/numa.h b/include/system/numa.h
index 1044b0eb6e..64e8f63736 100644
--- a/include/system/numa.h
+++ b/include/system/numa.h
@@ -35,12 +35,19 @@ enum {
 
 #define UINT16_BITS       16
 
+typedef enum {
+    NUMA_MEMMAP_NORMAL = 0,
+    NUMA_MEMMAP_SPM,
+    NUMA_MEMMAP_RESERVED,
+} NumaMemmapTypeInternal;
+
 typedef struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
     bool has_cpu;
     bool has_gi;
+    NumaMemmapTypeInternal memmap_type;
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
diff --git a/qapi/machine.json b/qapi/machine.json
index 907cb25f75..b7fc8c564f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -464,6 +464,22 @@
 { 'enum': 'NumaOptionsType',
   'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
 
+##
+# @NumaMemmapType:
+#
+# Memory mapping type for a NUMA node.
+#
+# @normal: Normal system RAM (E820 type 1)
+#
+# @spm: Specific Purpose Memory (E820 type 0xEFFFFFFF)
+#
+# @reserved: Reserved memory (E820 type 2)
+#
+# Since: 10.2
+##
+{ 'enum': 'NumaMemmapType',
+  'data': ['normal', 'spm', 'reserved'] }
+
 ##
 # @NumaOptions:
 #
@@ -500,6 +516,13 @@
 # @memdev: memory backend object.  If specified for one node, it must
 #     be specified for all nodes.
 #
+# @memmap-type: specifies the memory type for this NUMA node.
+#     'normal' (default) is regular system RAM.
+#     'spm' is Specific Purpose Memory - a hint to the guest that
+#     this memory might be managed by device drivers based on policy.
+#     'reserved' is reserved memory, not usable as RAM.
+#     Currently only supported on x86.  (since 10.2)
+#
 # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
 #     to the nodeid which has the memory controller responsible for
 #     this NUMA node.  This field provides additional information as
@@ -514,6 +537,7 @@
    '*cpus':   ['uint16'],
    '*mem':    'size',
    '*memdev': 'str',
+   '*memmap-type': 'NumaMemmapType',
    '*initiator': 'uint16' }}
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index ec92723f10..4da17cbefb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -433,7 +433,7 @@ ERST
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
-    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
+    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node][,memmap-type=normal|spm|reserved]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
     "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
     "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
@@ -442,7 +442,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
 SRST
 ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
   \ 
-``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
+``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator][,memmap-type=type]``
   \
 ``-numa dist,src=source,dst=destination,val=distance``
   \ 
@@ -510,6 +510,16 @@ SRST
     largest bandwidth) to this NUMA node. Note that this option can be
     set only when the machine property 'hmat' is set to 'on'.
 
+    '\ ``memmap-type``\ ' specifies the memory type for this NUMA node:
+
+    - ``normal`` (default): Regular system RAM (E820 type 1)
+    - ``spm``: Specific Purpose Memory (E820 type 0xEFFFFFFF). This is a
+      hint to the guest that the memory might be managed by device drivers
+      based on guest policy.
+    - ``reserved``: Reserved memory (E820 type 2), not usable as RAM.
+
+    This option is only supported on x86 platforms.
+
     Following example creates a machine with 2 NUMA nodes, node 0 has
     CPU. node 1 has only memory, and its initiator is node 0. Note that
     because node 0 has CPU, by default the initiator of node 0 is itself
-- 
2.34.1


