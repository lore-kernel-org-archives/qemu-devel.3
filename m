Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C019CC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMI5N-0003pQ-0m; Tue, 25 Jun 2024 22:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMI51-0003nI-C6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:08:18 -0400
Received: from mail-bn1nam02on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2407::616]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMI4Q-0003fc-Dx
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9mz20+7Zc+3nDMJPq8YOF2kAb37d2iuqXdrXBPOlJ34CuWWSgG2mGlmjrVurLq/GGvIJJdpjP4LVmboT3qRD8MSlX6KwUK1Auqctf+WNSXmmp+8CZghVJ1LD1oNY7ZdWM+iuh6FLOvE+s1cXSm6EpI/bLhotKEeZHo0WbQ/+MdYi3rEHsusG4NCmvRhIYz8Yu5YgE92YUvaSL/+UoaxCkpHUvWKJ5iN8f/WoXQ4XiSMahJWRpHK+kOFdn8Sv/uZ3Ncd4RMyjGXw57Qm0Jp3b6LyXoYV98EWf4DrkE5NWPvY1KtR5vJ2dhMgmARiFn9FqOn9OwFhlOu2BkHGokFw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JMy6Or3KW8qCfpz3EkC9MUSXl+ggzi3XZvt+LeIJ38=;
 b=i6ysUjPO3E7dJD17VW8Z7eyKsVO/4XqVjw9cHr2G6FLf0h4w6AiJ2hAAPbxLVyEp9Efvt0ueVvK7gX438eWtWiAHB+foHDdGPEu1vT+E2p747S9S1ex4FTPXnte+LRTnNB4WoX0TM2h1VhQ5i5uM5N0ySu778vixFOI28EX/O/mdos/V6mjGXpnHY72Qt/6/exWdg/NocVM2RKoqDp+YqC31cWgPn2ZVbT+3A4NJjCo/l528uFfagQdLXyPV35EpO7ppshbTwnfUDGbvob/Si1mGZl4VNWWhQxJJTwkSTkHdxDuYXbaDThLIsCkkQtJhqRNDM4jIEGh7UxdEDWsbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JMy6Or3KW8qCfpz3EkC9MUSXl+ggzi3XZvt+LeIJ38=;
 b=s3Z7khQMR8T9G2v1ft9JqpNMQtnTKgnWwhmlMQhHUrUiqyvXvkifPsmYMwsHC74WaXEg5VEgK7Quvz8YzMRX/Dr9hAf51dnDkXZDufV7AHDh8TZzrdtNzOfg8Igtbk8obhtjmn+IIntpbYPLKP4yJe+3+MN9fx7PbpsQhWaRJwwtiTB85uQYlx2vLLH2tiZXDZqRziNnraS6cRKZ+4q042AcNy0IRctdYmz4Lzhlo6I7+BxNDnWlqk0TFmXkjwE5+cc9LNxhvhgEWN6+YbShCaBPcmGYJ28zrgXO1KiBotldJNSFVa72iind5pwyaRZsz8KUlXqdL2J78ii+vVWBjA==
Received: from BN0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:408:142::17)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 00:29:32 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::7c) by BN0PR08CA0023.outlook.office365.com
 (2603:10b6:408:142::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 01/10] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Date: Tue, 25 Jun 2024 17:28:28 -0700
