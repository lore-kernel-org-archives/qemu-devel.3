Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893C0EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNB7-0001Vi-KM; Fri, 06 Feb 2026 09:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9q-0000TH-Sk; Fri, 06 Feb 2026 09:50:06 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9p-00078V-7T; Fri, 06 Feb 2026 09:50:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyUFv3+9AzReTwho1SyAe1i/3AIPpl3Wf86LifIM+C9CXzfNjpWsgbsmQjdeXR94l2bD8N4kXntQMIHYM8Bfih32ppIOmheBQeIZUEGS5lOeyA5CE+AvCCCo4ybiuyNcY+IBZvN64xwhO7ET9kPhTbI0NHQhOCKxPs+/yuZlJB52p08tQpy4NqDd7eqkIjS3P2onugJvruFvoHvrQ9JfZ5JcjEeNi2TzhX6mpyDiEtg7uVkNGQ/p3MXaT52jowD09uiM9nzE1l7nnlgAuV3qfkeC97nYtxiBY2yHPzM+nlZE2k+AIELQLZ2mmaWFxsZ2JhYc3aBWZVju95xKkkEIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R2UNmdbH8+RI/wedCyoGhoSL4aWSM42vAxXPgsSFuU=;
 b=Y+RjdMJ76lkOA4/SZxOnv3KFx8qkpU32bGhMM3gXmQI+0Tln13vjtOPO0z9RT8/q02UZMPBwaF71eS43dFcrqHJem/ygV+heq7jsn8e93sY7vOTEM3/uvED1XjtdkTXyOX9pLOHaIdqvw7RLP7GzK0ZwnwEg+mvSpDisoJcUlTxHlVKeiuavupnSGikr0lK3o4xKao2tRjX/NzW3wApMyWRpjYGHQ8/at6iexGPnXuddHNLCldm/5NLOcTB14nrh0KyBmeRe7iVWrHxGUESffQ0MLkxyljfJ/lNuEoA3M/bBMpAbQ9u17SfigCRHap723FWwQlYdIuwFcL34o/XE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R2UNmdbH8+RI/wedCyoGhoSL4aWSM42vAxXPgsSFuU=;
 b=gR5VQRUcPDtuAUANK+D9un4FqFdieDevkocw4I+rvTUb/tkmIappAaXtMteSATZz2uD9uTnGTyf1vwqGFRgbF14UEF9eIpmkATHsWrKTERMH1H84gpbE+zTmNBZgLruN7k6ZfmXMVBVLgRo65LbEmaKP0brxca7JZ3lxQOqmHktlMWXoxLpHAnDppNWHFHVZO4TtQhB3PmOMjv71aSkBByyLZh/QdnIARgz2YD08UCknLpobMtgs5ubOPofwEdlGVVQxp9RwPyb9ikwoIXF6Ioc8Hjj3iAEOEu4FDPtdNubY5PLLQmyZ1HuvrzZuNRvIq2VfyiAuvMI2OCIzEXHs6g==
Received: from BYAPR11CA0084.namprd11.prod.outlook.com (2603:10b6:a03:f4::25)
 by CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:49:54 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1) by BYAPR11CA0084.outlook.office365.com
 (2603:10b6:a03:f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:28 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 06/24] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Date: Fri, 6 Feb 2026 14:48:05 +0000
