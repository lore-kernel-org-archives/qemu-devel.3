Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AF9CF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7w-0002F0-Ms; Mon, 26 Jan 2026 05:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7Q-00011u-1S; Mon, 26 Jan 2026 05:46:52 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7O-0005iJ-0L; Mon, 26 Jan 2026 05:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTMb76Vt4TEUbIx9ykum65x+K40T85WS41AixI5jGjEy6tl39u7ji91lpPSipo+rrr7swsPhJE+ZrpIhcpkhFYfGT7DmI++pN+QXAfoz40LXaxRptB7aobUcRYhXOiW1noLtUa8axc40ttA4Eh0aS+YrrtnOJTevJxy17/32raf243umBCNy0eYlmNrojhlK6Mun5RpkvkIUeIGgiXYZ8S8/qeP+IG6BDhWtY5sXI9B4LGxloAwpb6ST4z1ddnj+6P6NRlqecEe9kh+Uxeg9tTaQDcXMUuIWTV+Ql/H5LP6Ev6taSWUtCefuLGuddZ0mjPAUKMj1Jroq8m2hwPPfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC6Crp8vDp2anvqfGe5iDEqRDEbEjq5GvJe7vLQhGkk=;
 b=w6e/RnTuO0zG1+h21iIX96hncudfxs+5sUTWXzGn7SREvQG0uwWkFTjH83A6oHsqQlS2DCTpQCwvOV43zXgGfKTRfoX8MCh+pkzraPxOEEwKSxNzcDUMavooRY2R4xgvQo+ZYKZaAg2Q2nlTnjwTPIR/XInGITFxJ6x1IFhCz7qtSC5axTMtYnAi0EnbhFk2BKgbI63YKRG5ntXx7m97zwkNlrULQF52hOQ5FeTXhuaso6leLY5gL2xh0C/KgyZ5WtIQIlAR0Co8HIyY5wyoLjVyN59R9z6km3L7uAsMtymAOKX0MJacr1bBrbi78A3JhQ0WcEpD6mT5xzfOqul2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC6Crp8vDp2anvqfGe5iDEqRDEbEjq5GvJe7vLQhGkk=;
 b=dExc1dOS17MBlgC936sgJ3jV5nLSbL69E00+69yZvVE9zrnOE6MZi+hDeKx01BKcl40ukvm+K2XnHbVGFzqxbq7fwRZSNh+ltyTSjq8GVfSPTm8iSeH2sdf7zANF47IPUxNyQkSIFRBeBomWcvauznfAmSDzyiUJ3caoPO/2kPLJbRhQl1X8/LJzp459XGUTKAE0g+ydpTx7f538lLF5AQTjaHq7DsmgZzEHAhAl06MoE5zXk4garnjJwxwWRQRDykKF18FWaJTtygAlWrhuZXw5uNWGrFcNbwG1ua/kRASMMkYxAVkaGPQHN6HV4cYjt+1qXkDWl7goJti+lR+r7g==
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:43 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::9c) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:46:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:35 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:30 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Subject: [PATCH v9 25/37] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Date: Mon, 26 Jan 2026 10:43:22 +0000
Message-ID: <20260126104342.253965-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4e56e9-592f-48f3-2183-08de5cc83205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBr1cPO4f4X2TgypfMofd+Ti8XmHIKW1lEaceWlcoBLwvoZlfa8QPhUmWZzr?=
 =?us-ascii?Q?3EnyqU4zJ9Y00xy9eKzOT3wN5Kz4lO7r4TP1ET5fCSCRCXkn++HBmpGm5yb3?=
 =?us-ascii?Q?GctIfHPU9GyOUoTpdGakq5FFkLSUejEy8yWgI5YUL3b0p9ugqZYlQHg67BDD?=
 =?us-ascii?Q?VJRT9yqQC0IIuUhb6EY0P+077/3V+fm6QTfIQ98Cg0K9uYbnci3+EsTp0xS3?=
 =?us-ascii?Q?Amwt7p8tXFcA+tYlUrIqYBwH3mo36sp0eGNw+BzXrWDRI3cnVF8RmK0BUHjz?=
 =?us-ascii?Q?jPHOAQ5sXYUIvvZtFvZaTL7DFLTpQ6Of1hwIp491R0HV1zNqGwOvKtHdlDRw?=
 =?us-ascii?Q?xpZEi4Wmwvr08jm5LxRt55k7Blb0A3UMbHLRgdxeO18gUM+EDpaABKi6AalA?=
 =?us-ascii?Q?QerGhgOzCJKAHIRhJSp+PLpLxUmJaaovs8qNAacG1L1GebUZ7ox84zrOZ3s1?=
 =?us-ascii?Q?eKcvwwEpz4T+pLQUszH7ReaPeIg2Q8vZa203blfZjxyFfoDn15N+w8zkvQt6?=
 =?us-ascii?Q?RWWB4vuHlatwue5kqfKM8oE1A4f3bqOn69ZQZcWkxSSdXeEpZ8ZcKDzWSo/n?=
 =?us-ascii?Q?KnkB64JURBc2yA4rDa2lplI/kQXhoFNCG0FJ8GPj6AD6vQj6XvFria8TJ6dm?=
 =?us-ascii?Q?y7g0dbVYPkGMj8OrUlMztFZ+egpfibjTVY3Dz+6lUkdOTiUJaswzgDliSrmr?=
 =?us-ascii?Q?KV0APZBeNipSRrhMgg1vqlEHihdNKXddTdDW6ADhP6qcV+ecDBY/SbmozUcc?=
 =?us-ascii?Q?b3XtQUwrqZDABWi56k/BxSEbCyxfEcKh8Q7J68SapjheWqEzdwg+oN2TsQXV?=
 =?us-ascii?Q?uSdWWwTqa8YCA4VXZoYXmzuZgz8J1dMBLBJw9whUv+u7bvMkuG4tqbujmBhR?=
 =?us-ascii?Q?JbKJnqpyt9rApy6+L2fUPS5YO+KPcZ9RlB54r99zo/92gbi/ZpGlPU9/V0QA?=
 =?us-ascii?Q?oTaXXlJRoXLQM9W2IrHO8EEx7tCtocN2Wtqd9zRxY6HdHak/uyNXNTvVvHN7?=
 =?us-ascii?Q?jWJ+iC8YJ/1g5FrT117fRssECB1sxUPtn8TmIPZKAZ/Gdi5LhD2B+vOcZ442?=
 =?us-ascii?Q?MxFS28jnrn1t3Oxu7pCAZCitFngp/oHrpsaS9BDa7t+sg2ioDTCzbA/yojmA?=
 =?us-ascii?Q?5WzYSoKku9fHkq9dBqjLZaodC/Qc3iyqVO7OTtiKxrb76yuRt5e+H3LaUjEi?=
 =?us-ascii?Q?cMhwWus3emLCv6UIptmOC6N3EIXtF6W12huviy/03Ywt3aXtPYiW9j7neRgu?=
 =?us-ascii?Q?ofVZiv04xjf7EEAZuimWIXvpHf+FZs61zec0J3IcRC+MNovc1ziOd3v/h9HG?=
 =?us-ascii?Q?V/CUOwSkwGxnlJMXgmUg2JHjL6DZzVj/qr5aGR5937PlY9EgZQe87qUrG9/H?=
 =?us-ascii?Q?q/UpRfrjjZL1HqbVVv5AF1WdMcAZ3+hRGABxm11Stz/0ANyKUgYoSLXLk2UR?=
 =?us-ascii?Q?/zLweoUHDK+hdUzNwsf88eNJtram8OtvIG5xLMNw1MFhpON8Y3lVJL65xXyF?=
 =?us-ascii?Q?C966nDR4QiZvjbJNhWvjzFfpcTHvE1PXjSPFgquOog/27qPYpXhJ/5DCi1X+?=
 =?us-ascii?Q?EZBagA69VRsoICa+6Ka1Di8jzXJSAeFtyIuyaRVdDFFYqN/LIhdBQDTqSye7?=
 =?us-ascii?Q?LzXzCkw6XTRQxd/Y3MmGYZyhH0QOgxdqDNtWwJauVUAclIBFS8BbGPv9uSf5?=
 =?us-ascii?Q?3VoA+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:43.5221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e56e9-592f-48f3-2183-08de5cc83205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

