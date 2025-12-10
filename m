Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7385DD3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPO-0007RI-HP; Wed, 10 Dec 2025 08:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPL-0007Pi-Sk; Wed, 10 Dec 2025 08:39:07 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPJ-0001Ma-QU; Wed, 10 Dec 2025 08:39:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8wP6/Zw8RtMZcvt8vy7Q1W4s93UqWhkVoHloY7aYLw3OPVlWc9piSm9tbvzR6IVH5GGxv0XbaOh7SMnlSw30RADrUWBqf9tvYukWmUxOtfw0tnpHnxmE4P8MTbE6gORdsH9t1bDg92qeWy6CGYMd462ANBLjtP/6h/gcp74ItdhRx6NLyO7EQUE9CikAzdbyGyhW8Job2gfgEJh0qbwf9o2XLiTkbLEvmUfemWRAsaL2k7wLxtoZXV5POI/Sp+8xjoiKahJKxNy6bG1vDc95qSjBSFLGPZ7LUhVTVx12+MmJA5U2QdXIeM1/HqK5KlKeQuM2KI8/aycP83VWXFOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ogp6UdifGZ/nZozlF67/R916bAarQJSj4jnYZb0M8zI=;
 b=xhw6QwQUGqTHo1wFQPax9bIT3N3TLmGbGbCLBWmhYtS6Do4J5fBlVCC/MYr78h0hqlADXKDcHpBc9ZiyOA7tfucNRCldhOECrbx78zA0O+NeiWJ5GaEm/a913GKlsKT9FBtMqd2IiOy1C8MK7a8LyEfbv+oXLW2DmFHaV+KCu1UsIbFXlwhLD4PbPZJwUjJyspnkAeUKQIc4NHP+mgjhlt6zHl1YRrjXCG3GPKjd9CoZWrFdFyyFZUr59FfxGXZZC60Z3NAK8UOPI1oxAG+ndHC7BHlKnUnzhIai5mQF1BkuSTgTsIwI9yOgmwApopYtwpf4nUG9m5epY7nvMDGLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ogp6UdifGZ/nZozlF67/R916bAarQJSj4jnYZb0M8zI=;
 b=RQ4Rj6UpDBaSOWkqN+KzziIxypIb7yFso34cGIzjLdnQ8aJ14d3AQoXKxuqtPZIcq4POtj6roPtKHgkpUhxzSGv3AWxjpa8a7BUIKk2whtpNmisXc0lhFqrVH3kBk90sbSnmzKB0JPs3IjGEKxhdGmyuiAbWwkqsl8sNtRHrDD1DEfI4Q0Qjp7iNOaWsS9Jslss3EkRAkBPGC2SRVl/o93lEFLnoVqi8xC1atVTNxED2eP50s338E8iH9T4fNNR6oiJ5SSWHz6jOqkAmgfuP1zc521S4vf6iG/GAVblrpOCv7U+ZUJ3j5mgRJelzEpWRaiYkol41vlQS9fgH3+WKQw==
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 13:38:56 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::82) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 13:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:38:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:35 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:30 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Date: Wed, 10 Dec 2025 13:37:26 +0000
Message-ID: <20251210133737.78257-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 82aa4bb1-a861-4208-c961-08de37f176f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HOUHqmk3nmn/upAdIml42i7hVKXUbnW+C/xWZitsvptWHus78mJCiDf7oegd?=
 =?us-ascii?Q?hOUxFEJKE73tRnS1c9a7Pr4Xc2SU5uGUXYkRH0lqBKAxzjV7+EFvBWgtUOGH?=
 =?us-ascii?Q?njogyA/t4ShIiJxVFbqPqlewnVj4yobBYZM035eHaa8/X06zekNq+kta6Zz9?=
 =?us-ascii?Q?ROh/IkzNB5ejTPDHmnsGhLrG9IEhiebKZfvTS4KpUBEVZFNL/EhnOirhIYTc?=
 =?us-ascii?Q?1YKmG2mhsg1wS20FtKGQ6qzdpoCygFCeQUpNlQ9zjShrhAuHj5Bk4xxseS5d?=
 =?us-ascii?Q?2Bhnp2R8JiBCEBK5xHQHvxrTVfLNPcvWGeCsCBFfIM+UguJuLYRvgKy0/0T6?=
 =?us-ascii?Q?soMj2P9OPMZbSrgANVoZ3r58yY1x6HjR1ifWdixJoh8hiF9c+rPphSp4AV2+?=
 =?us-ascii?Q?WpCgEyW/fX1m3FslZ2X51iYK+Jg1DKSQaptlLCSgijKsgvlXWFSoBfDET/Za?=
 =?us-ascii?Q?C66t9q+IL4wk5iy7eGjGssPDVDGlei6Ha3B7Y3DUK/uWqIqNMZOYeqA3fdQn?=
 =?us-ascii?Q?C5O31Y1QZLMKnQr50ArI3PSvAh6mKHVCjbzoqQIW35K7Le/tQdp1EYnYe7J1?=
 =?us-ascii?Q?dfmHsAhOtSmG8SXOgSjt1Yc7ib3dGojoNRmZOTn2Ia+nzlFailUixoNFJufD?=
 =?us-ascii?Q?RNMZOWDfmYSUmPb0uurOe8+qSH0vQAlYUPZgXU2MRgFs543J0D4XOE46reyD?=
 =?us-ascii?Q?LyfbSAGQNpkXVfjshHb4zqLUOt7joo0JPoLFsj7RAk7D/GTG476LPCk6Z/Qu?=
 =?us-ascii?Q?kpTecBWB38xv20OOvR7MGDjoEjVROPfzhixvouzZW2j2YS8PVGTkHyFru8T8?=
 =?us-ascii?Q?jEITk+frPYoB7awF9aTHFnEfwDRkA8CJWKEyfRgRS1PhyGkud4bzyxMUmil8?=
 =?us-ascii?Q?PF1DMhigdqCy9Qpq3CpdapS6nfQuuA8YdXrAASyxZ/KjULhSVi2NG8JqtTZz?=
 =?us-ascii?Q?6XQJzigesBDFE+Jt+DT01JTO+VSsq/KzfrIPfM/4YdBXnBkxwPwFYbriz4Ru?=
 =?us-ascii?Q?9uB8UgeBfz9G9x1ShPHaixYUrSPdAUU/HmaFAXFd7uDX9DbHvaPoxCwkOIvP?=
 =?us-ascii?Q?QwKYL4NNXfF35SSXYsOCcidJPMQqxhruJomGt2GM3PKLaYntn4NICcwOVFrr?=
 =?us-ascii?Q?S6fD4tm2ySWcE2f74vTlD3tqBJMRvRn9Hen85X3COP50yNDKzmvzhWb+zYb3?=
 =?us-ascii?Q?9yCzBD1sxG5p9opkQEAKTieC4Qsaafmf+Xj9VRsVI6F4NkUbI5ApTxBoNz2y?=
 =?us-ascii?Q?EiFgLgRbHF5OrWG6GfNksy971okkpPEDe0j62GnREqszH820JRkhQdFaLT7f?=
 =?us-ascii?Q?BhOdka2GuLy6P4E/jfy8ilO7ew2IjLu7NITTQkzHvzuzvvjmkCAk5egc02rl?=
 =?us-ascii?Q?e9GauA+Dr0LgZbHsxP4FNRfFG3ihXr8pVLvs8rrVbyAH6FG1kOK5hdGwUSph?=
 =?us-ascii?Q?IC107oSscFYFvqGqNGbnKLW01cG2rSLyrrUk8Mv0aJ5ewN21fwJHmmAxtrzz?=
 =?us-ascii?Q?QZfsPWfdokDg7PrPS3DSmCffdJW4xx1vpbKsL4W0+XJSVPQ7ykKODPFvsekv?=
 =?us-ascii?Q?qR+NbMMMquUDRDqVS90=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:55.4394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aa4bb1-a861-4208-c961-08de37f176f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