Message-ID: <20260206144823.80655-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a8c0c9-1ad2-470b-7802-08de658efd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QROuPxT0I2ulA82p4cLuBS8/MJeUgCyyBzWPuFxJNrzxctnGN7mMDfK8Mj+9?=
 =?us-ascii?Q?ls64/PyUyg3Pqj9Hs0onOVxF3GW222U4vn1Zx7tqcelsLLE3nm/slhspuq5C?=
 =?us-ascii?Q?sLsls616Ehip1/Q89pDpv2Dun1ia5DSRk+BsuHyS0so6PCKs9eb1vJcV4asG?=
 =?us-ascii?Q?MDoiBzuL+7ps5vISfE/YhTNeYEg9YXruvf4NtUeFCbk77sRe6F5I7RU0vq79?=
 =?us-ascii?Q?CLbHjFaCfJPXIBLoel/TPiDQ4uqjLZFXdgYiBhbTGSgGKGoFxevREV+n6njt?=
 =?us-ascii?Q?wNinlviErRnDrl4WodWR8I9oiUp/La5fPrpPN9MtuwhtfSxtZJjWyp6lmL56?=
 =?us-ascii?Q?R+Jlx/gLA2RTUCyzj8/ZzESPQLuXcVmQ4tU4n2BRpExtzfeJxnuGyYujgWTP?=
 =?us-ascii?Q?hCouU6UeOOcZZxdPR0z46eqe2GI06wUdTEOOBnhFYTD27UJ2NkOfFAfmTs06?=
 =?us-ascii?Q?DUxFGG8O4//b7uEmaMqWoX3WnpEpM5RDaAVdZGADEkiwwGmCstfKEHxLFKFj?=
 =?us-ascii?Q?H7uJwKCz/wmLuzxAEDSwpaGKfMWibk/5CHofAUvSsH77FmF+nc7CmWxT+b+Y?=
 =?us-ascii?Q?XxvbZ4lbTmZMV/YcL40AZm3QZbkaXY58Q2m2xfbTSUJHoh0Li72XezWRXA0g?=
 =?us-ascii?Q?6gmKHNKO+P1FDqQGG5oda8t/04tR9L5NQWvBRvorxcHn73R79XEcOWPBE/4X?=
 =?us-ascii?Q?23qwI8EQntGwNE6AnOsVNXMQN+BK6H4vIfGPTETD8lMNaCURhqxK+A5TlE8a?=
 =?us-ascii?Q?gvnrQG201qogaebZ/4gJusbaZi27chKSDAzXl3NjIFIFpjiqDz7dFgtvbmMb?=
 =?us-ascii?Q?mK8svvIcZxtZkUxi9IXmGxQp1pldldUlFjpn6I6YTZNgbC78eIrZk8+DzRJf?=
 =?us-ascii?Q?LCEcOGEjx1QziraeKT3a4T9uDQ9Qsj5ly4jTL0WTRLcblkCUIib1qIMkfdPO?=
 =?us-ascii?Q?jep/M9CLTGRY5ZavTy4QGgsqLmrTQD+s/oeDycOsy6FIwxbjQM9Uc+r+L5n+?=
 =?us-ascii?Q?XDaG8FKIWoTIOEEIuuUH8H+ZJ2Ict7kWAfWOAhOtQ035Cz0CbckL/01LQeK1?=
 =?us-ascii?Q?y/K8Kg7+R9D6YudFHGk7Dsa85CgaFpKF8WZpwk0HYGCaqMr9GUlHG3yzxr5g?=
 =?us-ascii?Q?06Qn8aCvllg38+wAdAEPvdEVXKR9BpbsJIRFFNY7FRwH7EKAKxq1C0hkgjhs?=
 =?us-ascii?Q?pqNif504/lZXm8kOk7PuH4Kijh5mu0MJ7yrmzM43ym5yT8fTuI7zkNS/fspO?=
 =?us-ascii?Q?qXnp3aLExRvFun8LK+eLC37CZYQ6Qay7dFGf6m6XkfACxCMVs9Ujq0ovVd+M?=
 =?us-ascii?Q?/Ywdkf4j7Op8syyP5FRyniJqN+qcl/a6454TWhKtw4szyXmcvahilk62ArvF?=
 =?us-ascii?Q?4J48WApu1yshlgNR9scwO694qfYanWEadfMKsg7+me9gmf9Gm2T8uwq9m8DU?=
 =?us-ascii?Q?6mZXVYyuPISWsRGW42fDKzkgxo32Q/Mdvn4pH44s4kJN+Kcc2p/aMSRAFCHr?=
 =?us-ascii?Q?RKR3CfgI8zGDqZyNpxUBoAQnWBkoUaOKTQLOLc2B8iqZUyDurCAG9trhaDSi?=
 =?us-ascii?Q?RIxaPyqVQXHUiSkTa/l0bETO6p7uw9x/5APYhSLaiIV0c/J571/dUhoKXlIn?=
 =?us-ascii?Q?PUl2UGyXQxHio2OlDveT0fA3x/ifVol96ZqxPTGVRwxqoLD2lpdhQ0X/Bcdc?=
 =?us-ascii?Q?KOTD/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oy4He5pgf4S0KLizzsSxkZxWzWM3I/w3sbqv0MlDkwL9RXlGadgbRwGzPU1zo83WcDCkpWz0Jmql8VFkchS72cCuj3DpcCv6tyeupeOd66H6raACiUvEy34lVUQYE8mKS8wfj6M0gLNlLcZPG1BVL6dXygB5enwvjI4uLPmizPmbpusoHvP85hEeRcuM77jJezdpNVhXpPNEKVcQdjZjqbuUrcRpqXA/Q4tIR8ZbgXMtuglvTsCe+P2JPgbyl84k1hPfNzR+Z+QXZu5Xraz/CHFkCxXO1Ulip80cob0QlYgN848iCiYETTF4MtFHPYzbpX47U8h2UX776gVbZ4o6NzPKpfsw9+OUErxkdjOoNAe8zmzXVFpHHkRpOw8Hj2O+b/N25nK/99CmCnky8/Z610j/rjGkEPNY6yOe5xUsUCRudCETSOhI25CRcWugda/R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:53.7187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a8c0c9-1ad2-470b-7802-08de658efd0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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
implementation for CMDQV initialization, vIOMMU/vEVENTQ allocation
and reset handling.

Functional CMDQV support is added in follow-up patches.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/Kconfig          |  5 ++++
 hw/arm/meson.build      |  1 +
 hw/arm/tegra241-cmdqv.c | 60 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h | 23 ++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 hw/arm/tegra241-cmdqv.c
 create mode 100644 hw/arm/tegra241-cmdqv.h

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
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
new file mode 100644
index 0000000000..6f30ca035b
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.c
@@ -0,0 +1,60 @@
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
+static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
+{
+}
+
+static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
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
+static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops_impl = {
+    .init = tegra241_cmdqv_init,
+    .alloc_viommu = tegra241_cmdqv_alloc_viommu,
+    .free_viommu = tegra241_cmdqv_free_viommu,
+    .alloc_veventq = tegra241_cmdqv_alloc_veventq,
+    .free_veventq = tegra241_cmdqv_free_veventq,
+    .reset = tegra241_cmdqv_reset,
+};
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void)
+{
+    return &tegra241_cmdqv_ops_impl;
+}
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
new file mode 100644
index 0000000000..81c9deb384
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.h
@@ -0,0 +1,23 @@
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
+#ifdef CONFIG_TEGRA241_CMDQV
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void);
+#else
+static inline const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void)
+{
+    return NULL;
+}
+#endif
+#endif /* HW_TEGRA241_CMDQV_H */
-- 
2.43.0


