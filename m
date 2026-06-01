Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B91CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18q-0004rX-Lp; Mon, 01 Jun 2026 07:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18p-0004pW-Bw; Mon, 01 Jun 2026 07:49:11 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18n-00050K-OI; Mon, 01 Jun 2026 07:49:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgWQuwv+PVIUxV0VvAAHF2a1YROoucR/cdmmOE4nXQJUuF9w7uZ/aBUFQvcPALzKh/70b20G737qWCYnSAvF9W6ckMBnsPpqNo7DPyzz+2FoWced8zj6h2WQRLhTd6GR1xd6gvSf5vQ4YPofNwjDOB8zetPjxZGjIjpIX86x417QWWH1eo+7+G83yzzcq9aHgu+g/k/ZlMKZEuvDRnS30Y45wNnrzioEfmYSrP36/LzXp0Bc1L7c4ec8zneyv1KHjv9t+FlMOFwte+vnLklgA7LsS57X2+a0GWkMmMT8xgtSjGv6yUWUWW4NbbkjKP28/4gZqXZs4bYl9ogzOXPm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IuFW/AXKXBLz4DXRl3uzBkPnqCqRHK3pEzAOM1nVg0=;
 b=bRitBeQtfJ9IusqjdJAonXwdvAUZQ72i1F3tNEjpsulcjYWMtflkp2Z+vNTa3j+DAZXFGkgx9xuP+0j9a7s7/57LVqdkMKBGtnJECAmB3Urj0GHKjMLEXsKHIyeB+l+A/aPnSQ69ZCIGPtoN0G/Q2NrId6BP9/dLI5VwYhZ7QESaGDSATxXn/q2mc6ZnKyCiaUxMLRGxvRsfDGXs5hhoV0THxAuZzbsOhasNd6DM4U4+FkvtxrDB6gpyET7trOEQfxQ7IvJ9V4DrHoAIeg8fQSUiIYgfzvDukKCOZqig0DCOKppcwm2rDlrbXE4vQRCbzbd2X2zCG/WOtFbQhnW/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IuFW/AXKXBLz4DXRl3uzBkPnqCqRHK3pEzAOM1nVg0=;
 b=uBtXSWiXtlIOTkkzAqmZapjsJXRlFdgSOzfNFGOw1Z71gjzEL9vZQgIrCA+CJNGDv7RGntol+nBEVIEUsQiktpsZtHLCmY2CLSLNMcoHejlIUZYqrTnG/mKdJLf1L80XDPphOtaJKi7ZpFqwb3yBS7A/QhF5is45gRKC2kAxEZT/TH9GfpIx8kJigPnie197cy/Qk49DoPt7pQR9+aJCPUYvkZzi1r/ApBOqggxmTK42ivblcZxw+P8dKNmhT1sF74E0fOFdlp9tUJkZu4IWSMsPYRfsNQnzbpIE6bAzKhmYXDBtCJAQqiQNFNOqttXXQfC3hY39LSi3YNb2r1EPvw==
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Mon, 1 Jun 2026
 11:49:00 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::73) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.18 via Frontend Transport; Mon, 1
 Jun 2026 11:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 11/31] hw/arm/tegra241-cmdqv: Implement CMDQV init