Received-SPF: softfail client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Introduce initial support for NVIDIA Tegra241 CMDQ-Virtualisation (CMDQV),
an extension to SMMUv3 providing virtualizable hardware command queues.
This adds the basic MMIO handling, and integration hooks in the SMMUv3
accelerated path. When enabled, the SMMUv3 backend allocates a Tegra241
specific vIOMMU object via IOMMUFD and exposes a CMDQV MMIO region and
IRQ to the guest.

The "tegra241-cmdqv" property isn't user visible yet and it will be
introduced in a later patch once all the supporting pieces are ready.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/Kconfig          |  5 ++++
 hw/arm/meson.build      |  1 +
 hw/arm/smmuv3-accel.c   | 10 +++++--
 hw/arm/smmuv3.c         |  4 +++
 hw/arm/tegra241-cmdqv.c | 65 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h | 40 +++++++++++++++++++++++++
 include/hw/arm/smmuv3.h |  3 ++
 7 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.c
 create mode 100644 hw/arm/tegra241-cmdqv.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 702b79a02b..42b6b95285 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -37,6 +37,7 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select TEGRA241_CMDQV
 
 config CUBIEBOARD
     bool
@@ -634,6 +635,10 @@ config ARM_SMMUV3_ACCEL
     bool
     depends on ARM_SMMUV3 && IOMMUFD
 
