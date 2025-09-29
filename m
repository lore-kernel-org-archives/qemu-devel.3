Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5320CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6y-0002h4-PU; Mon, 29 Sep 2025 09:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6s-0002f5-Sd; Mon, 29 Sep 2025 09:40:10 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6k-0003Gi-GT; Mon, 29 Sep 2025 09:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrO9p5gsER2p069aQFYj9SJH/eQIvw2K3wURTYN0p65/ZYwttXmmswuZ8Hv5yQOL8HgfK1ZSI2gIqCkY+VkW9z7shskqTR4fH9hTexnt4eec5cTx3UvEkK8ZJPPMUpoj4CbevLXDjezCspGsV0LBs+rf6Yy6zp3Vbnp7GjKh1x9ZNtdQTI1NNSw+Be1EPsuim3g8CTEioA/ga33TNRah5CAqr2Zwr7dKKHu8bQ2krpcdIEOtDnKYqOIB7QdwP+xUp4XJVed52ctsMCWP0x0OLjVV0RP+wWQERQfvRmmiTfSKrRmQA9wmMl8HC5aKISn9vQ3KzoI09NHM8z3OiYkopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y60kJhwtLcxBVArRi9RSlF7Z7+rn3QO/x7ED+lHKRsk=;
 b=ZAzfEMMC9WgLI6ddVFBplCeLN0ME5exFkZnpyuZgxImFPY7Tgb05ogS32e25p4HzlHusxwRSophqnOUqtnnNwnJIIO4hRXTi7JSw9GaMimk3x1QQHNYkRWfp6kSwvuRv33JKZD6Y4KOSUN7ak/p7JzHsWgaaIs/aHqA1h/1567WDKQOA3zFaQSNZ20Qv4L5D7kPSj834xdWAgAAUrHdoOwrQmDE/aqwNzwiuPx0KQnGXdYS1ZsjB5V5K/3H1p1z2MKywrDUEp7qjCNkKOzxZz3l2vJSzpqEFvSFqrOXZXOUObzciGg3b/HNVNv1SoHQC6U5V7QwoZFnHmAtWHe1XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y60kJhwtLcxBVArRi9RSlF7Z7+rn3QO/x7ED+lHKRsk=;
 b=friHIeHoHB0BI4TxKV7Ul7zS0jIRjPsXlTHCpQvwZx/gw9mmKcDFAg96rjGcbwWN9oBhg7O06hV7wJG4GrofXYJy7vtOpgjEvyq4AhDTGE2AtbraXYoIVoP4fW8JrwSRhneW9IloC8Qd2W6l3LBc4wapsOCER1M+di7386vvTES9JZw9nBml3AbY+WUkcwlTLI5U4Jbivk102wIaXeOvSF9uvO6a/c7Dj+bJih+/q+OV+VGLi51k8PTryX+Pz2ay7UZCWUmgAwCVGZNFtCTS82R7ylgeTshsjwI679ELGU6VcEhQXNOPqY2qXIhnJp01uYYX3x4/ETGT10m/lDjzKA==
Received: from CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Mon, 29 Sep
 2025 13:39:35 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::ad) by CH0PR03CA0112.outlook.office365.com
 (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:19 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 05/27] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Mon, 29 Sep 2025 14:36:21 +0100
