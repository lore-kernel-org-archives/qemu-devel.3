Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568A0C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicTt-0000SW-Jz; Wed, 21 Jan 2026 12:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSw-0007RF-1t; Wed, 21 Jan 2026 12:58:08 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSo-00027z-Ju; Wed, 21 Jan 2026 12:57:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL3LlL1ttPhE4WtjZzhlOCViqf1l0cLrysyqfDXqAFfgBjQJDOuKUqORgDHFnoZc3EZURwdOipZkC2bhbr+kvLxMhtBd2nUjDcpyMIqI+wTWR1seLp9nC8V/QWofHg2ajQGDTYAdWAjsPzAePWgzz8xj8qe/jyOdXquUsGyrBPcGcYU/zhNNME67AjNdOHTB3mp7sRdGQ/Er0M3/Jcybk8K/Vnvovq9XgL1iIMnz+pKnvhyQbP8seMcPjtEcGx5nc6o2xPGMXm5zdw7YLkbdGkbGI7IABMdbEaXfKxFPe7uVPlv+dAYa+wYmb66LIqrvcWSH8TKGHm5JTp1EQ43aPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiT3MZ+qNDHTvUTqnBBmvruBSr2x6xkvQXNxH4VEhog=;
 b=VcEAAmx8uz4MHcDYzkD0Sxl0VgCJzZLx/znhSA03pU1EygRTXdfvJUH8e1EarLGUmgOj6yMk73fuSJoVtqXibuBFthK/EyJ2oUMZlawRRioZ7aQ6vnPYLK9mly6IvwnOafTT3KoV+qo5tpmnTmvm5s3O6FVPjOS62r/+UVHh/6j0EHLyN1DGxjZ/2JDP1FbUegUwaWXQApm9DpgHYxs1iLzx4Qx83KlDDsy4znpGfdDD54da+6SV+ZblTVURIF7xPTs31s5tpDdQ98uNxXGacLeLbTDNbQ/MHBSm2p03Hs6APdl0HXw86b9gCFfd+6Cqhj0aXCRPt5jHYc/RIt+giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiT3MZ+qNDHTvUTqnBBmvruBSr2x6xkvQXNxH4VEhog=;
 b=d2OEfp/lJozo+/8c9EuN20+Mj0SWyou2qpAWqXm6nWPshVHmoJH9Qly3s2T6Is8ma8vll5GHiW1KnWbUSq5oJR+QFuSWqT52Tc+86E1nXw+uyHUryPq4sLSTEdm2cemhe5rqZmRN0I35rw6C6n3o7va3ZKfdWX60lY/aS/79aO5tPhhK8t5g5wdfOalVw3FEWvYpCfkSv84iiRG0GpG+kqlEWjBEPk8pUH8JDMLvJR2GhGv1lR0Pb1YNjsEx0GRAm7lPCyrsZMlHeC78QpuQY4cROTdJsh5vEWrSLfZdyeryz0Og99K7DjQBHfBA7AyyG9jdNo3LqhW57URza6Io9Q==
