Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87250CD5BA8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHr0-0007xN-I1; Tue, 19 May 2026 06:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqy-0007wF-SY; Tue, 19 May 2026 06:39:12 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqx-0006RK-2C; Tue, 19 May 2026 06:39:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U70e9wYFI7iwmOuPlkPdoHkUoKRQCvrfXmWJhVOMiWB1IY6T0N6RrIUwaKpXBZ5B24LeJ71GW0/zOSpgtt3ytr50LjqXYPJndOzel+DumRgqOAT/mVEwKB9ZgJsveiyvpavAFOVU9mJVHjn1Ffatvbm/LwzIYLmVMLSYxeD+DA5fhjP2SczBD6sl71bUqQdVT1fD4SOqib1R+sx+9WQBXldfs/KWl2bJBDjGJozOJuWn6qRzpOauWszcEco/L/mGpwdFoiI0NQGG+etho1Rrh389CDhEUwB1pk0nOiLa176bboEQmAMCjqqFF/SCMOiCZjhtq3iBiPESZWvhn97fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ds2Y+CR8XiYsWCWdLOZnt5ZQSYGCDFvc+NhmyzE1oI=;
 b=hqAi3oKvAYbzbrhzW4Xn5siNgqYXVTXj7EE6citIIWJhQClonvrI6h+otVVm3jbHzWCYsrqamckHy7hqywZ1C2k1SpPtyw/cFnCv+3jzsadn3Jax+jeLqWIyHyIafeDADV01bsWUcXzVMTMbe3ruepvW5wy2iu/LO3axG9fMGzs7camiMr5OvcJtPWCkHclyiY2eEKBpCC1GfL8F9Td8JdGvxvfal/pjESbrz83MEF0Z+WcBvud8C8I/smkMCSkchXkL6ycj/U2ZzjVNLFzlvdYSVlFiOwy2NYyF7m10KxH819hyRXi9yhpBcFK2tFQCLHigiQbJXo9msBsP6/O64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ds2Y+CR8XiYsWCWdLOZnt5ZQSYGCDFvc+NhmyzE1oI=;
 b=Sxt4ZZjAnfC2P92MgD/hsexJCwM/mQ+cQILrb0G6TXgD7u/OxwfFT+/UBypjMilx3RjK3oTRANd+LVo9e1AoKhj8PiHoCcjD/TgT+L3le3Rre/5My1knJSURrJC8y5PP4EHU6KsXm7uJ9EFTKCHgxmPqE0nGIcNx/x44gws46l9xKAGK19RWdvt782o1Osu6VIeNkTL55IOfet4S0cjGvTXoKShbhq9ehckQdACLP7uPcw/6PkeuPHGV9+2Wi8x9gFLxhjK0BM89rXBIWk7KEnPrpoduxJT+Oq7wH75Rb2TAtYikPprSi5dhOqS/vEV/ziyVOiEvSusK3K2TS/zMGg==
Received: from PH8PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:2cf::8)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:39:01 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ec) by PH8PR07CA0042.outlook.office365.com
 (2603:10b6:510:2cf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:42 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:39 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 07/32] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Date: Tue, 19 May 2026 11:36:45 +0100