To handle SMMUv3 accel=on mode(which configures the host SMMUv3 in nested
mode), it is practical to expose the guest with reserved memory regions
(RMRs) covering the IOVAs used by the host kernel to map physical MSI
doorbells.

Those IOVAs belong to [0x8000000, 0x8100000] matching MSI_IOVA_BASE and
MSI_IOVA_LENGTH definitions in kernel arm-smmu-v3 driver. This is the
window used to allocate IOVAs matching physical MSI doorbells.

With those RMRs, the guest is forced to use a flat mapping for this range.
Hence the assigned device is programmed with one IOVA from this range.
Stage 1, owned by the guest has a flat mapping for this IOVA. Stage2,
owned by the VMM then enforces a mapping from this IOVA to the physical
MSI doorbell.

The creation of those RMR nodes is only relevant if nested stage SMMU is
in use, along with VFIO. As VFIO devices can be hotplugged, all RMRs need
to be created in advance.

Initialise AcpiIortSMMUv3Dev structures to avoid using uninitialised
state when building the IORT, as legacy and device SMMUv3 paths
populate different fields now(e.g. accel).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 115 +++++++++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9032a5df1c..4ae4cbc6cd 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -257,6 +257,29 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+#define IORT_RMR_NUM_ID_MAPPINGS     1
+#define IORT_RMR_NUM_MEM_RANGE_DESC  1
+#define IORT_RMR_COMMON_HEADER_SIZE  28
+#define IORT_RMR_MEM_RANGE_DESC_SIZE 20
+
+/*
+ * IORT RMR flags:
+ *   Bit[0] = 0  Disallow remapping of reserved ranges
+ *   Bit[1] = 0  Unprivileged access
+ *   Bits[9:2] = 0x00 Device nGnRnE memory
+ */
+#define IORT_RMR_FLAGS  0
+
+/*
+ * MSI doorbell IOVA window used by the host kernel SMMUv3 driver.
+ * Described in IORT RMR nodes to reserve the IOVA range where the host
+ * kernel maps physical MSI doorbells for devices. This ensures guests
+ * preserve a flat mapping for MSI doorbell in nested SMMUv3(accel=on)
+ * configurations.
+ */
+#define MSI_IOVA_BASE   0x8000000
+#define MSI_IOVA_LENGTH 0x100000
+
 /*
  * Append an ID mapping entry as described by "Table 4 ID mapping format" in
  * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
@@ -265,7 +288,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
  * Note that @id_count gets internally subtracted by one, following the spec.
  */
 static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
