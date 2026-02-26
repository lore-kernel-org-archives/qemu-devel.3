Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC109FC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyw-0004Te-3s; Thu, 26 Feb 2026 05:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyu-0004RQ-70; Thu, 26 Feb 2026 05:52:32 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYys-0000l9-G5; Thu, 26 Feb 2026 05:52:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szxhX11a5Oe00FJl2/7wSo1s3qt8t0NViSSih4AU9nVwTax0AuuYLk5ocWqAK12mrOnbf9aqTVTp2h2R5bwHZCN6OCw+3t+Bp46+sHFPo45cGuRsgQj+pD8cEKfC4HBILueIKT1vuBYdRyorrtnKg9oHD5Qp3YIbOCRWsiXGvExRa1p6KGQJTAus1aoNC5fIjPMzSRis38dE/3eVrn8jNGQbfn9mtUuMWsvPQ97W+9moSNncEHrdajhpqGTLKuoe/IPLQFhtlk9Z9JEmAZO0GV4PO7OzMnESi/KKpsqyK5nnjci6aRtleEIdqE5cnXiM0xX8W5CnQdSRfkhrXguz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVEa3osZWa1dJAq0UCK1z7aAjEv4m8Xc2nH1snTADKs=;
 b=FXw3tfSGVNIX9KDNjUOOrlb3xEt+hK+J1K7MxEWuA+/kZlEXbWWkubJPyri3aBNsPF63ri+//EwH9gOykfSlWt+OwUT1Oyqfz6qiAaDUzVNEnESGJbwrvyjLxyUNN7Ni74ldCY2NdMvOxzBz2aJnrObbFaBTNNaVy4ar1lezPChSo7V0zbk0+qJ6GQcam6mwT+hKS97y/ChJ2sfEyxu+TI8BXmJA+cc+h8/FYGL5uH2SAfm8DZPFN4J0+6TvW3FsBcjcF8vSwLyqDZJn31tCuFmEGqecNGEJFADObPZP4xbgBfnDtbILC2VUMeE27bdcYLPmkZmXfg2tEqhglTk9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVEa3osZWa1dJAq0UCK1z7aAjEv4m8Xc2nH1snTADKs=;
 b=badpoZFN1E0baojzenV+pNbdnxqWC4VhfFa/IDm6iklWSUsHM/G9kleJSHeJu8Q2kwkVr20rP5q8Y5GUJkOeK8rrL8adS88MR0lfjlvs2wKhycG6u9QnCFqBpDohIh8pPdP8qAwcIHWEK0rRp7OpV8c6sEu38yHq//prVxw1QjiMjgtsYqJkzpz+HPgBZd7H/sdF3+epLiqRKndY0jDmwOWjh4jfQJ2H6gJ3BN6Qhl6KFAuV6OuQ/PrWv0uagJRYw7+k1KbGebfHnsLOQYOzxBS7V8X3gJSKZmh0heT1OaRkMWPrV0D0ktY2g7UKys6yjoW2R4ct/0iVh8xmIcjUhw==
Received: from DS7PR05CA0038.namprd05.prod.outlook.com (2603:10b6:8:2f::23) by
 DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 10:52:23 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::9e) by DS7PR05CA0038.outlook.office365.com
 (2603:10b6:8:2f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 10:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:07 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:04 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 11/32] hw/arm/tegra241-cmdqv: Implement CMDQV init