Received: from MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::7)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:40 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::7b) by MN0P220CA0008.outlook.office365.com
 (2603:10b6:208:52e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:57:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:09 -0800
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
Subject: [PATCH v8 25/37] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Date: Wed, 21 Jan 2026 17:52:30 +0000
Message-ID: <20260121175248.87649-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee32054-594b-4546-4001-08de591691be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Nyi+5xxkMQcwpdfSWknNeLTcEtUa+73duX7m6gFhsUsW0Tz1z2gj3ST8nuz?=
 =?us-ascii?Q?Lzeh6hoZsT0UgX2hwUoQvJ4JLpZCu7q7VRGR3ncknS00txpYIQnvfH0yyi6t?=
 =?us-ascii?Q?h8RtQiZFkF+AMj8whGijVM+2QF+E7qhgzY/jLmLisNkj2/mKhGiR1OW64U8x?=
 =?us-ascii?Q?FFAdsnb8alcqOkJ7PqVZP3UgQe9YNjvxrq0X5AwoOy6sqd71HbUy6XzHHgiL?=
 =?us-ascii?Q?1rYm2lK6k+e2oIo4Tb1uHVWZ9YQqGK37OXwOe0dNmyXjehTJZlt4ZR8ygDji?=
 =?us-ascii?Q?dUyGbZUC0z2oF4+hxj1Lz9bCiwGtWhxdOguiAj8emw+iK9ODcitJrnGGVGEk?=
 =?us-ascii?Q?+K7dfYuabepnoopCzL77I5NIdBJ8WklSS4cbeDILyJC7XBypY39xx6XncCmc?=
 =?us-ascii?Q?NtphTidZaKju8iGzmed/sXWcD4q/zcyi4cCsWbwygeGR4d1ilKspcWbrsT8p?=
 =?us-ascii?Q?Jj2FxlVVDylSjIykGgUc1VN/ClXCQYq7fikt47GUipBEvynZ/LEn11Qa2/vo?=
 =?us-ascii?Q?gIy6Rpy0qVQfNQcRkCXvOnOh9HvTv3cm1u8US1l1gtB12+mJbPTrCFBYItYJ?=
 =?us-ascii?Q?RcIagsHbFYDcQnzSDyK2oh/33PSMvqi0iArcbRZISH73OXPru5rLHD6sR3KP?=
 =?us-ascii?Q?MzfbFMI8QSpB0/1xYV9wferEuer+XzcDEVx4EepHYI3PrB8sxjiB/4KpsTW1?=
 =?us-ascii?Q?phZKRPcqMCXtHp4fRI8MQFyugG3c2Pz0olLhFzMr4XiNKGWf0GgDh6E+QTuP?=
 =?us-ascii?Q?b93+9HItlWVjlVEvaV+xA1sK2KdWEck/fitOuIEvKrba26miCMVu7TV16MVS?=
 =?us-ascii?Q?R8rraJ375Ka2Tn3GIhQjNUl+RYoosXSW1SgCcuBv1jjnlfQagbKmHHE76vBl?=
 =?us-ascii?Q?LCEHdI6C0bUGq5oDqwPyewK4iWOcvIfzX1Fwd2YT1MBDOnAFgSRE8JD7j0FW?=
 =?us-ascii?Q?SaSJfdi1E0+cQPrJL0knMs2TsmxSoe+UXHa7VvhxcbTJYTjSQWxRLmUbWN6b?=
 =?us-ascii?Q?Er6DHMNzTYn9el8KmwiE4ZFaZT1YvMuDs0tav4OIeQGifavkWiIVxjSGM8ue?=
 =?us-ascii?Q?MRVl4x1GjnENnhaUjJiMsOCGlTQEjoqYyb7u5a0hfgcO37DROjp5NtpF+qQZ?=
 =?us-ascii?Q?O8n1ut+jEsBIFB9WjbT7hN3vB+mHwm1SKKqrZbiWvnuRFilaO81jlqPGU+jk?=
 =?us-ascii?Q?g2dbquLvSqXWroyfQ5g5ivp8Yv5vxCGs+1M74NlypIsDiKs+IrvPkhSZaMFT?=
 =?us-ascii?Q?hllok9CjyMoKlPxjH+zUvVdLf6Kcy8dWpEw0rRB4sU4hNJ7S0FvwOn82U9Dy?=
 =?us-ascii?Q?zkotMsYSbjGS30pQSBlVKio4meHhU4xwj5h31CgunNbsKxcO6LTAfVwcrm3g?=
 =?us-ascii?Q?eiUW1YUuP5ADTfEpIDByWYjk50aK04wZX2f41sK1cbDjnfpTs5U3wmbSQBeU?=
 =?us-ascii?Q?wSZRzPJJMJH95a29xk0ZZimZ+hAinyTvK6UveyleGPdsTRCkNAXvd2XxYhTg?=
 =?us-ascii?Q?RMRs1H8XkUBPsiqkmFZhHONFlSm+gpTTcfntKg90dMiPxgMKJO+Kd6jizut0?=
 =?us-ascii?Q?88AXDYjXeTEpRLqj5D2RI0Ps1qUf2AkfPx0x7ZCAna65Mo3XQxcdGjghyHQ3?=
 =?us-ascii?Q?HgRXvfjN+zcgVHM+3qM9G/38RdVWbZqJ7RtPr/94rVQGrKAsGYP/5R/85OH0?=
 =?us-ascii?Q?UGCpUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:40.1212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee32054-594b-4546-4001-08de591691be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 111 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9032a5df1c..89abbf641b 100644
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