Message-ID: <aef143f212f9ad9ac65f9bfd70f875ae5b452c7a.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: aa58b68c-3716-4f24-dbbb-08dc95770c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z+UkL8PqjmL27JtixBriGNDW0AkCocb8MiF9RcGOwiLDdeamk+Im8/VB2RFb?=
 =?us-ascii?Q?r2B7ucowSA0czC3cgWF/HIzSkTQAIrYsgWtp9ebMfhlxQcYwrs3iJkiIApa5?=
 =?us-ascii?Q?1Zi+eOAGDUign46CbDrBuX/qo8URSXXsAOUJ1HOh+Yv89DO7oIizWLTTmZ+J?=
 =?us-ascii?Q?QrhxsMzE+4PJWBonEQF5F73bjv3z5gA+g46RBL9OWK2/ybEpjZV+YJ1Bm8gP?=
 =?us-ascii?Q?AXsilZ5EA0Qi+w/53fc10SACPfD95+c6tz63T/Z4IpRtiYvDhA57FStQIKX4?=
 =?us-ascii?Q?l409a+B/1BwQgkomp9VnCHqTWWyIdrgJkpdlkrhB4fi5ahIREty77vYEoWqB?=
 =?us-ascii?Q?rsW+Sa0x7v8ntZI7OExqvufkbpTwbvQ/qrp39wDV9shv8f8U1+RS18T7Fpq4?=
 =?us-ascii?Q?fnSSi04YXG96bije+IM9Kbr4QvtOYTfvKqPMko6CUio5mgnPE99ePBEWMvW8?=
 =?us-ascii?Q?QGcXxPAaLfW9UlwNRwFxkX0C/rnl7aoSnENz/Fu7Ra5RBpu9Vj8PpxaJX9QQ?=
 =?us-ascii?Q?FLSm7DOyxc4KTW/zlnHJETaglXwsclkEbj4EBlMQ2doy7zrNzuQAWCLmhr6d?=
 =?us-ascii?Q?kxFYsW6rozqBoKc9yJIAPnQj+XcUrB2MAfXaV5yH8zyfs036bYmNl44sVpcg?=
 =?us-ascii?Q?0qVQPM/gUKWLtZ8FJe62MwTY6hpfm8HIRNW90WuG7z7jXqHFBOQpxO6ATVqL?=
 =?us-ascii?Q?E9B9YRGeFsjOwlidQa/U0CJBEhq2lnBxfA6uR0P2fmYxVWFwMf5yy2V/3hvs?=
 =?us-ascii?Q?8QQlqh8UyFcOLWmiSQZP4lf1gXb6+QdjUfwaMwCtNZWU5QGjevgqGocJz8AI?=
 =?us-ascii?Q?UW6BBnUXa+hEZegmBGKJ8wXqMXzYaD1+8K47T8RJkpN9GsO1cG5h1tSsB7SV?=
 =?us-ascii?Q?xN3lILUF1jYeRpypk7a32v2rE9EB9SA5WBd4VCXClE0uFa0gncudBgZ7K3vO?=
 =?us-ascii?Q?eUic+faKdLNBakQYX8RKRnigvjaAlCj9K36+FsbN8jUXA1jXnfX3KJJybN9x?=
 =?us-ascii?Q?KT9P5JNi0ebDxr8RlpUWb2ZoG+z32ii+CQppQItH3DFAAkZkkoSFFERhRSb5?=
 =?us-ascii?Q?jQ/mhtdp/PVeFIoSjZH33hwwZ4fHqorc1rUAKhononsg9Eq6kUxhdHki2XWM?=
 =?us-ascii?Q?tfSGIMRJgcFE5xl+nYwJZtORjIfOwD829IlrJ4tWYN8SYZO2ngoWw8kH3SuY?=
 =?us-ascii?Q?SOVa/2/0HAD+bRnmOIiAuAO4Q29g0SCYHLSqCSccKgdvowfuIz+0fYVi3p3d?=
 =?us-ascii?Q?TBUL8X9Mp0+/c8+KDTaeeoZAYNwbyUyvwdTUTLaKDkifjt/UZDpsZ1kmfMNC?=
 =?us-ascii?Q?FcIMqkfn/WY8SRgHwmhgqoQ/yFor/TNMFM42USavParSBWtpNTncjoszYQj+?=
 =?us-ascii?Q?8nnJ3Lll8pHq/QjOWvB49rm3MVEn7+eNPheEhYMDtoYf4PWZOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:31.7222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58b68c-3716-4f24-dbbb-08dc95770c44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
Received-SPF: softfail client-ip=2a01:111:f403:2407::616;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

To handle SMMUv3 nested stage support it is practical to
expose the guest with reserved memory regions (RMRs)
covering the IOVAs used by the host kernel to map
physical MSI doorbells.

