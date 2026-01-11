Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9612D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Zf-0002IQ-Qx; Sun, 11 Jan 2026 14:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zd-0001vM-0T; Sun, 11 Jan 2026 14:58:05 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Za-000478-Sv; Sun, 11 Jan 2026 14:58:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhjm6fVKOwUQFXVFj7xe11T81ZUPKe4YrWUTIjorENEMRpJh9cc5ZLt0wPFy6BPnf1Qg0B1hWio6Wx3+yegg/022VKNWItQR7tnxyJGSPPdKlQ3eJQua/4mPPyp8xg9yu7VolKcwFgukASmIIDaDUASqA/Vubj+1fO8qWClfk99qkIVXwZDvEf0zjGhT0qp8QO5ypFMlaR8Kd0X1QAojHSk0QHorzZQKUC0R65Rl90Mm/a+IZnLiZzkdbeKCnWQ9ptDFilTJby77mObnzc8r8LYZmSBlqu0P13N+0lep1zPEABNoiuDEXl9EzTuBAekqZiXXbNb/plOf5yVbc5whlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z0yQm4rf6LCxU912WO8Fun9Z+J6YLWu2/ZN/5IUIQE=;
 b=WR6sx/7TA4lg5Vel+aOK7q6jQRx7HLZd6gDsEwWEqDWf9QSEpREl0slrRBpD/mXw2+aA1c3B8UwSGaGjmLOO8mhHemNGngDNn6Lt9UyZtpZMD3NNsHHKO0aC2o9K4KckKIppzjjVwfpVnieQXHZUFte5yEUxylUVe/XsPcCQ1ujx24WGy9sPeqGyQM3p+BwLwD083kBzlYQhcqbN90DXPBN2eZ/uXIBhapKGyQg7ep8dly9H4s1ocu7Llvlyrvp++ns6Nz4JsvW+4YLVVtuQSxO4dMUPRIzeBayg4JhTjaOozkESbtW3FKBLcOICgB3a+oWVJdhRIIr1v5MUGU2nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z0yQm4rf6LCxU912WO8Fun9Z+J6YLWu2/ZN/5IUIQE=;
 b=Bh5s/FfSybN4gpD7pdBfjEd0CXsS1xl17bndF6K+iVYuKZlagJxdHH312mgJ2QtzM6eD25gei8GPJ9WzD90Vz/0U1+BAmRJi2ln2NdN/PQ2PELi5WAw3LmmVm5QpwA7asuiWEBzQMTa3GD8JHK2RQcfNjAiElnQU67lWT+I35T/zJlMC+eh61zZGSVrCFc+M8cgSZeKofuyNR+yNoGcg2TD2DjNOJBDh1hCxaQpm71sUS5SdqXX1ZowIBCGN/JBg1fpmyKb3p8i5R7ugyu8NclWOyl+c2Uyj+MyajG+eWJ9IASHzByauz0qfKyg7cQzjgqWwiyYhaYyaBx1uRzhDPQ==
Received: from SA9PR13CA0128.namprd13.prod.outlook.com (2603:10b6:806:27::13)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:56 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::b3) by SA9PR13CA0128.outlook.office365.com
 (2603:10b6:806:27::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.3 via Frontend Transport; Sun,
 11 Jan 2026 19:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:48 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v7 24/36] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Date: Sun, 11 Jan 2026 19:53:10 +0000