Date: Thu, 26 Feb 2026 10:50:35 +0000
Message-ID: <20260226105056.897-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eb7206-0811-4f58-9e21-08de75251f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: 76JA5euw8YJs0irStKYRK5mKrvfNYoUu1bfj93z8D5sN1+uPO0tJqshkial8d3AuSKm0nhp4SiO/N70uWw5q7HkEXK+tnJUxbGqM3iJTXqdrSiR046MGf81AgoFIrfU/0q1VofMWUOKkk1rLzkwqTBoH5ppOCG5qHy/ASJjcozDgkCpH4UhT7aQ5MlHsbL3fjsvo27nihIYsZIF5ALEd1Mi1TqBlUVWJSzEUnQaQ5GMD+C3vVpyizazO3ifOdQsMx6bx4p3IYCAxesAkjrMjSkhjdiuKLGKTR2HjkEnNJtc+xq9P3h/OyAST6R8sfhCSRxyK8TFzX8L8OQGSYUo4QYF46bmKsDSoA65lPu/UEFps4nRg4aEu1XFQgNyUpUxs66Kn2pbWkuhIlQ6tdz3TwYbCpHyVdjLbK3H6wIR2ZwNEzbdVA9nCJUmwWxsXeimViXQuwMhNkpRNS3b1uUWOO3Jcs2T/Zk8cK5Q/ogGTmt+V/llQfCvj4uQzaW7+wI0SBvUgLRRHV65yM9Kh/64ba0Q8fBZ5LGCh6BRDiB44tFWbTNU60uqP6JpSaS/uiPem+i9uWtLilNwsLOi/WNAryivo+s4qWimBMneb70LchSFBNd0RGyQiV2PBCfeBWVPwQVXUySY4cfHRyP46P2vBzzo5j2XQDdWlzmM+X9o53a6mgPpXqnSHwIf5xQDfh4Em8e02lYLA2yd3QuTmCVNBTdIznpCd6trrF5S58CkVHBvIfA+h4FRaahLEP7pl3RlrWKb38VnFw/Usm9aBuWUZO/mAL/OwiM2kV3V2JCFQdsKBQRIOlCEKK8XgIVvy9O/bnvA4OtgdaU2qNNvk5pge6w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +g/EUu8zN7lKzA+8cBsGo6uipSi8s1vJWr9Ilk3yJkyuv+pH8iw/Qtu0aIlYfjnntGe6lEVQZEwtPrAxw4cTEw2JLlIzWUUhkNBtfQJsiIFdxJOtLfCnyT0jM6qh5FnAxHvBklSiEXoYi2CC6egdBAzvLu49958M7MccYLkUIgkX9o3R+SgBIk4iFodED3JGL309vwfWYLZ3i/Cf7196Aa7H+5BwJ+4+duMUf5bknlSIyFoq6J2bPett3yl2YATgX1miYHD6cWoOIIUpapHOzvqQ6uy5m7PsryIimmnWb6nRJL967zupB7Z2gaeDuTs8NWTkXbNHOT1xDUjDNnPncNKumETL8qjCxyYWva0O+JIMPXWWFYBAo/s4D3h2TlQQjIV3edk32qJbC8ZAwqD2pd9CyoNzFNyFUI5/lKWNeqzg2vvRYbuTSXGgUCAHJg3v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:23.1884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eb7206-0811-4f58-9e21-08de75251f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
(VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
into 64KB pages:

0x00000: Global CMDQV registers
0x10000: Global VCMDQ registers, Page0
0x20000: Global VCMDQ registers, Page1
0x30000: VINTF0 logical VCMDQ registers, Page0
0x40000: VINTF0 logical VCMDQ registers, Page1

This patch wires up the Tegra241 CMDQV init callback and allocates
vendor-specific CMDQV state. The state pointer is stored in
SMMUv3AccelState for use by subsequent CMDQV operations.

The CMDQV MMIO region and a dedicated IRQ line are registered with the
SMMUv3 device. The MMIO read/write handlers are currently stubs and will
be implemented in later patches.

The CMDQV interrupt is edge-triggered and indicates VCMDQ or VINTF
error conditions. This patch only registers the IRQ line. Interrupt
generation and propagation to the guest will be added in a subsequent
patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h   |  1 +
 hw/arm/tegra241-cmdqv.h | 18 ++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 30 ++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 5bdd01afb5..7d6e4c6b76 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -42,6 +42,7 @@ typedef struct SMMUv3AccelState {
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
     const SMMUv3AccelCmdqvOps *cmdqv_ops;
+    void *cmdqv;  /* vendor specific CMDQV state */
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 312064a081..46aa9e8a9f 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -15,6 +15,24 @@
 #define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
 #define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 4
 
+/*
+ * Tegra241 CMDQV MMIO layout (64KB pages)
+ *
+ * 0x00000  TEGRA241_CMDQV_CFG    (Global CMDQV configuration)
+ * 0x10000  TEGRA241_VCMDQ_PAGE0  (Virtual CMDQ page 0)
+ * 0x20000  TEGRA241_VCMDQ_PAGE1  (Virtual CMDQ page 1)
+ * 0x30000  TEGRA241_VINTF0_PAGE0 (Virtual interface 0, page 0)
+ * 0x40000  TEGRA241_VINTF0_PAGE1 (Virtual interface 0, page 1)
+ */
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
+typedef struct Tegra241CMDQV {
+    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
+    SMMUv3AccelState *s_accel;
+    MemoryRegion mmio_cmdqv;
+    qemu_irq irq;
+} Tegra241CMDQV;
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index a270fa7ce4..6959766129 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,6 +13,16 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
 }
@@ -29,10 +39,26 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
 }
 
+static const MemoryRegionOps mmio_cmdqv_ops = {
+    .read = tegra241_cmdqv_read,
+    .write = tegra241_cmdqv_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv;
+
+    cmdqv = g_new0(Tegra241CMDQV, 1);
+    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
+                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
+    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
+    sysbus_init_irq(sbd, &cmdqv->irq);
+    cmdqv->s_accel = accel;
+    accel->cmdqv = cmdqv;
+    return true;
 }
 
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
-- 
2.43.0


