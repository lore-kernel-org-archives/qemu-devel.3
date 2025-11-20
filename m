Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6627CF8856
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fN-0001GH-9Y; Thu, 20 Nov 2025 08:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fG-0000oe-7v; Thu, 20 Nov 2025 08:25:34 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fD-0002dO-OU; Thu, 20 Nov 2025 08:25:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaoU8mNdLpEGbnCVM15uVqY4Xs/CKeW0JbCF4McL0VAElRuZqXWqQeL/Vhq6JM3KP2wdcxQUvX1SGZ9aFNDd32Ykj01N26eiPsm4ZB+IOAemi3vUhu1snXhgMnQnT82Xzy+n8MLIDrOW1XF/NVRsQMFDWNCGk5CRM6roOMFdTSipA+Usbwwu0nNCRUPkoC6r4iJStfpUQE/9zbcP7ByZRx9Zny8OsMf5ayNtwZz+x3JI22ou5YQQmEpRk/eRagXj1NNyNPOQeiKWe3po7uDtiTaTG29LlwWslMJ/Ei4pt0qLBwQ9WYTdN0sFFgRb/O2YgokBGGI0LH6pdqP3Wo5tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79O+jvkZAMOHLgu1caSTvYvKYgGALQlLyBT2oiHQ8BU=;
 b=KPO68tCRrhib5cQTnX8hXMeKgsPZyXjsshmzv3pRLU3B+mCKIi6fvQcZ8kirFIHSNzPo8MikQkYiD1ghKtePEW1OFyMYB1K7iNxxxOp+4qSJ0JUAiR4sqMsTNjwIxvRfx2z97EgCWEdVXnmhn30H2kWJvrIp7RAHe9M8XrSoZ9l+wM6PWWCDm0JGRFBtAHDcXeY7ij20n+iCbFGRce97esQs/OmpLPgQoIn1Pm0ur1s5qI1bGUCDZJQ51ZTKmr6Pl56B8iJUfHrNGdjX8wI93Cl6FugJteqOaXQoC4wHP5M60tyCzgoL7BcbtDXCqdkly+/UNaDFHrMk1+5GpT30DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79O+jvkZAMOHLgu1caSTvYvKYgGALQlLyBT2oiHQ8BU=;
 b=J5u1ZD9VLtkYthu/d5+VCQxpTL1sHUQT0r/h8GhtTCwa209OgJVZ7Wl9XsVF/LaN1w2dVQknqnhRpc4Oaggd4wSjYFJEABR69hdWJCHsUo4o05XIltpEL2mULC75S9ezH+HhxfpjHzxFGh/XeT2YU1mghBJBbh6ctbsjmIyeF1z2bIFBKfv+vB/Fq9LpyuGkAOPHuSlzruBw1mHO8kW3ex4ky+8ZoUB0u+uxbQ55Kxb8GbqU6k93X+CiFMKAwou5gLKYIXy/VMRO281Ib8MZla/TUOHPxOz0+DI0yylQP/RrfcZEllpq2HM8xnfYcJXO1Sj31cXvpTc/m91JTsO8tg==
Received: from MW4PR04CA0049.namprd04.prod.outlook.com (2603:10b6:303:6a::24)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:25:24 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::87) by MW4PR04CA0049.outlook.office365.com
 (2603:10b6:303:6a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:04 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:58 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 24/33] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Date: Thu, 20 Nov 2025 13:22:04 +0000