Message-ID: <20260519103727.899332-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: b078d099-f8ef-4afd-45a8-08deb592d705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: jcbhExdD4ZH16zZfsleuKPBKewjg7Lf2sS9Njzy6o6gZygYKsMreBB30HGwP1PpJRZsRbYVzGy4e0Z7WlXxRKhRpugaec6j3RW+66FbdEdisToBYTkjstB7cBBpmNh8oVlJfTaJhI7lKbvz8nA4KJuVjXBah+mG8MSP46WzHJL9DgUxYoO7uswmQqia6GCRbsznbnCvrgy2TAjsDJ6qrfCsw2k5i0xz7df1fZximiauCXAlnRXBQynoP4/vZxrRaCMY+PRaIHUxQOoKpbKpLc78lDZUdMj33AF81uUz6DQLQ9fB/FLtfxqbYZAioFAbtcR+nD70o3WUQ/rwA3slj9HwT1y0kdiTGihcN7Ig1T9mZwwS8ke0obi5WfhcAvIcgHef5c43pCO7b5LTiUQNcFsUP34lQICIYadoX9UKCs64Z8HJ7QxBqVDPAtyZVZdU5tP5ippzNmy2TKSWMUILZVtgzZhMCxGG4FUevAxdURstlh+9vQyzOjgyJmFiZOhg76gzAMXnjzSH0vGdH2WsbWBMdKaiaqOwpzpF1JrO+r+F96q+yEBXP7wMyKZvK8RNvdgmWFf7VajweeNGSapaPlIGC39OC5oNAPb2AkLRw2pb4JsdZXqA5Smo9hA5rKTb0ucgbFSVsIO3pe/XsQZ6CWlNr6Zm4aAIu4pguuTa4tUezUtair6NMHU5y/aVA9rhG5qzrzn7Te8gzT8hR2TsaiPhBNzrTUG8cOktkmPyqoRQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FlbPUw/fBx/lSDLPqlr+M99kjTor+hYb3f63ClC7DoFSHfGEOAhoCtmVIbkcDq5g/zKkNF4MljQRSXkkmzQlFJk+cKQgO6INNwxpdhXIX5P6+9+AoUI2C+q41cHrmR5g2nenyNXpg2OJvYOnrJx8GDamFy5+9NLhXAfsaFHBgWX5o2nXweuc8MT7/POHtLqBl4Wz9gWm13Pxll4QtvxTaxJ8lEFHKewYpdVuWfjbCEWbXoLgPXuWqQv2oR2yH+CfpL40tHdDE0bjScpvtKJQoMyO70yw+hipE6NywPkObZJRYi7jsVsMtA+j+0x2z+Flb55qEP7ftiR2P8yA9YPfwB4g7u+p0wCWb/1TTI5JF6xyVC81A7hqxg8j1Nr3V8a69rw5VksPYzCT96QlnuDVMCV1tYgONgbZtsPtYC/S81XZA+whHzC9eFjKU2MJW/Fg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:00.9088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b078d099-f8ef-4afd-45a8-08deb592d705
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Introduce a Tegra241 CMDQV backend that plugs into the SMMUv3 accelerated
CMDQV ops interface.

This patch wires up the Tegra241 CMDQV backend and provides a stub
implementation for CMDQV probe, initialization, vIOMMU allocation
and reset handling.

Functional CMDQV support is added in follow-up patches.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h       | 15 ++++++++++
 hw/arm/tegra241-cmdqv-stubs.c | 16 ++++++++++
 hw/arm/tegra241-cmdqv.c       | 56 +++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                |  5 ++++
 hw/arm/meson.build            |  2 ++
 5 files changed, 94 insertions(+)
 create mode 100644 hw/arm/tegra241-cmdqv.h
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
new file mode 100644
index 0000000000..74a6954017
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * NVIDIA Tegra241 CMDQ-Virtualization extension for SMMUv3
+ *
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_TEGRA241_CMDQV_H
+#define HW_ARM_TEGRA241_CMDQV_H
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
+
+#endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv-stubs.c b/hw/arm/tegra241-cmdqv-stubs.c
new file mode 100644
index 0000000000..4669f5c5f5
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv-stubs.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Stubs for Tegra241 CMDQ-Virtualization extension for SMMUv3
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "smmuv3-accel.h"
+#include "hw/arm/tegra241-cmdqv.h"
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
+{
+    return NULL;
+}
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
new file mode 100644
index 0000000000..ad5a0d4611
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * NVIDIA Tegra241 CMDQ-Virtualization extension for SMMUv3
+ *
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
+
+static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
+{
+}
+
+static bool
+tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                            uint32_t *out_viommu_id, Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
+
+static void tegra241_cmdqv_reset(SMMUv3State *s)
+{
+}
+
+static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
+
+static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                                 Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
+
+static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
+    .probe = tegra241_cmdqv_probe,
+    .init = tegra241_cmdqv_init,
+    .alloc_viommu = tegra241_cmdqv_alloc_viommu,
+    .free_viommu = tegra241_cmdqv_free_viommu,
+    .reset = tegra241_cmdqv_reset,
+};
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
+{
+    return &tegra241_cmdqv_ops;
+}
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5b198402d5..f73ad9727a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -642,6 +642,10 @@ config FSL_IMX8MM_EVK
     depends on TCG
     select FSL_IMX8MM
 
+config TEGRA241_CMDQV
+    bool
+    depends on ARM_SMMUV3_ACCEL
+
 config ARM_SMMUV3_ACCEL
     bool
     depends on ARM_SMMUV3
@@ -649,6 +653,7 @@ config ARM_SMMUV3_ACCEL
 config ARM_SMMUV3
     bool
     select ARM_SMMUV3_ACCEL if IOMMUFD
+    imply TEGRA241_CMDQV
 
 config FSL_IMX6UL
     bool
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 80068f70bb..eb16ffcc34 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8mm-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
 stub_ss.add(files('smmuv3-accel-stubs.c'))
+arm_common_ss.add(when: 'CONFIG_TEGRA241_CMDQV', if_true: files('tegra241-cmdqv.c'))
+stub_ss.add(files('tegra241-cmdqv-stubs.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
-- 
2.43.0


