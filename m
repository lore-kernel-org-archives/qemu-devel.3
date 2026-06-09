Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727B9CD8CBD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudF-0007Z8-7C; Tue, 09 Jun 2026 07:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucM-0006RY-9b; Tue, 09 Jun 2026 07:27:44 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucG-0002z7-Iw; Tue, 09 Jun 2026 07:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXbNE/6nSIflQ6821cFxeV2ZV2SXrDqejYHV56V1QgIgTwgVvi2qT3EXO5uOFvwbopGqajGpCaC+jyD5rwKU9lvpHfJWRcM0I83mA66AY9RB6QPT0DUkHFat2YjUDI8Kf9lYMLJQZsT4Wd5gyoatTvCQv5w5IbR/OQPmGvIqlzHqGuk60iRRWjacI7CoCsOkZd8a799zcQQq6EQreLr6owoFWoMpPxuGu6rSTPU0iN6Dwpnm4XvqjdA7nwDLysDwhv4kJE+fNoE1iyf00FTaMXwKfYV2kxyYRcNCRTNugkFfi9NagIVb1xPf/G9C9DNqwoscJqb5E2eTO3UJVGtwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWSUorSX/l8b9tbv4B71ulhwR68gYwi8sGytJRbDLrE=;
 b=QTQ1050k9fdA4gk/D9L1yzctI96Spf2oWu2GboxpuZ2k2RLyKT6plppec7EUkQ75ZHF7rPKQ++Off5y8TA/9TduYvgmcpD80StwtU/Rvn70fFMoPyYEICwmlO3U7x9OCK9OoiXtmmIBSyHBDWI0j7gO+3rwW29qwoYbRz4ruTaB06qEdwzn0uyHa3xX/EAS3ZLNpZD8tIbYUwSaK3WHXeznvp+EINoaidc1xsZNEpOtLMag1o14vhF4DMquIS/8+SIa7V0sQU5KoA2btVauBF/n0daTkN0HHCyC1ArQhwg6Iwxn7Vj4wSNHxlTf3vNnPH/47ONPUdm0rcOHsF+X2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWSUorSX/l8b9tbv4B71ulhwR68gYwi8sGytJRbDLrE=;
 b=DC9ScNH2OWWO68jGvPqmemItr6nUKScSpgh6oHo5VWGH1sQ1a5MgJrHrnoDwjSpSe6lMWHekS6cOE7K6qF8cQmJV5fq9ZkKRTem3FywGMUbYgGCrOLNKmvNHtDnvmcDXYiD/6I+BIeu4pu2AOfMQhILx4gkPEBJ7GKzYKZj1HgUjinrC1TeWzJYG6N9081k0ML2k92ej9J2H59CeiWowfceUjIou256qch7eExfWXIp7EIJtyhAYXk2CC4iJwIuGYgdLKy00K2KXs/5ept2oBGdrZVDtplV3DlCDFP4kxSsZhsNQkGGMgu8bNhB1y11r5dnlwb/XLUMMar/7qLkBWQ==
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 11:27:26 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::15) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 11:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:06 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:02 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 07/31] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Date: Tue, 9 Jun 2026 12:25:28 +0100
Message-ID: <20260609112552.378999-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f82f25-250d-46a5-6897-08dec61a151b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i/ZS3HYlUapcsvos4UYf3mNNn5pUW4WggBKRv6O/LRIfPMCArZHoueP5L1+zTdyvkgEmXnvQBy9omkkSICw5B9pWcjXmH2mOnoPr4Se74QxQ9SY9WZsXsFsaLpLoxxpOF3iCZU04BoBuarD+oHAxRKLiZHAATpHXK08xvroqW2055xFWT3+ggfichbKOJL7GD53sagz0C2KCtehOIpuNJ96oOFerzOiuk9g2viwkF9m85lFfhlFs34vpHn7G9vOot9eXmRMNNNy9q8NO8jjLKQdAfqkpxBKvVeqqcCwZFwrNrSj1sfCyeTMTP+ENYT3SwafnIYZ/IRpeXXj4+azaEUMjTvn1NTkCVsDvYNgOp8gqZlXwbS7oDNK+Kgz0ymCfsOvA+w6PI89M92bQoZjGP21oJ/lo4l8M5o5IQ6W9DwtIlv2trCUneE2DuFww480s9UUDKa4megqJFCXblpRnMgb1lbnCjsHp6VJ3KB798lqnp3qZHqLIaUKgZYQKEN3Ico5B1Pe7ygerc2qvIEL3OchXBnFo+uVr7NV79fJUYuWreUl+WFSqLqsrHyqJqBC/X+i0bhdhbV2hhE9oYKLjH3ioKO13rRCROKI7svQ1kj0ROlfpKzMV8/H9sIJglIhQ3LnDNymEsfUKh54kt8aKodimWJ2S1tR4YWBeAFjxAevgr+8OPeL3/njZPWMtOTsJDbknDoE9DGi5H8QdcrsXNX2xdeuUdwAddzljWc773oc=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g/VuPxaOX1KkTWFK/6+Hk1dAxRmJzBlxvDy6DCZ6lc1lhNMRQw0PrBAYAqH/JHfEEt4YXnAhhTx+AlNOeoRIRzpNM2cf0qBBc+rTrUCF6w7msgT3VFEAShezXDyJO4oEDnTGLiZ+pWXwQ7i15iv2oQ2JfsoaJBxgJ6Pmwi8pIEpsCpHnMfT1ymGRVSBr42yKq+Yc8MxDS/Ua6Or/FWoX5iJ4VMc9cz5VdxRP83BhwhbYLdAK6U2u9NNmVnEz92561BLNk0GOHEyuLX1eP0Wm+b/n3337luC3vx4E4XrNV5vmkdxJBBW1Z05hbFTu2deLijM8x1bU/fLvxLFFr1y0WPDxPmeh43DuamZjksMQGCds6m5pXHu/GfNzKLQHX7AsqNXiwr5BO1cSCPL+Yi0xi7zcEPK6iNKifnYE21PQbDmtFIi9ehRsZkpShFQBeOl6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:25.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f82f25-250d-46a5-6897-08dec61a151b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
index fb798ccbee..500bfdfe2a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -643,6 +643,10 @@ config FSL_IMX8MM_EVK
     depends on TCG
     select FSL_IMX8MM
 
+config TEGRA241_CMDQV
+    bool
+    depends on ARM_SMMUV3_ACCEL
+
 config ARM_SMMUV3_ACCEL
     bool
     depends on ARM_SMMUV3
@@ -650,6 +654,7 @@ config ARM_SMMUV3_ACCEL
 config ARM_SMMUV3
     bool
     select ARM_SMMUV3_ACCEL if IOMMUFD
+    imply TEGRA241_CMDQV
 
 config FSL_IMX6UL
     bool
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8f66a80e10..4233a800be 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -89,6 +89,8 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8mm-evk.c'))
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