Those IOVAs belong to [0x8000000, 0x8100000] matching
MSI_IOVA_BASE and MSI_IOVA_LENGTH definitions in kernel
arm-smmu-v3 driver. This is the window used to allocate
IOVAs matching physical MSI doorbells.

With those RMRs, the guest is forced to use a flat mapping
for this range. Hence the assigned device is programmed
with one IOVA from this range. Stage 1, owned by the guest
has a flat mapping for this IOVA. Stage2, owned by the VMM
then enforces a mapping from this IOVA to the physical
MSI doorbell.

The creation of those RMR nodes only is relevant if nested
stage SMMU is in use, along with VFIO. As VFIO devices can be
hotplugged, all RMRs need to be created in advance. Hence
the patch introduces a new arm virt "nested-smmuv3" iommu type.

ARM DEN 0049E.b IORT specification also mandates that when
RMRs are present, the OS must preserve PCIe configuration
performed by the boot FW. So along with the RMR IORT nodes,
a _DSM function #5, as defined by PCI FIRMWARE SPECIFICATION
EVISION 3.3, chapter 4.6.5 is added to PCIe host bridge
and PCIe expander bridge objects.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

---

v2 -> v3:
- Comply with IORT E.d spec. RMR node rev = 3; IORT rev = 5
  With this spec revision, the restriction on number of
  Stream IDs that can be associated with memory ranges in an
  RMR node was removed. So no need anymore to define 1 RMR node per
  SID!
---
 hw/arm/virt-acpi-build.c | 84 +++++++++++++++++++++++++++++++++-------
 hw/arm/virt.c            |  7 +++-
 include/hw/arm/virt.h    |  7 ++++
 3 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 94363a6d65..d5e72800f6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -132,6 +132,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         .bus    = vms->bus,
     };
 
+    /*
+     * Nested SMMU requires RMRs for MSI 1-1 mapping, which
+     * require _DSM for PreservingPCI Boot Configurations
+     */
+    if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
+        cfg.preserve_config = true;
+    }
+
     if (vms->highmem_mmio) {
         cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
@@ -216,16 +224,16 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
  *
  * Note that @id_count gets internally subtracted by one, following the spec.
  */
-static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
-                                  uint32_t id_count, uint32_t out_ref)
+static void
+build_iort_id_mapping(GArray *table_data, uint32_t input_base,
+                      uint32_t id_count, uint32_t out_ref, uint32_t flags)
 {
     build_append_int_noprefix(table_data, input_base, 4); /* Input base */
     /* Number of IDs - The number of IDs in the range minus one */
     build_append_int_noprefix(table_data, id_count - 1, 4);
     build_append_int_noprefix(table_data, input_base, 4); /* Output base */
     build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
-    /* Flags */
-    build_append_int_noprefix(table_data, 0 /* Single mapping (disabled) */, 4);
+    build_append_int_noprefix(table_data, flags, 4); /* Flags */
 }
 
 struct AcpiIortIdMapping {
@@ -267,6 +275,48 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+static void
+build_iort_rmr_nodes(GArray *table_data, GArray *smmu_idmaps, int smmu_offset, uint32_t *id) {
+    AcpiIortIdMapping *range;
+    int i;
+
+    for (i = 0; i < smmu_idmaps->len; i++) {
+        range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+        int bdf = range->input_base;
+
+        /* Table 18 Reserved Memory Range Node */
+
+        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type */
+        /* Length */
+        build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE + 20, 2);
+        build_append_int_noprefix(table_data, 3, 1); /* Revision */
+        build_append_int_noprefix(table_data, *id, 4); /* Identifier */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, 1, 4);
+        /* Reference to ID Array */
+        build_append_int_noprefix(table_data, 28, 4);
+
+        /* RMR specific data */
+
+        /* Flags */
+        build_append_int_noprefix(table_data, 0 /* Disallow remapping */, 4);
+        /* Number of Memory Range Descriptors */
+        build_append_int_noprefix(table_data, 1 , 4);
+        /* Reference to Memory Range Descriptors */
+        build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE, 4);
+        build_iort_id_mapping(table_data, bdf, range->id_count, smmu_offset, 1);
+
+        /* Table 19 Memory Range Descriptor */
+
+        /* Physical Range offset */
+        build_append_int_noprefix(table_data, 0x8000000, 8);
+        /* Physical Range length */
+        build_append_int_noprefix(table_data, 0x100000, 8);
+        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+        *id += 1;
+    }
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -282,17 +332,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
-    AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (virt_has_smmuv3(vms)) {
         AcpiIortIdMapping next_range = {0};
 
         object_child_foreach_recursive(object_get_root(),
                                        iort_host_bridges, smmu_idmaps);
 
+        nb_nodes = 3; /* RC, ITS, SMMUv3 */
+
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
 
@@ -309,6 +361,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
 
             next_range.input_base = idmap->input_base + idmap->id_count;
+            if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
+                nb_nodes++;
+            }
         }
 
         /* Append the last RC -> ITS ID mapping */