Message-ID: <20260111195508.106943-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: a468830b-8ea1-4fad-38fb-08de514bb6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G9iK1/54ndclReRBDWivCf2PpXYbT3mWIRBLxEteUN2ExO32LBMVf1OtLSTG?=
 =?us-ascii?Q?SrenKOTfaBJJ29kOZPmMRGojBNm6/TN4KHjmhl4x8PudYQzjzuNLnea6LaPq?=
 =?us-ascii?Q?NLVLRprp1yY7GyZWwvtGGf5092M0skHl+ejacw73iGg3cHrJI4yMrrVqZwV7?=
 =?us-ascii?Q?qOU+Ntqi5cLiecInZ9wrM34b6GzeQ8yaI6ZHzdq6JOKq8SBnArUv+FctQpte?=
 =?us-ascii?Q?0gj+3o4iibRb172uVRW+XN3GcPzfujPjOZ6WC75ZWK11K/TUYCCBZ7LS9q0B?=
 =?us-ascii?Q?cMoXgSeE2FZMML05+uPBhT8wMeGXDN9Q+En+vSQDGhDJIURBvzCAHluf47yl?=
 =?us-ascii?Q?qB3q76PHw3GoDGbJmT2IsJKurhVuQincPyPqoEARDbdSin+REiIJ0J2J4J9z?=
 =?us-ascii?Q?hWaddK46VYD9QReHScDwHqA7JMPgQzNPqpkdEXxE617gFSQHdCLUzvyioX58?=
 =?us-ascii?Q?SGZC3ZfnkSJ4spL9EC9LlPor4YEnR+/WWpxYmsCTnIFRr49R/oxINEPOJhOI?=
 =?us-ascii?Q?zfNmbpDOzjBJOfQbeSgLH2toNeNXwGY9Qt5HkIzDTrZNvKsAOnCo/qZs4RjF?=
 =?us-ascii?Q?/sYG+CZLGkwKXsulz3eQ0XQ3QGYlzfnLA4VMNqQesBuaEn3/kQJOOaxQQFLV?=
 =?us-ascii?Q?Pg7PRIiWBqGyLFfT8jAnEBU+s63CY2wbaS98nB2ixIf5k9uH4TGAcYyMpMzy?=
 =?us-ascii?Q?VGu6KWk+os4n90C3aTKXnG5nGB4rXt0D8z7g+obzrnVswsQmbaBgLP4AaNLN?=
 =?us-ascii?Q?VbxxfM608IM/6X/BkWnijVzYEtckawhOpvLOy1rTf+qguez2MA2iyFOcc3bQ?=
 =?us-ascii?Q?lhXiQVryLSjZENbJ9B/KILKPEfOnHNvj+S2b9VfifED+Qhg58mVle1Hhhcll?=
 =?us-ascii?Q?2Ifu8QzGWe7hSlkRNseELXVIHqUZJTarX4rKycrX8OrOMx7sOjtzPzXM0Jgy?=
 =?us-ascii?Q?dGH/msEmLYhQCejm//wGs0qIdNAdG4IBKTWV/y3TnoNO2+etg5foyxqsn8AL?=
 =?us-ascii?Q?mnuIvSoQcAJNvasViZDOpHSZ1yveIZoEEVeidfxdUgJfKOlR2R8OMuy/nIB/?=
 =?us-ascii?Q?V0BM8oJnpd+wWz630gC4MS5tMBL8T72vs0x2pWNhEARHoiwQBq3ZONARpaF2?=
 =?us-ascii?Q?dc4kkUuuvXrUdWoadjx0amL0VzG3NrjZzaSgw3CpBreOSSWKf9zXtXUofzPc?=
 =?us-ascii?Q?zAYBCrbXYC3q/RJH1Q7lUMry/tZUzsaolCeqT9Ycti7n+fGp0QZhgJft9azR?=
 =?us-ascii?Q?GGMQ+uewutKlsrmcUZDkdVeqWD4DdxaZric+yWC0a5F6iGzAiLW+kUpEpnTY?=
 =?us-ascii?Q?6NRHe5/p28NQV1Ei+EHx6O68Nwhc8gFI6hfH38YNPMcDP3MgtZ3Iygb2C+49?=
 =?us-ascii?Q?LzuJyhlnCR7yuOTkJy0nzJ/4beDcG5qLwFsRmeKVGjmOb6XFESl2UWCA9Ny7?=
 =?us-ascii?Q?ijTCvVONQTEYwsLArOCykMFrifkFfrOvDLE2l+WDE5zTu5I+qEDE0nDj1gZs?=
 =?us-ascii?Q?qSpjq3FVHjexvtxV08mWgqyARX+0NNBJSFdnnwEWxCY5IE0i4YmrQ+/Es3eh?=
 =?us-ascii?Q?0p0qq/Wm4mE2xZ/QDWU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:56.2448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a468830b-8ea1-4fad-38fb-08de514bb6c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