Date: Mon, 1 Jun 2026 12:42:01 +0100
Message-ID: <20260601114221.457995-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 30740349-6482-4c53-1809-08debfd3c55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099006|11063799006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: j7vyPOczbQm6b6kK2ArzBRLggIZDnCcFZrMuUwjmz7W0ZgarsH29VixX/io+IvM2WO99M1TqiIv6vllO446SaCPOx5hixnmZibusx4wX3KHBNWw5VvpcHmN6iaM+z3bXZniNLeUCCVpzlnAcgOaAD1fMejcGZfIl0xCxhKOBrfGMk91R2Kbv+FwTkzju/pgI2yXUGfvn6pxlIatUwQJlvfE90p4EMSCjDJlN3FvRlzDzEPFSnSo/mITiRZQBg1+H1rSCkrb8x2/BI7weoDksMsityrMkWls+8EuG0BWkVH0zBwaKepnE2rO8NdLSkPK3+JpMoq1Nc91hz35thk379q9ELN6nNY8MBK/IF8GWdWG1EFzPc73+MOaBVPplnCvCPFEPvyeUWa4kSImCiWuISngiYJIitsIntzbVASVRtRC3dF1vYtIWFJYACm/eezaKhlbXD7AV6bI4z2nr0FrPh/zopznxkycLaZSRzxTksZfVrFjm5TKbdWT2QysTsMklqpe0VsleEKFMZ6ecJXxkwy3xgX3XkBaeY3pf3YLuRGHF8u4dp5VkiLSQcxrvw+POBPdKh6nTzZ6zJiWs8ax1hJZ3zHk32m3gsuGUWLFEWQFld1OBE91ZSQL7PAzmYQ+sq9H5X2DngFOqkS9bz2M01AjZ0muktWUrMzoeSDyFhdy7VxaQewe/M0mp4F5W6Lsd4LL5T8RbGxUIIvdhiXBZLqIhsiVaI2EyfONXy/sa2DQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lAXaM4anbgUhUpgn7Gv+/LQmGG4uPmLNsEg+FE+g6R5WLda2xDry43cXsR4U4HqbBXm8fLFtaex9vi7cFHr85yiWKan2hlKv8pV7zcTrEnvh/NdLBeyVmj1IEvmXKpiDDrFfxgz2UjJRCS56n5viwOgPzNXyVf/odERsBw4u9D5YtTtl/eYPkaWNB2lsxxa37KGfXZOfU9ClbUCFNjXDLdo8L5WkfWNrjMFCFcGWD6ewlsKxzUF1OjuzcUdZAWkOXxGKJrDBbxPInDwyCfx0VWc2u1TNJEB/QqgZ04BUje4Wk/KWePAtdgton6hXs+W3ZIa17VrZkPXkk0lFX2am0G9lX3BWf5m4PyndTVocHxA3VBEu0NiOlIa7bOuL9Ld13RDFhlfMlv+XXsuzPfZJEUHVJGDcLsRDrzhxkHb91VrVAXQBkyCc2nouiQ0OKO8q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:00.1726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30740349-6482-4c53-1809-08debfd3c55f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
(VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
into 64KB pages:

0x00000  (CMDQ-V Config page)
0x10000  (CMDQ-V CMDQ Page0)
0x20000  (CMDQ-V CMDQ Page1)
0x30000  (Virtual Interface Page0)
0x40000  (Virtual Interface Page1)

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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h   |  1 +
 hw/arm/tegra241-cmdqv.h | 20 ++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 40 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index b45f25ad03..e0bbec8581 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -61,6 +61,7 @@ typedef struct SMMUv3AccelState {
     bool auto_mode;
     bool auto_finalised;
     const SMMUv3AccelCmdqvOps *cmdqv_ops;
+    void *cmdqv;  /* vendor specific CMDQV state */
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 38c8b27b4d..a5f65a8991 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -14,6 +14,26 @@
 #define CMDQV_NUM_CMDQ_LOG2       1
 #define CMDQV_NUM_SID_PER_VI_LOG2 4
 
+/*
+ * Tegra241 CMDQV MMIO layout (64KB pages)
+ *
+ * 0x00000  (CMDQ-V Config page)
+ * 0x10000  (CMDQ-V CMDQ Page0)
+ * 0x20000  (CMDQ-V CMDQ Page1)
+ * 0x30000  (Virtual Interface Page0)
+ * 0x40000  (Virtual Interface Page1)
+ */
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
+struct iommu_viommu_tegra241_cmdqv;
+
+typedef struct Tegra241CMDQV {
+    struct iommu_viommu_tegra241_cmdqv *cmdqv_data;
+    SMMUv3AccelState *s_accel;
+    MemoryRegion mmio_cmdqv;
+    qemu_irq irq;
+} Tegra241CMDQV;
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 3a19a1af56..2875affc8d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,6 +13,17 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
+                                         unsigned size)
+{
+    return 0;
+}
+
+static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
+                                      uint64_t value, unsigned size)
+{
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
 }
@@ -29,10 +40,35 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
 }
 
+static const MemoryRegionOps mmio_cmdqv_ops = {
+    .read = tegra241_cmdqv_read_mmio,
+    .write = tegra241_cmdqv_write_mmio,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
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
+    cmdqv->cmdqv_data = g_new0(struct iommu_viommu_tegra241_cmdqv, 1);
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


