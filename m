Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F5AF41986
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwB-0000kD-SD; Wed, 15 Apr 2026 06:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvy-0000bX-9X; Wed, 15 Apr 2026 06:57:28 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvw-0003yh-JO; Wed, 15 Apr 2026 06:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suKvgnqtyS4oFc9XyduFidjnmGRCbR+kyKTu+9J0AxnqLZ4p6nAXZFX53t/hiSR0yNeHHr4KGdOmhIgw5eR/RFsnlCxF6rZjuTU3Ydss2GCeYFGnl+dSSYBEnQ79ssYkVpEPGwW5YEO+lnfkR+rugwj1HWkrQlmxoX6qFdfPwg5U1ah60B7UCyQjtcKBlqhZLknQYwGkvofURj9SwSsWClGYk9ohQL/EGmvDQX7p4O1HRiivYAzEEQCWOIqs36tVt7ZWkCIvMqTKL3xEOMZnw9dqQrie4+bsKkxGYPTUaysuJPe4aUzV+FciTipiSAY3Pj+sj8mYZv0AL3OUZS4lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IsBAWmn5BCZVhI/4zk8VRm8OMFjwoDNAgz9CkTTaBw=;
 b=xk3beGlxGsqEST0ULIIy2uGqkWQWD1x0SqLbF1ZcFo+ut1XlTJn8kgJ9HMMNFmEb5k41JzFJx0Boi2qO/ENAphNHKnVv9QbTWCcZGM+/UYoilXBgCT7GJM4tx1jzu9oZSUAYTPFu6rNB8OEtNKtRU+l2Nb3l95Lw1uVXsJ3zVCUZs2GwZR2GGEXyUTPFxXsivFfTM0iBKB11rVTqYHYYDHdhDAP33roKu0psvgBdLaYbgzeQpV5XTZFGqhwdc+IC/31hCuN2C6Obajo/Nodl6WvEZxOxt66wP85Qy4z3197XreEueLWEWuHtT+aXWrdyMKNK0y40CAQseVMen2niiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IsBAWmn5BCZVhI/4zk8VRm8OMFjwoDNAgz9CkTTaBw=;
 b=pYihkkEdXOg1o6KCQVRDUchL3ngtNOlwkiyvOx0dbj2Ej811LmvTdbyVk55+xv4GFQRodiZG1IWbn7FUhXGxuRl954G4BkLyQop9u1a130iVPZ/EccmyMPmZj9fivfRDMZFuNey8j8Jxnv5bPw2160im4jI7/yRvXub6hD7g+PfJ6ga6+g8s/cuqQfjxsYZyuu6Vgsf79HwHrRkkMBi/2ivgMsQ4Ye2jdWRnVDo5c5JspF/Nm9EGHsB0apIBqtySNFJrZ7DACNo7x8o/JBjr+WJtBz7HuVu2B0z8gBy+8RxvdeXr/4ZfzL+qgdO0Axg851JINUL2lRXs1tN6M9uj5w==
Received: from BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::6)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Wed, 15 Apr
 2026 10:57:16 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::f8) by BLAP220CA0001.outlook.office365.com
 (2603:10b6:208:32c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:58 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:55 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 07/31] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Date: Wed, 15 Apr 2026 11:55:28 +0100