+config TEGRA241_CMDQV
+    bool
+    depends on ARM_SMMUV3_ACCEL
+
 config FSL_IMX6UL
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c250487e64..4ec91db50a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -86,6 +86,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
+arm_ss.add(when: 'CONFIG_TEGRA241_CMDQV', if_true: files('tegra241-cmdqv.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 939898c9b0..e50c4b3bb7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -499,10 +500,15 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         .ste = { SMMU_STE_VALID, 0x0ULL },
     };
     uint32_t s2_hwpt_id = idev->hwpt_id;
-    uint32_t viommu_id, hwpt_id;
+    uint32_t viommu_id = 0, hwpt_id;
     SMMUv3AccelState *accel;
 
-    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+    if (s->tegra241_cmdqv && !tegra241_cmdqv_alloc_viommu(s, idev, &viommu_id,
+                                                          errp)) {
+        return false;
+    }
+
+    if (!viommu_id && !iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
                                       IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
                                       NULL, 0, &viommu_id, errp)) {
         return false;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9b7b85fb49..02e1a925a4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -36,6 +36,7 @@
 #include "smmuv3-accel.h"
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
+#include "tegra241-cmdqv.h"
 
 #define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
                                         (cfg)->record_faults) || \
@@ -2017,6 +2018,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     smmu_init_irq(s, dev);
     smmuv3_init_id_regs(s);
+    if (s->tegra241_cmdqv) {
+        tegra241_cmdqv_init(s);
+    }
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
new file mode 100644
index 0000000000..899325877e
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2025, NVIDIA CORPORATION
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
+static const MemoryRegionOps mmio_cmdqv_ops = {
+    .read = tegra241_cmdqv_read,
+    .write = tegra241_cmdqv_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                                 uint32_t *out_viommu_id, Error **errp)
+{
+    Tegra241CMDQV *cmdqv = s->cmdqv;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, &cmdqv->cmdqv_data,
+                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
+                                      errp)) {
+        error_append_hint(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+        s->tegra241_cmdqv = false;
+        return false;
+    }
+    return true;
+}
+
+void tegra241_cmdqv_init(SMMUv3State *s)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
+    Tegra241CMDQV *cmdqv;
+
+    if (!s->tegra241_cmdqv) {
+        return;
+    }
+
+    cmdqv = g_new0(Tegra241CMDQV, 1);
+    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
+                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
+    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
+    sysbus_init_irq(sbd, &cmdqv->irq);
+    cmdqv->smmu = s;
+    s->cmdqv = cmdqv;
+}
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
new file mode 100644
index 0000000000..9bc72b24d9
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2025, NVIDIA CORPORATION
+ * NVIDIA Tegra241 CMDQ-Virtualiisation extension for SMMUv3
+ *
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TEGRA241_CMDQV_H
+#define HW_TEGRA241_CMDQV_H
+
+#include CONFIG_DEVICES
+
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
+typedef struct Tegra241CMDQV {
+    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
+    SMMUv3State *smmu;
+    MemoryRegion mmio_cmdqv;
+    qemu_irq irq;
+} Tegra241CMDQV;
+
+#ifdef CONFIG_TEGRA241_CMDQV
+bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                                 uint32_t *out_viommu_id, Error **errp);
+void tegra241_cmdqv_init(SMMUv3State *s);
+#else
+static inline void tegra241_cmdqv_init(SMMUv3State *s)
+{
+}
+static inline bool
+tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                            uint32_t *out_viommu_id, Error **errp)
+{
+    return true;
+}
+#endif
+
+#endif /* HW_TEGRA241_CMDQV_H */
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 2d4970fe19..8e56e480a0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -73,6 +73,9 @@ struct SMMUv3State {
     bool ats;
     uint8_t oas;
     bool pasid;
+    /* Support for NVIDIA Tegra241 SMMU CMDQV extension */
+    struct Tegra241CMDQV *cmdqv;
+    bool tegra241_cmdqv;
 };
 
 typedef enum {
-- 
2.43.0


