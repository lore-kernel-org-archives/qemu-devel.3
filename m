Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751FFFC5928
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyi-0004GH-KE; Thu, 26 Feb 2026 05:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyg-0004FQ-VJ; Thu, 26 Feb 2026 05:52:18 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyf-0000j0-Ek; Thu, 26 Feb 2026 05:52:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0JIZO/N5AFcISrik9cEZZcbgC3WKGNpQdFXS3KC67nfQJSwHnbP2fGLyhmrScwCJHg0dYdfOrSKpL1Eki6H4W0v6obASWFD6AzSLwD4vSQq2YfPGbqYzE90nUVClHXLl0ePOSPdVCWhXgZ7olm8aLpHC+MsOTJMCEdiXIBb5xTU96s1E6Txl4hUcOWPBiLdryh388Mje5b6Q9DtbxYeyZwGtExyRE169t4yo4mBrhKe5Vo9nMCb+1UQwYqxcpjtTTu6lRb37PGqwhCYZYT5MbEjtQu8LFo5pBasyCTbKY1X0ByZz+zc8IZUpaIScg42CJ/R1RPHpWTBjmTd+IpVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oMvxWKaDJYbezn/n0ftprtRKbFJ/31jhS3y5u2S6Eo=;
 b=ga1OqIOyUc2uzrp0F01DEr1xd5LUFpIuzVEi8CGfmiOwTIZaI07NqDjZPnPpykGour97AZRa+2g9yxkYafsGscn78P/hZS95WGob41WjCXTOJ+R4RAQO0mMFXFYfoUP1BL+tMR33w6joga4ej9K7pDdSF/XbZUFrDYrEHap1xDeqrwTsMMQOlaNFAOxBQy4Sdzft3l+bjp0xKwUQAyLl+MJ1ZrE78TbUTvktkBFq9aIa4miABHvkICLielmGIeQ42UrrjFQwiqc69oyf8goQvuU0kIRIDjs79PwH3UI/vX1fjFAKbVW6h2Xcj+nJdMVWcPTh0VK6a5G5aO0QJyroJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oMvxWKaDJYbezn/n0ftprtRKbFJ/31jhS3y5u2S6Eo=;
 b=IOpl21KhyU4LpAISyoHZ3UGa2xtaZVku21IS1rhIHW00EMNHzgNHB1FO6Lry7ujE3LV9nwyKMRVEI1dCnn/xWuSIL9Coodl9JnukE+lGrFAtfI5pWwqvUXd0v9yh+lH00JhTVqvy397FVcDw2jEgMTe4DW2i75rCAWmsjPQTm3k32doxgFfMHShs2wK6Yj/q+f8Q46UN9ibN3A0tsqCSvqFh58TtkCrALbPCzejjLp7ksQkF6sA1uYVVezC/tPIxw7sPW940iehRaKQMTiId1TcJnI4FfCsW0fiUfoboCSmeOg5xgAIu95UDYZHkAlDMv+l2bAcC513dfvJbUpj9Pw==
Received: from SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::13)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:52:07 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::5f) by SA9P223CA0008.outlook.office365.com
 (2603:10b6:806:26::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:47 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:44 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 06/32] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Date: Thu, 26 Feb 2026 10:50:30 +0000