Message-ID: <20250929133643.38961-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e93561-2083-4996-8b73-08ddff5da0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHYwcTRlSUhDOVNaenprTnBTNHB2U1BsRWFPMHZkZVRLcjFwQWQ0bWhYaEhY?=
 =?utf-8?B?VXdwUVVNajZ0elcwYitkN1JMQlBLdDBuQWRLaFMrZmpGalBIYnM2K0lzL2Ji?=
 =?utf-8?B?eEV6Nlcrd3dpZ0s2U1Znc2JuVDFOaEJQZW5SaW1qNHpBN2cvcmptYkxWVTZX?=
 =?utf-8?B?OUZ0REZST0NrdW11QWNLcmlSQmlCeC9oNDhZalU5RCtLUHB5TFNLelBvayt4?=
 =?utf-8?B?MStoaVMveEpLTWlQM2d6c3JtWjhyKzRDU2pZRHB3WTE5cWViLyt5aEIyUUJN?=
 =?utf-8?B?WnRpUVV3dDh4cUxLZld1d1VHdWhNenYzeWVlMnVhOW56UXplQnd3UTVibk5K?=
 =?utf-8?B?b0tNWnlobmwyU3lEQXpkdlV4SDN1Mm5qQXZkREJsQ3FMeWloNVFzamNQZ080?=
 =?utf-8?B?YnVzamNrN0lHWGJFRzdydk0vNStiWEc3YUdQSkdlckZaeDdmai9kVDN1bjVy?=
 =?utf-8?B?ZXNuY1BLSGlRclI5eURMNFFiTHZYajkvaVEwVFB5QmFrdEliUTVZM2pUK1J5?=
 =?utf-8?B?WlRpdVcvYThVTm04alBpS1NQcVAwTWgxRFVwVTJpeXZ1M1l2Z0hCNTJORVFk?=
 =?utf-8?B?WUJoQUtiOUczNWNzU3B3MkU5SXpJbDZKN2JaQjlNVFpDRzJyUEJwOW4veStq?=
 =?utf-8?B?Y292V2w0M0tydDBqUURTeHZ0MUFXTXYzOTVCdm5wZmhsNEM4R0t0SVVhY0pt?=
 =?utf-8?B?T3A0VHhmOXl1UFRvall6Skx3a2VLU0lQTU0ySmp3bUNlMysyKyszVEV2QUNZ?=
 =?utf-8?B?dzhQWmpvdGtFSXlGeVJyRklpTDM1MUhmUks4SmxYRmZsNVlPTGNVcGVEb2tm?=
 =?utf-8?B?cjhQeHBlOXY5UmpYNjFvdWFWUC9IQk5idlR4MFlDVjM2bjhZUTBKUVVwc2Qy?=
 =?utf-8?B?UzFNcnNHZUpUQy9JdXZlYTBYdzNQT0RnWGRhVENBM0V3NTh2b3VKRHQ5Uys1?=
 =?utf-8?B?SWpoUzJsUjBaOWIrUS9sYitidGxXUTJlcngzQURuUWhXU0lTRHBiYjhOWTdw?=
 =?utf-8?B?KzVYN0JGVnFYNDN4bmlnQ3ZTNkQ3WGkwWkd4Z2VBKzJmRkVFbm9DT25Vd2gz?=
 =?utf-8?B?N2hVbFVvTDBubUphNVFLSzA1WHAyK1FKQ2Z1LzlYUWkvM2RpTXZHMzNzYXhZ?=
 =?utf-8?B?SEJ3cGNVejRacEpCeE1PRVE5L2EyeFZCRHdpK3hCdXBRb0J6NWs4YXpXLzhI?=
 =?utf-8?B?N1FCWFR3OER6RVBkei9SMW9MTjNCaE41Rkk2VjJMMUliTTJkUzlNQ2lzak44?=
 =?utf-8?B?b1pyYUYrUDFTMk1kVE54QVBRTXJ2eVdHYnp4L0RRWDFXK015TldjK29PWXNX?=
 =?utf-8?B?a0tIOHpIYUFVanpKTE1oTG5nNEZLUms1bkljTUZ3MU1UakEyVW9rVHJybmlv?=
 =?utf-8?B?T1RvNi8zRW1UL2pyd05rMmEvWU56cE9mOHpQZTZmWFpFaEFJWXMzSXdkZERl?=
 =?utf-8?B?bGhSdm1NN1pSUnJ5dTVkcHZjYzBqdVUxK3E3RjVFMm5vZUZsakRUL2VicU50?=
 =?utf-8?B?UjB5WGNjNW9ySE9IRlVrbkx5d2lRMEZhaUNVZlJ4cnlyQ1Qzbm1TNGRjcWtJ?=
 =?utf-8?B?cHl3ZXBIZ1hxTFYveUllbDJLcTgvaDAvL1JNTzJGNzhZdWl4Y1BvTTN4KzNi?=
 =?utf-8?B?cHpFWE1HdHRUN0gzb2ErcWtmSW1xRjNEK0F0S3o2V294cUEyTGlwQWlDSk9w?=
 =?utf-8?B?ZWVha29OM3ZReDRUeEhDSUVuOEw5WjdxWmFoZ1o0THZyWEdlbHRzTlczYXMz?=
 =?utf-8?B?MlpVeWR3VVZ0Y2xReDB0REpGNDZkYWdjMld0UlN6NWZWVXl6STVFaUlBSzJR?=
 =?utf-8?B?WDhIQWI3OEV1SEhOMzV5WFQzdHc4RlBXR0o1d1hhcG14YkRTblkyQWFrOU1a?=
 =?utf-8?B?TXFxQXBxT1ZqNGhnUTVwdFU2cVZiS1FTZkd4OER4OW1iWkhWWnVQK3JTRGU2?=
 =?utf-8?B?UDNZRkFCNEhBNTlDWDBuTGNuWDZhYzNkZFR1Qk1Meitza1FYUVZ0dEgvb2JV?=
 =?utf-8?B?dCtxTXg3WUVRUkNVRXV1V3RiNGFDWEVIckZrQ29EMmN5ZlNoNWdCTzR1eVMy?=
 =?utf-8?B?YWx3aEk4L0FsSkVyOXJ3eEErWDdhTkF4ZUFxZmU0KzZvQWFMdVpvYUpPbDJR?=
 =?utf-8?Q?+izM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:35.0227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e93561-2083-4996-8b73-08ddff5da0d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
