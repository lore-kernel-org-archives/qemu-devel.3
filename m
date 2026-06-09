Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4A4CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudJ-00081G-Rj; Tue, 09 Jun 2026 07:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucd-0006cK-DY; Tue, 09 Jun 2026 07:27:56 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuca-00031W-3W; Tue, 09 Jun 2026 07:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdV0g6829REQEkRL2pxqxf95a8Ty1E3GZGXDLQi7SekeFkYqH6K0D/LqpX1VUt8p7Q8ER2Absd6zcucFd/eIxvqkiotNG8vUocH7ovDS7gE45fikFE1AT+5DuKgcP98D6JywVm+5XZJ+lceBI1AsYMBYCYkMDx1UcevZjsddHaqKpmaCMqkAmfOdQ01rzmIDdWqiamP82nOO67IhMxffE5b40u2P9TFY5piI89XBIoa4ZSXd/gfJpRrHX4ZUj9TefjWh9PwASmPHvPVROfXZ3PTWrvUxZy6nULOGSA8ysI+gosuD+Vy3LNq7RXIhDOY0YWvCdosWr1+KnWWc1hLnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79EJ96F8CfWOoJnElUdtMAUAKP5BvbxBgPqOUme6PZo=;
 b=rFjV1xpjUa6+PRFwkiGNHMu4lC4y9S0Nuf2JAQxv5iQBv6ys3Q2LQKnCjnvhzttROCMXSpkFUMm7LykxNiALoLSrM0dYUL1m4khZcwTgXdM+OGirZxG+klUySzk+7IGwWzYMsUtG3x60T75WSR/2+rVT0bQhhKA2zZ67wJjhvIwz+5WtWPU3cHkqt+MVgApYE4KMU2Si90YAUBOrMhuTKMldzHHA/drcUgzSliO1KzZE8TZko1O8f/0OBqkQV1WNYfg07XVYwnY+0kO9kdX9CoP7/l4SKUl8KqbjZiKxEocEAnJtFsWUAi+4Wf3HBohP5qQ7PoL/qDLX7BAWjxSG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79EJ96F8CfWOoJnElUdtMAUAKP5BvbxBgPqOUme6PZo=;
 b=Fv8IIRh27SZzUA6TvRTCSQTEic4kwU+sg7SRTfNz7fxKTfWxbQnBfAMZ9Y8H6nhdvTMQ4TCjFIAZstYVcRPunR9tZZg9kbcXZvazWZzhEKd1aHZh6xh65I2E/uzOv+mozpWOMSNTGEgud3rtoikDpnYgpknAf8Z0yOdaITJP/KZMfKvlH7o5k39CpQxTosdoyLsNVFa04cnbVaF/eDCzWh7fxmBZGei3nQXTH0h+CsEnf7VmgJ9ewHRD1maEzF0Zl8ot54g0y/ovIKnSJrQfRIPAHCZAOqBvyJWH2bfHM4Zb87J3xzjNyimobIqYRy3Q0m7niAcZ5TV49l3YQVdZog==
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:27:41 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::a1) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:20 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 11/31] hw/arm/tegra241-cmdqv: Implement CMDQV init
Date: Tue, 9 Jun 2026 12:25:32 +0100
Message-ID: <20260609112552.378999-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: e11cf676-91df-4b34-4c8e-08dec61a1e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LmavQVC5B8tOZ9dxpUq3fCBSdB7aKuUjX7HwlQdzfa3An7Op8iTF1xm+Jo+9EULKW5eUByw9hLq/9HX1XJZM7z9bZbAfcH+1lRmgP+qZAUN8FvQ1GL3JypSx8PZMsRjn6KWTHmHRzv8YvLrBfXj9Z0UAa7rGEV+Wiz9duZFBpDYpJXgEG4ClKCQiIF3ivcG20JjrgJuSWaaq4DTFrWiYWfu4Mgfzcj5HTe9XFXdP/Qvhnker1339swRVSYhVbSqkLBkUXlBKu1dQe72b9uoAaJppHZVrCm3/SKuqOyN2OWgOVXfNIkujSoP8V/8UtVw9Mc07xXcwsVLhRZXX6dnuMt/hp49l08ITpkgjmY0YVr30eJvLpaTgbk/CpncJMcNaEvhU0YfRXQcRNj2DHAR3JCgN0rCLfBzb9kezBaujHzPmtmlbju5wrv5gdOECtfbemiaEotEF8Gk3VJokd200F35z94hMgN5dkyHdguedIFq7cHBtI5ZD47ueFo1esdJzyg/2aP6YlD6WyOX7ezck99/o+Al5kMlf5fHGm/wU2CE6i3imn22+DDHOF9SNKMe990zqe4xWlwTJd4awRUrDCFtd0dicdKoP5bacitrF8OyM/9UXOvYE9wFK58RVDsYOHLAzUXB7vfJQjQuJLv1H9L+hdCUEeJLk/oZ34fLT0WPJI1pO9oPeqX/KvqKFdfNDfMLQvfXxXphz8D768tvliKxR5j1nQHOxhcIOKEDmv6k=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SMJoIpOZkVdtO8OPWlhdMY7TrDhr7FsmLEYu7wabMTeyxPZ1odUY7HBHrdD08QXEMv7emL92cmcOGYc9yENZkjuVb00zqCIrmuW8JqdkZTMsP+YYP5DztzJfESdAWnVTMJ67eZPlLDUSFInB/h/iEXtN99itz/73j1UYcY2KQBEzNebbwvkJmKu3e9Wk8j3ZG0PPmeGFs40Ge20UKGsvnRCqq+BaZQN31ZdwTKQD4TdQCFmVB3mYc67cMQVV7BOOmVFioXnXdqFPSB/WHFMPC3uQQmWWXiJoTduxxjXTkW1p3iS6UjkkZIXVMuShCjELiBinmgO8B40E2j9JqV8X+f90J7R+NAsmFbPS0pqduvZ+801SJz4o6YqYn6x/HhVVRA5mihYuc+fXnKk087PPSL6aywFJYRA1/wWESzM2PUOTw3+hjS2+ax0b1/ZcZbL5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:41.2701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e11cf676-91df-4b34-4c8e-08dec61a1e5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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