-                                  uint32_t id_count, uint32_t out_ref)
+                                  uint32_t id_count, uint32_t out_ref,
+                                  uint32_t flags)
 {
     build_append_int_noprefix(table_data, input_base, 4); /* Input base */
     /* Number of IDs - The number of IDs in the range minus one */
@@ -273,7 +297,7 @@ static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
     build_append_int_noprefix(table_data, input_base, 4); /* Output base */
     build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
     /* Flags */
-    build_append_int_noprefix(table_data, 0 /* Single mapping (disabled) */, 4);
+    build_append_int_noprefix(table_data, flags, 4);
 }
 
 struct AcpiIortIdMapping {
@@ -321,6 +345,7 @@ typedef struct AcpiIortSMMUv3Dev {
     GArray *rc_smmu_idmaps;
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
+    bool accel;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -330,7 +355,7 @@ typedef struct AcpiIortSMMUv3Dev {
 static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
-    AcpiIortSMMUv3Dev sdev;
+    AcpiIortSMMUv3Dev sdev = {0};
 
     sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     object_child_foreach_recursive(object_get_root(), iort_host_bridges,
@@ -362,10 +387,10 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
 static int iort_smmuv3_devices(Object *obj, void *opaque)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    AcpiIortSMMUv3Dev sdev = {0};
     GArray *sdev_blob = opaque;
     AcpiIortIdMapping idmap;
     PlatformBusDevice *pbus;
-    AcpiIortSMMUv3Dev sdev;
     int min_bus, max_bus;
     SysBusDevice *sbdev;
     PCIBus *bus;
@@ -375,6 +400,9 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     }
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    if (object_property_find(obj, "accel")) {
+        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+    }
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -448,10 +476,69 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
     }
 }
 
+static void
+build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
+{
+    AcpiIortSMMUv3Dev *sdev;
+    AcpiIortIdMapping *idmap;
+    int i;
+
+    for (i = 0; i < smmuv3_devices->len; i++) {
+        uint16_t rmr_len;
+        int bdf;
+
+        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
+        if (!sdev->accel) {
+            continue;
+        }
+
+        /*
+         * Spec reference:Arm IO Remapping Table(IORT), ARM DEN 0049E.d,
+         * Section 3.1.1.5 "Reserved Memory Range node"
+         */
+        idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, 0);
+        bdf = idmap->input_base;
+        rmr_len = IORT_RMR_COMMON_HEADER_SIZE
+                 + (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE)
+                 + (IORT_RMR_NUM_MEM_RANGE_DESC * IORT_RMR_MEM_RANGE_DESC_SIZE);
+
+        /* Table 18 Reserved Memory Range Node */
+        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type */
+        /* Length */
+        build_append_int_noprefix(table_data, rmr_len, 2);
+        build_append_int_noprefix(table_data, 3, 1); /* Revision */
+        build_append_int_noprefix(table_data, (*id)++, 4); /* Identifier */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, IORT_RMR_NUM_ID_MAPPINGS, 4);
+        /* Reference to ID Array */
+        build_append_int_noprefix(table_data, IORT_RMR_COMMON_HEADER_SIZE, 4);
+
+        /* RMR specific data */
+
+        /* Flags */
+        build_append_int_noprefix(table_data, IORT_RMR_FLAGS, 4);
+        /* Number of Memory Range Descriptors */
+        build_append_int_noprefix(table_data, IORT_RMR_NUM_MEM_RANGE_DESC, 4);
+        /* Reference to Memory Range Descriptors */
+        build_append_int_noprefix(table_data, IORT_RMR_COMMON_HEADER_SIZE +
+                        (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE), 4);
+        build_iort_id_mapping(table_data, bdf, idmap->id_count, sdev->offset,
+                              1);
+
+        /* Table 19 Memory Range Descriptor */
+
+        /* Physical Range offset */
+        build_append_int_noprefix(table_data, MSI_IOVA_BASE, 8);
+        /* Physical Range length */
+        build_append_int_noprefix(table_data, MSI_IOVA_LENGTH, 8);
+        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+    }
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049E.b, Feb 2021
+ * Document number: ARM DEN 0049E.d, Feb 2022
  */
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -465,7 +552,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
-    AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
@@ -491,6 +578,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             nb_nodes++; /* ITS */
             rc_mapping_count += rc_its_idmaps->len;
         }
