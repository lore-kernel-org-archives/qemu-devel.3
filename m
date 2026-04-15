Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA6CF41986
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwK-0000mC-3N; Wed, 15 Apr 2026 06:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwC-0000km-GX; Wed, 15 Apr 2026 06:57:40 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwA-00042G-PR; Wed, 15 Apr 2026 06:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUM9TD7PbF9NYJ9zSz8Fa5e3r/7gIADvrWEy86DBB7pZA+yQysJUeEFVn6+dANNCBvBSp9zfLPWQarSCOLgpVyfrgOG2lZRuzxZCwnhDyy5/G+rmGIfK61eJD+40a1Amwz2wsPtd+sfM7vWuPPUHz/jdPLd99dTmpZk7rgdahUOHDADB47SrEhtAt0EK+WRhenuctUDR8gwcUta9T3xBrP92LRSlrNweKFkYXaG/cHAeEiK4qrJruHpruzuxgcknZSzx/3gZfS8f0W4Jbj+2buKs2BQmrmO96i13rdb5iL0FGZduIewcfi3hG7bcSv4zjs64QEjpci3O8aUJrd+oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5HWMQ9wVn9J92XULD2kl2dSQjKbHbZEZ0DruLJ7zAI=;
 b=JeC3ugE4XE9yrYhQ9ooefk+34de8sWM7AOjdzRUUol18wccA0Dj3CtL3e+W+9osHdJWCT3nz0lik/4gN7MyrY0u/tjPH17k/nLu6Od29S/DXyXyr9wF1fT79/xJCMR4Khl2oTBue/3LyZPNtSFiczBVgzzaI7oQHS0T0YmQyYgyDwZOfkYQTjuJzfZ5QkvDPnm1p6vdhw+GOiBT2Qz2eVZOHHNdgnrpCsSv97Z5xHYoknQQqTD8AtZ8ChxXQhm4Zo8AjBRr1E6wP81DjIHOrFMXs5gMgqUxkVR+WSyPdrd64jLiXb6HLCvlmWNhBbPcyVY/J3JayVCcL5qKX7MH7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5HWMQ9wVn9J92XULD2kl2dSQjKbHbZEZ0DruLJ7zAI=;
 b=o7MP/bJEtLM0fkUVo+vcO07gM2+Bw9odaSWF1f3XmBt7nPA0n7TQF954IS8RUFoX60k+8q6I57pBzpT6MC+IO6sIbmllqFUA+FTG6KRU+caB3/t+wuvm5Vmmb+1d3DDY+rG8Yyg6AFpFlwPc0lp761kGCLDTqJjp+1leMswSxFpPcE54OvfFJ2msHC/lLPkVDxeMcQyPGTZlSrilPuuytpLSefiPmDUkc5//H66uEmwDhZCcM0K/b228OraxzmiwDWO0oV7EPotugXncHnzf9n72IrfB81gTA38G4jJQf/bzFjmeTMDAp7SrjrjM1axcM8El2XmTP9agVVkK7P8NyA==
Received: from CY5PR17CA0018.namprd17.prod.outlook.com (2603:10b6:930:17::28)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:32 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::eb) by CY5PR17CA0018.outlook.office365.com
 (2603:10b6:930:17::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:13 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:10 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 11/31] hw/arm/tegra241-cmdqv: Implement CMDQV init
Date: Wed, 15 Apr 2026 11:55:32 +0100
Message-ID: <20260415105552.622421-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 743ef4d7-eea4-402f-3860-08de9addcb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mxYAwYtE2aXQ8PPG9Tksod7rkIDsIcexUDiv1GAhh0ROwxDKdi8OSzOUXazlB4Gn/fqCHiJRAOr/FtRSnjxyeD3w1t/oL87Si6KnIh1ABjI/oxd+p4Neut7jCNCpcL6JRO080PTxvM2aggEBHiKiv2eHFf/4JeSiU7MFmPo/MZcG5jQwRdgCFofrgzZ4KYGeGZD/IoFvVeQPychMRguG9FNCg4Km9v1lEmPWadG8rPSnTzW0yOQRQ+5gR/YOSrU+G5uuP7qFQvZudeK4xgLrjkr4fFDuhwmlc2HoFrCEDX63HdqYcTfOsXXHHD/ZM8TwoTd96NnDOVuPGN2CCWK+MgnUhmIWt/RA5NymvnZkB3U5j7zKdWFDyJeClxaZzXbP2Dvbqkegftx+KOeFPwTwFFDIa4/yVdipRIj0ro6SC5qi7aC0wIMvsh3LV5jNrmHEV2klLyy16YE6sxH+hjYKeVjBwEEmEhrWMKKGuzlvMooTThaGGl86gb+KCCNOv7twqPkTITNvCmDTZxnjGJ57OtnQbtwj96tp7pUIE7dpYeF548sxRISAdiyStQBnDncNA5dMsZM8S52+CWgQLU5POxlDjnoZ44bJiO4DOCWyJWTbAeShSKsfGnhPqDNCpWcYQoOPc0sYA0L9E+8jzR72CNZlVzxVjPC1X8zHRsoVMWGQhmGzc+G6Q+1a4q7I6tFwRCCeYKxzGK1r3L351/FBS2LtVL4NtwYAdgMhs5sFjEwKJHrPuTfw51SG+BAuYaz6G1QTI95VkeYw1oSSftvlIw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cGDXOueAWGQcUrZij9AU07nPrZON44xy6kRXLPazlmdA13t614hbmdmDPkmy5PkVtHNTSsTmrjuZRoG/g61lvsSK3rt/sQGSNelnYmjOl9OqI7tq7yl6lhOSCzlRwsjjFlEEwOGup+AVZTZyYhOTklkCKuLHAoG6FRKQCrtpzNBRmx7dLdl1N3bq08PYwRERplhEiewATT2iQQCyLAnOoxphL0FYUb3NzHG+HFA6B9EkJi/DGQUYsnoTvvlA4HcrN7s71VWfWS9cjJnTYphpkt4LVyiz3kU438VUDbBGNPU8ie6WMkn6fKIrWkfE5GirCPFcDP+6c+kCRQU4V+4axozz1usXMAvHTTWzNFzkmVwZQdIgz0pVdIOrXObhMldjYY2ktSvY911qqCYUsFc+iTutAVlxmssqRrl37+TEbAX5hZuBaq0n2kwjVyRsM43W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:32.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743ef4d7-eea4-402f-3860-08de9addcb59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
 hw/arm/tegra241-cmdqv.h | 18 ++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 30 ++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 86301afcb4..28bceca061 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -45,6 +45,7 @@ typedef struct SMMUv3AccelState {
     bool auto_mode;
     bool auto_finalised;
     const SMMUv3AccelCmdqvOps *cmdqv_ops;
+    void *cmdqv;  /* vendor specific CMDQV state */
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index c1866084f8..2a34a4b6b4 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -14,6 +14,24 @@
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
index 3a19a1af56..ccd3c6d275 100644
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


