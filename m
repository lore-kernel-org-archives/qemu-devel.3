Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06581CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18l-0004nF-5W; Mon, 01 Jun 2026 07:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18g-0004d6-Fy; Mon, 01 Jun 2026 07:49:04 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18e-0004xx-9W; Mon, 01 Jun 2026 07:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+wqHiyC5oBViCST0I4vFMC8rRKsbRrdap3xdUtFgzCw7SK3a2C9Gu13H2xihjAXjttsCBBy1hBsX5YzrwFgjEeB1oOlW4GtTfi8iOXW6nCU9KwmbRPDNl2LOh+NEE9xLMSXyNasvKvy6c6/bImwbr8+u/ae1U3ZE/PRpfwpexqCVZX9jp5ZgmolXz1m9KzsgvW/st0gnMmODS+r3tgx/G1kWVrPm3v3xfEfUuTNqxYg81us3EgjPzxgnSt0jykQDhd8KjSi+nfS29kk9saLoGfV4ln9RWnc5fSPpArwqFGGZ/NAtM7xQ1IJ7z6zGpwsQREDP35vqwD0zFBo6HlOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPlsIFw+wwcYyGS3sHXuR1IDPE7aXB09oIFE/B31BC8=;
 b=clCpS2FEqjPQepHfB/zCPkd53beS3Pf11U0H4zjUvGlFY+W6CKytOG28rK+oVnllgncPBYWEzcH4PaSv2Axzrq6dKwDTjaT/D/zVAMhsJVdRsGiiViMQ17dHuFo75b493opLMj8Jjs3pQYsbvxU5BYTkhmHyWdCdnALHCv31DuH5lPX9dGIoGMpwb4vhXuUoRG4UUloRERvnfePRfY9he7nVHStM2VZ+WabwyuXfHg3z8H9CVtr6goJmoqFI0UTlssvSCd94RzvGkYyh34UYFTL7zzqj5vACjO6OPjcGqFf2R/uxlDn/2dtUQGx9BMHmbcHqAM1w5fPEdKGhwuVkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPlsIFw+wwcYyGS3sHXuR1IDPE7aXB09oIFE/B31BC8=;
 b=W/k16YDjyTMxh38OtDe33rHwVzZY47tFKiMrgc8SwS1KYTPXXKtzXPQkN3e3hvZGdr1B/tIaS3UESNai7C5CfNX6Ll+OTQno1eMKXfCOiJhAIC/K+EvjpZTQiyqaebyIegXvrhM5pIFPkalMdsgyDeyrVDTxADvE9j0u47+x5wkKCZxIXnidH3Lhn1X57VtOkUNMNNcSPATzGcirevgSILQn/uM330HrHKnTFRj0jZzd2vfec62pNQ5BMrYsVjopLs1gYp52l3f8lIkH556dor56Pm/r0Gka3/ClKyDf5krILwacfgKcPU7f3PPPyI9fZp1BMQWO9LfuubgGwDGVFQ==
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 1 Jun 2026
 11:48:47 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::ab) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Mon, 1
 Jun 2026 11:48:46 +0000
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
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:48:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:25 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 07/31] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Date: Mon, 1 Jun 2026 12:41:57 +0100
Message-ID: <20260601114221.457995-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9a358e-1f6a-4bcb-03ec-08debfd3bd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: egQj+dIXgjJnul35xS4GlqXBIPnddg1J90ZnH2FJtxlY9UMio2noxCGsi5R03dBEz9UFhk8fBBCR67IPxkv7GNqe+JPsxm7ByUyu3DUzKSQB7x7VUDLa59knhB5ad7crmzZpOGlNRzSlv1y530+9LgPykYHUjB+ajgrSYUBSWnlSLqWPSP3HW2lKFMtcke6oo2Z/7Pv0dZa5WwgLqCAlK9T0NVEhXu1nta+9WxfjhZsC2tpThd72vRC2fjMUiM9CCLK3uHd0LyVPW8oa3wGfsravYprRsKDtnbXl3nW2Mx1rYJdzHmByj/DVva1zJZgZCOflw4OkLKiFu3EFaohistvtmtm5zYweJYvj4jurKCLFXBT0OuxlMVzmZ02tSmR+KJjaB4O9QE+aDbG6P/c2QDX9og5yaB6Q8L1BXzjHvtaa5k0Kb51y6klns/gugULXDI16dYGrnLKL8GsVN3Syx29qcdnYBO/A8+5UGH7crJACND034gGV/smBreARcuJXt3GmzrfcGfJK3pjGVVmGHP2gz4qMQw6HYBYKIagYCSL+txRBNdaRo6SFq71xFE0C1IfRboT2LMfjfA1cH82W6ih2H9hKzPHnWAd8X2xJzmCb2l0nI1GHqJYRvCPD/3SJY8+AJmgeM/sBfJ3bPlkYPk0VsDb7gDZB+p2sHeuYUdeDfhAVLnz5sn3jwQTz5VBgMzZS4BoHUSypLV1Bt8cofOcTvVFOy6Q/ums5mE1T2iY=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3WB+K2oOBV4uZp3MVI6UPaEo04+do1S02/0z+ZACxH3g6vmdrBuhuKBExgY/rcdpNqvTWE0fTTjEJS2KkuPNpX1UdDkYsWa8vhsa7GSOeuQw2W78X2wIG1o1rax1tfkCcL0ibV7pMU+Jp2WnKo8mihXpUSoV4GTFl1aczSI8ezae0rOB+CEtxoJfodxqJNQbveH/mWatMGbnmKNGTd/ZWDVQdT+a2a/A6U237VmHsjoLpGiUz+MI1lnSN4zju8mmpk//MmvEZcOB3947MGa/09xlm40bnV89t7N3T66pgvK7bg5JhcCu3cSNCR1iaETvYDPX5NUb1e501RIi34Bn6KH/Hd4nyspwUT5GSG0ieyT+SDvLeUYiOBlwIcAmVBFAJ/Gj55Fqqr5k4V6S83F41j3UOHN5hSXwHqqoR+VM5Gki/P+VrusgE82yrE39+rUK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:46.3711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9a358e-1f6a-4bcb-03ec-08debfd3bd25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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


