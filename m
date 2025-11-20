Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6261DCF8858
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dT-0005dv-Kr; Thu, 20 Nov 2025 08:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dS-0005dV-6C; Thu, 20 Nov 2025 08:23:42 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dP-0001zV-Fh; Thu, 20 Nov 2025 08:23:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXg80dUrtYa5MGAa5ew/3vj8iFhpvVSJ2N7TJewN28Y/DbVhtz0j3fZuAKE0/gFzM0F9qCrOnVSS+l0dgerTq19iLdOs55y0bMiSyqH7pEnR1quakGmCIA2SvnB5nL82xvpJISFUdrXc8cbiT10Fam8pRdDkeV5xNd+dZ39QpKdmScvA3+lZTDAql7KJSb6CxqJZ68ad/gU0glFYVVKs2NwbHh58Hn215QNRNNEbyfMOKKCDJDcBOPXftW2f5oSbnXbK2bMghoo2CufsW2HkIVWPD4NDDZcDSdtJ33scOVFfzwcrCQb6j+yXSNTZTIvEgi0jn7ing0aEdaYkopnb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o+w2zmect8gkCox9muq78SFTu1GUMFJFrDOZw4nWjs=;
 b=gxoCz5312M56/kVayhnJK+qDOVuSGv3r2qm1mkcrAMT7n+UK7DQjR8WqZNTEtNpfgLebki4cE9YZOljYnHJ6KEzvvvdl8uLp2GK5yiS+aJFE2hYpkZhb2l9UOnlCP0wsKuFTuqiNhXtfUPrC9SPDIP4X4VUiae7OUGIODCf6OXGhGPZLew3F9OmWVT9hcfE0SLPkzRGJfEulGZYI6/TEV+9DwBJy+FYz6hj0R+j1ZfFNQfPvDECMl/e6KyEngz9ZDo/2BiDgyDhN4sWHK1asqerg8dFM/Sc2oUzNt5J3WvsNaZpsi/9oXNyiI2YMXD32ydzCmZgUJB2ZiKKpwpQ7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o+w2zmect8gkCox9muq78SFTu1GUMFJFrDOZw4nWjs=;
 b=SXbhSET8ARC7VVpbDeuHnpMBtu7pjx+R7VQlMRIQCx/ViGcXx/Y4TwAhFzrh20L7Lts+jLtPTOCB8cIe60BD1tbz2+CRVw6Ky4un5QM09krUEpfsYDrPuQ0Xvp7mGvvo1yQr4YRsXzERw7poBFXkmOqaHoj18Po7UZExG6GcBmvkD8Dmcp+niZJsWlsCjEdsjb1LNabJ1phmdFnUQq2Vnkcmyfr4a4rg+jCvQcsRpUZburf5s7zMpOj0pMJRq2vKw/4WaovW67N37Dk5bWBftPE8jxQMi7S2KC/ecf60V5ITWz16z3u4pyddStsM00zI06ytD+UKLAMWicM4Reji/w==
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:23:32 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::72) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:15 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Thu, 20 Nov 2025 13:21:45 +0000
Message-ID: <20251120132213.56581-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: f97aa02b-db54-4281-9bae-08de2837ffd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1NFTnBTbVVKc0hFVldiU295YnkrYXJOeDVySUExQmtxVkdFYlBBT3k4S1Ju?=
 =?utf-8?B?QVNUaXNPZlhCbnVDdXZuR2tYZE1kU3R1bTJ2NzkvQjRUY2dtV2w2ZEs4M05M?=
 =?utf-8?B?TmNRbXVoZndydnA0OEdXV29LSEJ4cjFEMzhIei81SGRuc2dBV3ZTeC9QV01B?=
 =?utf-8?B?VlE1TU9uUkwzNWhjS0s2MWNFMXlzeUtvTHQwNkFJOThxVTNXdkxocFE2eEpF?=
 =?utf-8?B?ZGhoMmprY0toWTFSdnh6WWdDanZKeCtRRC9nVlNKRG1JVkl2R1ZMZXJGVFMz?=
 =?utf-8?B?V0dLc09sNWx4dXVSNFpEQy8vSDBicEliVkRFWHFETWdkaWFCNUFTVzlpNGlM?=
 =?utf-8?B?d2FJbE9IZWhyMGs2bElZWE5tdUQ2WFAxMHgzQXRoK2pQR2YxcGQ0VlB4TEZW?=
 =?utf-8?B?eFp3VWdIVzlzRjE5M3I1ZklZUHlMVWg0eXNtR1hxSk4xeFJOVXNyNnRTTVow?=
 =?utf-8?B?RkZhNGk3WjA1SEF1bUo0Wm00TjNLZnBQcDltTkNlZnE1VEVSS3RKZGJ5Wndv?=
 =?utf-8?B?Z3ZtcHVDU2taNmxWbU5KenYxYlNScEorY1k4Y3FOSlM4SWxGcE84VjIwYzJT?=
 =?utf-8?B?MjkvZG8yM25TU1dxVDV2eFozRWlOQnMxRk5MS0M5N29OSEFtSmlLS0NSSjBP?=
 =?utf-8?B?aXVFcHJISHFsbjRuRFEva1FTUHBncnJxclRZVE4rRkNjejVKbmMxWGsxTWE5?=
 =?utf-8?B?cU9iRDFiczdHeHh0WGhITTVZNFJtNVNWcGcxR0kzNnpJSExsS1I1ZHhuNGdv?=
 =?utf-8?B?M3BNN1gvMklNdG1kWW9Ta3ZzajFBY3hoam9Od0piODFObEpQS29HWmlHZWFZ?=
 =?utf-8?B?bHlIb3FiN012NU9LcTZJeDdnY29yTTVRMWNDSlpEcExUaFJ6RXdsRjdFVmZl?=
 =?utf-8?B?WG55NGlyb3BGMkNyUnkvcURXOWRtWHBiZGZpaGpYMjVkaENRT0xsR05Cb2ds?=
 =?utf-8?B?VktYUGJRVS9HQjI4THJBaUh4VkpXVlMwZmkyME9aaUE5TzcwVVJSZGF4aXJE?=
 =?utf-8?B?WUtEV2l5UVBqM3BCRU1lUkRWVGdRSXRjazhETzlzMFdQUEYrZ245Y1lvcXdI?=
 =?utf-8?B?U2RoYVgwdGFTUEhhSlVTeHhSQzZkZk4zRkVzM3Zob1NpTnZMOXloeVVjcGZB?=
 =?utf-8?B?TEhPRHRyYnIvN2sxNkE3U0t6clhSQU5zRU5nODdrSDFWcFc3bkhEcDJhdHFP?=
 =?utf-8?B?ZDFqWDliVzdGM0V5UmJSazdIenlKTG50dmJQeDB5ODBBL0E5cjBkdlZLZDFs?=
 =?utf-8?B?MCtNTUpETmtEMUZ0b3dBeUtqVGJ3MSs3QVQzSEdYTFJIZUZJeXBwOXAxZ3FU?=
 =?utf-8?B?RldYV2d2YmdVSGRXN2h1cTI3Z2d4a0ZST2JmY2pRNVBKN0RTSUJ0WU8vV1ls?=
 =?utf-8?B?dHAvZWM5cUNFTnUwalpkbUdzcjdibkk5b2xUVk5maGlmeFZlYkVKSE5GTHZU?=
 =?utf-8?B?MUxxTndEbG5DdldyM0NBR3N2UHRRSHNNajB1a2wwM3gyckZDS2ZKbUc2cXNO?=
 =?utf-8?B?N2dZNVB5ZVgyeUp2NHhwcExydFRyQ1dFU2xLaEl1YVcxeWgyRzN5eEY4UjBa?=
 =?utf-8?B?ZHVjMVorb1VvbCtjSmUyekw4SVRDY1NmQ3ltYTMvcy9nd3NJTVRlMlUrSUxD?=
 =?utf-8?B?YTVYZGlvZlVkcW52RWxmbmhQWFdxTm12dkp6eGs0YXRsRklzcXRSTW9Mb0J2?=
 =?utf-8?B?MTZMNXZnSlRrR2tKZ3EzMkdZb2JNbnd3MndYVzdjcWh1L0lieW1zNkJWSzIw?=
 =?utf-8?B?dXEwRi9mbmFURTF3Rnk2VlpWaHZ4WTFXRVkzQk1GdTJzQkl6RjBONVcwRmtU?=
 =?utf-8?B?L1IvOGFJUW91TnE0Zm5hTmthNjdVcEJoMnUxMFpPU0dEeDJVbFdxTWlQamt5?=
 =?utf-8?B?UVdKM1FqZTdwenhtYUFvQWtyak5YY0dPbFFZeWpsMW9leVlwTWpoclU3Tmt2?=
 =?utf-8?B?ekJoYUFqekx6TTBmNU4rMHgwbEFsTEQrd1lva25XNGZsUFdSZFp1S0lDZ2dy?=
 =?utf-8?B?Q2VYZ1FtaVJ2dzlZTndQNHN5UFYvb1hHbkVtREVDbzRUUHVvWXZZYnhIZFVo?=
 =?utf-8?B?QW9oeWFBRUN5Qko1Z2lyN3U5b25zWXJjanJDRHJKWkR1dHV3YTUwbnc1RXUz?=
 =?utf-8?Q?Avg4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:31.2278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97aa02b-db54-4281-9bae-08de2837ffd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
be changed to arm_ss.add.

The “accel” property isn’t user visible yet and it will be introduced in
a later patch once all the supporting pieces are ready.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/Kconfig          |  5 ++++
 hw/arm/meson.build      |  3 ++-
 hw/arm/smmuv3-accel.c   | 59 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
 hw/arm/smmuv3.c         |  5 ++++
 include/hw/arm/smmuv3.h |  3 +++
 6 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0cdeb60f1f..702b79a02b 100644
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
@@ -629,6 +630,10 @@ config FSL_IMX8MP_EVK
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
index aeaf654790..c250487e64 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,7 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
-arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
new file mode 100644
index 0000000000..99ef0db8c4
--- /dev/null
+++ b/hw/arm/smmuv3-accel.c
@@ -0,0 +1,59 @@
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
+/*
+ * Find or add an address space for the given PCI device.
+ *
+ * If a device matching @bus and @devfn already exists, return its
+ * corresponding address space. Otherwise, create a new device entry
+ * and initialize address space for it.
+ */
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
index 0000000000..0dc6b00d35
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
+    SMMUDevice sdev;
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