different callback handling in upcoming patches. This also adds a
CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
at compile time. Because we now include CONFIG_DEVICES in the header to
check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
be changed as well.

The “accel” property isn’t user visible yet, it will be introduced in
a later patch once all the supporting pieces are ready.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/Kconfig          |  5 ++++
 hw/arm/meson.build      |  3 ++-
 hw/arm/smmuv3-accel.c   | 52 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++++
 hw/arm/smmuv3.c         |  5 ++++
 include/hw/arm/smmuv3.h |  3 +++
 6 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3baa6c6c74..157c0f3517 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -12,6 +12,7 @@ config ARM_VIRT
     select ARM_GIC
     select ACPI
     select ARM_SMMUV3
+    select ARM_SMMUV3_ACCEL
     select GPIO_KEY
     select DEVICE_TREE
     select FW_CFG_DMA
@@ -625,6 +626,10 @@ config FSL_IMX8MP_EVK
 config ARM_SMMUV3
     bool
 
+config ARM_SMMUV3_ACCEL
+    bool
+    depends on ARM_SMMUV3 && IOMMUFD
+
 config FSL_IMX6UL
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index dc68391305..bcb27c0bf6 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -61,7 +61,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
-arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
new file mode 100644
index 0000000000..79f1713be6
--- /dev/null
+++ b/hw/arm/smmuv3-accel.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
+ * Copyright (C) 2025 NVIDIA
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
+
+static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
+                                               PCIBus *bus, int devfn)
+{
+    SMMUDevice *sdev = sbus->pbdev[devfn];
+    SMMUv3AccelDevice *accel_dev;
+
+    if (sdev) {
+        return container_of(sdev, SMMUv3AccelDevice, sdev);
+    }
+
+    accel_dev = g_new0(SMMUv3AccelDevice, 1);
+    sdev = &accel_dev->sdev;
+
+    sbus->pbdev[devfn] = sdev;
+    smmu_init_sdev(bs, sdev, bus, devfn);
+    return accel_dev;
+}
+
+static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+
+    return &sdev->as;
+}
+
+static const PCIIOMMUOps smmuv3_accel_ops = {
+    .get_address_space = smmuv3_accel_find_add_as,
+};
+
+void smmuv3_accel_init(SMMUv3State *s)
+{
+    SMMUState *bs = ARM_SMMU(s);
+
+    bs->iommu_ops = &smmuv3_accel_ops;
+}
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
new file mode 100644
index 0000000000..70da16960f
--- /dev/null
+++ b/hw/arm/smmuv3-accel.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
+ * Copyright (C) 2025 NVIDIA
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_SMMUV3_ACCEL_H
+#define HW_ARM_SMMUV3_ACCEL_H
+
+#include "hw/arm/smmu-common.h"
+#include CONFIG_DEVICES
+
+typedef struct SMMUv3AccelDevice {
+    SMMUDevice  sdev;
+} SMMUv3AccelDevice;
+
+#ifdef CONFIG_ARM_SMMUV3_ACCEL
+void smmuv3_accel_init(SMMUv3State *s);
+#else
+static inline void smmuv3_accel_init(SMMUv3State *s)
+{
+}
+#endif
+
+#endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bcf8af8dc7..ef991cb7d8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 
 #include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
@@ -1882,6 +1883,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
 
+    if (s->accel) {
+        smmuv3_accel_init(s);
+    }
+
     c->parent_realize(d, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..bb7076286b 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,9 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+
+    /* SMMU has HW accelerator support for nested S1 + s2 */
+    bool accel;
 };
 
 typedef enum {
-- 
2.43.0