Message-ID: <20251120132213.56581-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: da038fc8-ff32-4f1f-b0ff-08de28384308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?coTbS3/3ay0NL3MrwyRwHntWiJ5/iLeBJw9QJmF3qhq+OZAylx4qZZwPbLnM?=
 =?us-ascii?Q?GT2RZL11Ie0Q+sr6sOW1q5NqRCnvHubnXI9nI1F8mqWVYT4x0McHudgZuJP7?=
 =?us-ascii?Q?d90fE6PXU84SqdR7+4Se2e8e9bO811/1FA7a8nwuy++oE7QY8rvnKWcTDeGA?=
 =?us-ascii?Q?3jhnLsJDPBzgOs3xt9EjTliY3DcBPqA2fTbzrdKQNEfM09PCugRUMeqQylHR?=
 =?us-ascii?Q?YFusaS8dcITL43Q5GMrjcuuejULFzn9wcTTOSPKNC34H+3KZP6whLJn615Ga?=
 =?us-ascii?Q?cpHfdPQydqua1I5Dmy8hhnAuwihuLAQ2I1UXWoQzXkoZh5pirbfHFuk+u34V?=
 =?us-ascii?Q?KPqmUETiZCETyEc7bSLNS9Zrq6O2gDEvLgGtFzB5Y/ciM8gBGOIIaUblELpQ?=
 =?us-ascii?Q?3Fi8XG3/8r2DVJMquqMzm4HQFpYHMd1fPCEjuHJpMJ0Ke8xfTcPdg5xsnhGJ?=
 =?us-ascii?Q?9HGPRpYjJ5KUcZSFbOYRf6IuXBOcRAa9SrWYdbpkwh+lLDjYQCHM5mk1WFJw?=
 =?us-ascii?Q?2VAW/FsgVo9lfmdfILfw1/2gLbW4WO3co/1aOs8EZ471Dh/mCFLr2oJYUm88?=
 =?us-ascii?Q?j84Izenc5YDu/eF7aRVPwOCI/2k7vXq0qwNeZj2IIWh1RrxcWJSRuFJkDfK5?=
 =?us-ascii?Q?xGbUMQzKEx5hF9mJmsqWLNrZQqUFNRH6iMEMriW1QS7H19yq3hXcQwFXYXuF?=
 =?us-ascii?Q?aCqnCSZFOrrJqQMmsl4eRXido73U4NCojN2ZdC9AADxtMIf9QkE7qzo+DYlJ?=
 =?us-ascii?Q?9hU4X3pO/W+6Hy97uEmQEIjsZb2VeqKEbI2dbABX+oajypRKJgM6Lm31f3Fm?=
 =?us-ascii?Q?3BeH5ID+7lSavb44gy7SUdt0RKPGLSbyNQzoUgfKIUEaiKbr/ahOZOhJrRo9?=
 =?us-ascii?Q?hEd94sGBr5y8q23jVoRfUvB/dy7qsZZM4Jf0hghbRFSHGOWXRW69owzSAS5Z?=
 =?us-ascii?Q?E61Hhjk6mYqPEU7qVLGINTH0ZKQDkgOS30S5edHvSiAE5qQS+fHGwagpcqTE?=
 =?us-ascii?Q?iilqPVdLpqdRREAyIKUCMsYh4S1iky0vibClrc7l65dA9/YN58TEwwQkwb+d?=
 =?us-ascii?Q?73nNClKIw6+6IL7P3H1O8eWRPjAQAsU0vhccMLB4gmtYRfmK4jvFZ7H2+oSU?=
 =?us-ascii?Q?/UA9u5u6giCIQLycv0YTlRsXlxKuPl/fXsV5KdTxIaV+iF66xKZwDtoZQaQi?=
 =?us-ascii?Q?pvxD/+dB8uKmITIrZxZCpCSyto63ZfvY2tAs33+ksHlk/pyhHI4KaqfvWM+P?=
 =?us-ascii?Q?yBB0qsRPVNFwHozIwqS4YMqiEnTtjX5i0nWJ1/yFCOnXZ/FzzMZLJQmtRNxa?=
 =?us-ascii?Q?6rzg21mxrKS7ZXRfQRJXvODMnJ9W8tiSCHSHHfWoT6G0xUrViCQbDoJPH34e?=
 =?us-ascii?Q?jgZJpNxH4uyQWygm8UTWmy0W/p5WuzT8B48yJMsRmSdAfbWqOlKhGO+esI2T?=
 =?us-ascii?Q?fckvBkCb3HxONVlA1t8j1cxvWNNuIVHTCh0HoY9Wd2Gtgy3vsIoV+wtmmDQd?=
 =?us-ascii?Q?zEgrZ6SkAJlNeYQ9Oh443V7yoLT0nGksIzoU4AsomI7FCeCRFKve2s5sDVtp?=
 =?us-ascii?Q?da8ZyTSCoi4nX1Msj28=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:23.9550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da038fc8-ff32-4f1f-b0ff-08de28384308
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
index f7264fe8d8..7a7b2e62c1 100644
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