Message-ID: <20260226105056.897-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: ea206261-5be7-459b-0edb-08de752515fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: E16VGAclZOwBfJjUVMg7uxTg+SDvBMrFziJGjdzFi5GB4QBdC+/j7Sag9IFCPEHdHhC4fBAQ5XheH2x2tfDghxhqFg2fiSr71XpNfe6H3KDyoPwdfuKS9WJM0MeH0f5A3TSCHVhC216V5P3f3t8hjdWr4fDWUAddpYXaBnNy0UHcD8kntcSnFi5KxBCb512fEc5fdmiXkUGc+mm9anveYFc41g1IUbOcs7lyl+P5ZicGBSgoMUnnVkH2pg6RMy4aZtxPYaq/CssuGAv2Qep1Opsl++L5Aq21lujONC61ApEe84q/wxq3c4rJPQj9ex5HpVfQ4v2reM3s6V93vWWcDIJTHY7necEbBE+INbUkUv6cJA45GiS3U+EYp55skhfkCAD1WsdWJhe7CQvxwJRPKoVoGx0HglqzyS6e1QaFVqPuMQdbthRPACxruSIj9tQ8B5jh1NdQtMnE8PHGUh7b3n9vhFU13FJgknn75ffSxaoTxCBzu0rKx670Sdbh2DG2PiZ9FMr8rLHv5uNCtW00mVbFX2uvOOYxdwmIFx3O4MQWEKxFIZjfEy7XdkJ8iTLPl1OcZ8yxE+FV7ktD5QOIWWvSssGwQoMAmMjnxnODHlCUY8qxecIPMAyt4MjNXCxMpG8s8gj0XrEh+n36gLUu8N3gfHHB4PCcYPtsRmcB8088+ZDzajWqJwwAnoNEIspzr4H6uRfcd5aDKRtOtyGWQfPNTv72abpXMSWit3QIzqxvWfjWJFBu41E86TuEGINYu6/SIR1cNUezc+QWwH8abxWC8Mr6eSwfzRuTDZsqkU73riXQsZg/xmKJCMQK1FduVyl6wcwaQwC99jOceFR7BQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bv1INLACBA9kLOOBuUQ4/Uxfw+YQOtuyw/jg5m5tpoR/n9znquJxvR4RR8aGiVUjYuoWecChsJn++tcMOj9Y58JFImNgBzodUEDlT+Y7afbMZibqtv8iycujGhZtC/vZbW91ZLk5yy2e4cw2MihnmuUbrTEhur8A3JgPM8nPgtTG90oH8VF44osaoCyByuMj0L3GPfzuVzJDuDlUPhSRXiWBqm3WHtGL7E8TwQb4t6yO5R13j9s3Ah3PR2PpOkltUPv5RcEf28D6uXXsOh8JNixTxW6UQnLdsFZU6X8Z+qs45H5iynl12y0AF2RayxRpvsjEd16NuyE8Pmln6u5alERjwqrBBHQljfWkGQQ4e4u94AXmMaTV539g5OBz1idl5sQMRpiYVKWwD9gim6hOAsAMS1FqcPAw9+pHhqN2kKqPdtC4bAIwwoG0mrkwgP2T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:07.4608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea206261-5be7-459b-0edb-08de752515fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
 hw/arm/tegra241-cmdqv-stubs.c | 18 +++++++++++
 hw/arm/tegra241-cmdqv.c       | 56 +++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                |  5 ++++
 hw/arm/meson.build            |  2 ++
 5 files changed, 96 insertions(+)
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
index 0000000000..eedc7bfdcd
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv-stubs.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Stubs for Tegra241 CMDQ-Virtualiisation extension for SMMUv3
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
+#include "hw/arm/tegra241-cmdqv.h"
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
+{
+    return NULL;
+}
+
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
index c66c452737..3305c6e76e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,6 +626,10 @@ config FSL_IMX8MP_EVK
     depends on TCG
     select FSL_IMX8MP
 
+config TEGRA241_CMDQV
+    bool
+    depends on ARM_SMMUV3_ACCEL
+
 config ARM_SMMUV3_ACCEL
     bool
     depends on ARM_SMMUV3
@@ -633,6 +637,7 @@ config ARM_SMMUV3_ACCEL
 config ARM_SMMUV3
     bool
     select ARM_SMMUV3_ACCEL if IOMMUFD
+    imply TEGRA241_CMDQV
 
 config FSL_IMX6UL
     bool
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8f834c32b1..fc83b635e7 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -88,6 +88,8 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
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