@@ -317,7 +372,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             g_array_append_val(its_idmaps, next_range);
         }
 
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
     } else {
         nb_nodes = 2; /* RC, ITS */
@@ -342,7 +396,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* GIC ITS Identifier Array */
     build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (virt_has_smmuv3(vms)) {
         int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
 
         smmu_offset = table_data->len - table.table_offset;
@@ -372,7 +426,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4);
 
         /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
     }
 
     /* Table 17 Root Complex Node */
@@ -405,7 +459,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (virt_has_smmuv3(vms)) {
         AcpiIortIdMapping *range;
 
         /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
@@ -413,7 +467,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
             /* output IORT node is the smmuv3 node */
             build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+                                  range->id_count, smmu_offset, 0);
         }
 
         /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
@@ -421,11 +475,15 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
             /* output IORT node is the ITS group node (the first node) */
             build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, IORT_NODE_OFFSET);
+                                  range->id_count, IORT_NODE_OFFSET, 0);
         }
     } else {
         /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
+    }
+
+    if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
+        build_iort_rmr_nodes(table_data, smmu_idmaps, smmu_offset, &id);
     }
 
     acpi_table_end(linker, &table);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..78af2d2195 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1396,7 +1396,7 @@ static void create_smmu(const VirtMachineState *vms,
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
 
-    if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
+    if (!virt_has_smmuv3(vms) || !vms->iommu_phandle) {
         return;
     }
 
@@ -1578,6 +1578,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
+        case VIRT_IOMMU_NESTED_SMMUV3:
             create_smmu(vms, vms->bus);
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -2653,6 +2654,8 @@ static char *virt_get_iommu(Object *obj, Error **errp)
         return g_strdup("none");
     case VIRT_IOMMU_SMMUV3:
         return g_strdup("smmuv3");
+    case VIRT_IOMMU_NESTED_SMMUV3:
+        return g_strdup("nested-smmuv3");
     default:
         g_assert_not_reached();
     }
@@ -2664,6 +2667,8 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
 
     if (!strcmp(value, "smmuv3")) {
         vms->iommu = VIRT_IOMMU_SMMUV3;
+    } else if (!strcmp(value, "nested-smmuv3")) {
+        vms->iommu = VIRT_IOMMU_NESTED_SMMUV3;
     } else if (!strcmp(value, "none")) {
         vms->iommu = VIRT_IOMMU_NONE;
     } else {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index bb486d36b1..7df0813e28 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -89,6 +89,7 @@ enum {
 typedef enum VirtIOMMUType {
     VIRT_IOMMU_NONE,
     VIRT_IOMMU_SMMUV3,
+    VIRT_IOMMU_NESTED_SMMUV3,
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
@@ -209,4 +210,10 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+static inline bool virt_has_smmuv3(const VirtMachineState *vms)
+{
+    return vms->iommu == VIRT_IOMMU_SMMUV3 ||
+           vms->iommu == VIRT_IOMMU_NESTED_SMMUV3;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.43.0