Message-ID: <20260415105552.622421-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: c939b3cb-e095-4b92-a792-08de9addc1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7Wz69kVyBUVW38Rj0fWhoJksH8iOiRJbht0WRStaU/rIsC8+Rza4nNr3H93AV2Ur4X6RFT8eaJqSZFHYJWKqOl4j7eL3XmyjIbiqfKr0Nwxw1jIPA7GltNaK4fr7VCwyMd6VUepK48omBKgyNRKfNO5Dacav5s25NyujuHbsJ3mfn5sdmis29n3xENLzLSb3x99j/hJE7Xf5t0IHKNX/MaZXBDfwRdpSEBveu2ZyXqpEC6V5MdtmdjwgJTxW5Gdu9N9Y5rTbHFpLftQLoPysfKwk9PpeclIUqS0iNVU0RGr1AqsjRKP/uhhpTrArVHKRoa3ap7urZ1vy1QLgt+HdDv8eQhKetIkmNPKgxvLqWRlSZBbg8lHibtZVqJBnwF2FxARBZ66T/HoWWdAgmqVj8ptDGL+q1E6yPZmUDU1LWsceZZCA3yhuKze6lst/wex8eVqOUroi0myhxiLkSfXW0bdN/YAbqLrbXJv8zgFHhpMfoApQEqDeicckEp1lJm3tXADSXl6z3oEcC7QYA3KAdvynFTDGlSOjFhkk0bhmBcXoIFb8YFdntH5WquQVekbGl9e7e8sTO20Lio3M5+jCRHEH9Bb8fowBO3fiECgL8JoWj7pzQxNBc76eBYr/Nm+EgbizaIPPL0uPx7KDryoZ6+vOu4uoBAvpSXzID6325gFbmCR8Fkn3AhH3PUK2IPKpzeHIyXceryRa8rLOKFawpxcQg9uhASGJJAAojpJ4BO4whTWYeyRgc/yjQjnm71Ex8tvcZ/CpjyDHBRoKrDC9lQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mq1Pivn4KIrIWDBMSvGjATjFzIw5UyxVXmuBs6bA4tC3isPB4ilqyP2BOBtPqVxtxxRXqGLH29fUzjNw5aYFcKdgWYq/L2bZKm3q50AuIBgUsMvdOuKh11HGFbeVnmyqclcaxdPP3Dy1cZ53LXxrBfBdNxzy+jhjlUb0cWahSE26XGD0JPHvA1Lq3Jl50Qs1GJ7gB70JL2xGMurmxQRVRpoZkz3Au4kYrSlj15qqn6TrKARQOuoCynO+I1VnktANZV3DLFz19Hj31EfRE4ZC2LVl1eBZ6SwshTCF3xpNCpBFb8CtzIlhooc7UFUhWummSWqalOXZVoO0TzvtWhJOX4nPnFs3MKqbgSaP84LWDdohqw5OQmhjlYM7d+NSszutgP6EqDCdOIBdd/4QtO5Fjt/CjyKllPQOwd9LQpn2VWaCCwmlP/IQJdKWKsO6s6Vi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:15.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c939b3cb-e095-4b92-a792-08de9addc1a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Introduce a Tegra241 CMDQV backend that plugs into the SMMUv3 accelerated
CMDQV ops interface.

This patch wires up the Tegra241 CMDQV backend and provides a stub
implementation for CMDQV probe, initialization, vIOMMU allocation
and reset handling.

Functional CMDQV support is added in follow-up patches.

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
index 0000000000..07e10e86ee
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * NVIDIA Tegra241 CMDQ-Virtualiisation extension for SMMUv3
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
index 0000000000..eabf90daf8
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv-stubs.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Stubs for Tegra241 CMDQ-Virtualiisation extension for SMMUv3
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
index 4e50fb1111..073f2ebaaf 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -618,6 +618,10 @@ config FSL_IMX8MP_EVK
     depends on TCG
     select FSL_IMX8MP
 
+config TEGRA241_CMDQV
+    bool
+    depends on ARM_SMMUV3_ACCEL
+
 config ARM_SMMUV3_ACCEL
     bool
     depends on ARM_SMMUV3
@@ -625,6 +629,7 @@ config ARM_SMMUV3_ACCEL
 config ARM_SMMUV3
     bool
     select ARM_SMMUV3_ACCEL if IOMMUFD
+    imply TEGRA241_CMDQV
 
 config FSL_IMX6UL
     bool
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 3be1252c4f..64bcdc5a7c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -87,6 +87,8 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
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