+        /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->accel) {
+                nb_nodes++;
+            }
+        }
     } else {
         if (vms->its) {
             nb_nodes = 2; /* RC and ITS */
@@ -563,7 +657,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Array of ID mappings */
         if (smmu_mapping_count) {
             /* Output IORT node is the ITS Group node (the first node). */
-            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
         }
     }
 
@@ -615,7 +709,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                        AcpiIortIdMapping, j);
                 /* Output IORT node is the SMMUv3 node. */
                 build_iort_id_mapping(table_data, range->input_base,
-                                      range->id_count, sdev->offset);
+                                      range->id_count, sdev->offset, 0);
             }
         }
 
@@ -628,7 +722,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                 range = &g_array_index(rc_its_idmaps, AcpiIortIdMapping, i);
                 /* Output IORT node is the ITS Group node (the first node). */
                 build_iort_id_mapping(table_data, range->input_base,
-                                      range->id_count, IORT_NODE_OFFSET);
+                                      range->id_count, IORT_NODE_OFFSET, 0);
             }
         }
     } else {
@@ -637,9 +731,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          * SMMU: RC -> ITS.
          * Output IORT node is the ITS Group node (the first node).
          */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
     }
 
+    build_iort_rmr_nodes(table_data, smmuv3_devs, &id);
     acpi_table_end(linker, &table);
     g_array_free(rc_its_idmaps, true);
     for (i = 0; i < num_smmus; i++) {
-- 
2.43.0


