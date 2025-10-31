Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A797CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmkp-000368-Ru; Fri, 31 Oct 2025 06:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkm-00031l-5i; Fri, 31 Oct 2025 06:53:08 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkj-0002up-EJ; Fri, 31 Oct 2025 06:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abS3Dr3rjPxscHHATxs/3USajBaBAEtdVB0y5sYC4iGxluNJQt8QBorvn2mr7XeVKicxhPFTQLZXt0smGcDPj+sbsjyvSpkHWmksJLg1FhF7ydl4jQkUzCZtgCJx3PhFYDyvakG4pp2F5n9mPaPauSJpSRDDDkUtu5CQrkGKNSKCWlFoVJvO2v/EiF+7MVq5/bhzag64RVY+7X9PnwHP2BGAxqg6TLHuBalgqIL3omMlURk3C6aXXxLIVK+n80hdSn5a08DJSc6HmCD70mOvUBY3MMcmhPuScfNYy3uiHUy8f0v9HmoVPi2FfZMcREHxk2A98PN3L/kazdkkkznqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jrRs3RnlNjljl37U7ZfKY7be7IXLRfZgmtCJPkqxVg=;
 b=UxbFmcGe/KlIzCw5ezNybim9cSrLS0NQCA16bypFTO/xu8A1ym3CCeb50VRp8+vcR7ym5nmlIqQY5Z7yWuseyERSRmoxLh8nm5llJrgqi6LmwKTsKxtIXf+zScgMbRSfzjmhKJ0iNrbdi/nNaqKhE2NLvhmEx8lc5aA0Z4MMsQgtI6+2YX34CSsWNOqo/TO+MnCOG72NlcampNXLRSN9sKe/BYHNpB5WRurYb17HLt2pGIbC6I7zokYxkJ5kYV7WrO5cftOifk+A3z3rbdI7rqPTPe21Wmwsje3VuIOYKTuqMgaHg0QC18LuQc7n35U/cZpt9oDb7Fv0TlzHjxiCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jrRs3RnlNjljl37U7ZfKY7be7IXLRfZgmtCJPkqxVg=;
 b=Pb157ajDByAWQ4sZpbDMYSIvaVWhT97+axXKiLZSu52gVVrTTYfsZPoWID8Gh6dHXK98ujig/JR8Qiz1v8oNuD1PLP6jS5R/+mtiXDjzLVW3L6SpfcJz9zLXHBMsl8Zwq/K/Wk6DQtHbr1S8L0EasnjBl0VxrLzRMRsULxxGxAdvtLqsHxjtTvqKL93godWodJ1WBk4WAxDMgqtlX/cXFSCPQld9Z4ZessqdvEUB2Dx+2h6l9pXnoYBG+BIqidi81NL/DOw8k9ZhNOjmM26yRbuvW00pXRDVZL5j1ICOWTBdsuWOW/FULuA3kbVZ+vUFfA70NWBgD7T6S5zyUz5j8w==
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:52:53 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::d8) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:52:40 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 05/32] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Fri, 31 Oct 2025 10:49:38 +0000
Message-ID: <20251031105005.24618-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d07813-6efd-438c-a407-08de186ba480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWRyczNjV1JsMzZib2xoT1NOd1BXaDhXVGE3NUF1RXJRcndJT1FpUW1ISGQ3?=
 =?utf-8?B?NDQ5bXpDTVFQNFBscGl2Y3F3WkZEZ0dNQjFRdkhsSzNZM2VyMnR6cE04UnE3?=
 =?utf-8?B?WXlRcWE0aFZqZ3hlYUJkZnhpQ2l2K1J0bndiWnpIaUFicEJXYTR3cERiQjVz?=
 =?utf-8?B?VE8xb1RUZ3pNNC94ODArTmFlSFZJMUNiWE95ZFpYSWt4cS9SZEMrWnFRMUpO?=
 =?utf-8?B?cklBVFl0b2g0akRmYVM4ckIwcmZrOHdHYXFmM2F1R1dndGVkcTNSVTYzQ2d5?=
 =?utf-8?B?ejFIMUFyeVpxaUNFTUQxK3AwN0NvMVRjMXBVeGRwUVQ2dGJmQWY3RzF1NnpY?=
 =?utf-8?B?d1N0Y2tGaXVsdjVsL0dCTnRaV2JXL1gzeUg4SjJHR3JQK1AvbWphS2gyMXdi?=
 =?utf-8?B?N3dqZkNXQmlrVEtYU3ZqKzJrNnEySm5CQi9IWnlhUWY2ZGZEWmREQmhuWlVS?=
 =?utf-8?B?VFd3c251R2JjRkFuVHZhd2RDTThEdXp4b1gwR1JqYVIycTVtVG56cHpFcEJo?=
 =?utf-8?B?dnhBZ3ZhanorNlQ4Z2txWm1mc0Z5LzVnMU1qSkhKQ3BDWHB0elcwVlRURjI2?=
 =?utf-8?B?eG9oaWo5TENGKzgvcFh5bEtoVkhzRXVxQlNhbE5WYklIWmNObDlMMGZSM2NH?=
 =?utf-8?B?YXNxYTBLY3cya3kwNTNlV0M2cmhjdTl6OGVXMDlWT1V1SmRmT040UTdUWTlk?=
 =?utf-8?B?T2pSbi8rbUZLTjFDRmR5N1RrMjZ0S01RMVNObldzejJJd2JZZHc3SDB4UGxx?=
 =?utf-8?B?bVRvMklBR0RCem90UlgvZnE3RVB5ZkFEWFh4SXA3TmJ3Y0NLQ1pnWW04VjMv?=
 =?utf-8?B?RzVIRjRKOW9taTNNcUdRNUVPQ3pFS3d4RjNBZlJBeDhHdXBGcnhNR0lkREk0?=
 =?utf-8?B?SFlFQWxCU0hqSGJxdGhyWk1ibnV2ajNNNTNVYm5SZVRmd0ZQVnIwbklGUnFS?=
 =?utf-8?B?Qk5WM3h4K2I2SHhYQ1NhcVpnRUxlcmtkNjVZckRBTDFyRkhmYXBBMFlqSDhG?=
 =?utf-8?B?aU9pWGlWY0pJUDdTUlNGcUViUmtLd055ajlybEZNZjRhNWV3TzF6ZExrS2M1?=
 =?utf-8?B?b2hVZkNya3lYQXR5L0kxcTJQdXRXWUFsQ1pjNjFDZC8vM0Nzd05leDFBNjY4?=
 =?utf-8?B?T3dyZWxmNjdQdUkzdkI0YjRxZi93clFJVDlZcGszdEN0U1kxbjlqTDhacU04?=
 =?utf-8?B?bVorRGdsZFVIbEJ1Y2hCR2RxbTlHZGFtVzloZzJsVEhVWkxreGFocllJdXZ3?=
 =?utf-8?B?YVkxbFBhWFZ2eXA2TFIvYk0xV1E4SmpUVEVTVGJKNHAxbUI5bldaak1Lc2JG?=
 =?utf-8?B?SHlRbFZQYU1xM1dEdTE0eDJBVWoxRzhKQTdObGRhSHdiZUE4cGFEeTliNlpy?=
 =?utf-8?B?OW81MTAvam1UcG1MYW1xU1kvWjhrS2VLZG1rcjJ2YTBSUjg5Y2hBK0V1K0Iz?=
 =?utf-8?B?UnVOSEdCODkwak5VZ2Y3M2FkY2VvSVI1SHVvS3dOM25Ha2JCeWt6MWd4NWhT?=
 =?utf-8?B?RHprcWRHTDdDNnRxR1JvVW1iMEhtL2dteEN0T3RvSkxydStFWUdmbXR1SFpE?=
 =?utf-8?B?ZGgvc21DMTYrTnltZGlUZzZyVTQ5QUluQVE4ckFXQTYzRUJseFM5L09SYnZz?=
 =?utf-8?B?QUVJMmRJNnRXUjFJL0c2RkV6R2oyMExrTVBKTlB2R3VRYlhuSFVDejdDU3Y0?=
 =?utf-8?B?dFNMSmFXMzF0aFJvV3Q4SnJHeVpiY0IvQnhESnRXRHVIaEJzc0xpaCtSZUk1?=
 =?utf-8?B?aFZBaWE0Tit1ZXBWWmJOU3RLQTgzZDNXbVlKQ1diRm9EcU5yTTZhVXArQnB6?=
 =?utf-8?B?aEgyVTVSUFFHczZXWDB3SUZuUWxpd2QrMGhRMGYvTGZJNm9XWU9ITTNxeWhq?=
 =?utf-8?B?enNGTks0UWt5Ymhydk5GQjVSK1hhajZWR2tya29LWEk4eUF4WTJFWGpDZGZI?=
 =?utf-8?B?YXJyakxxVUdrOVFablBTclhPV29Bc056VzBrWWhYeHRjWCtBbzBpODF3OXZj?=
 =?utf-8?B?M242VEJiS05DVitSbkU1Yk5rem9HYVBJaXhTM2NZcEI0N2taTlZxRnZhQmw4?=
 =?utf-8?B?S3BqdGRtM1pTZnY5UFgxZllWNjhmYTNzN1RVSzhGSW9LbFExUUNMR0JCYnI2?=
 =?utf-8?Q?QcE8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:53.2271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d07813-6efd-438c-a407-08de186ba480
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
index b44b85f436..3a6dc122ef 100644
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
@@ -628,6 +629,10 @@ config FSL_IMX8MP_EVK
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
index b88b5b06d7..32ec214434 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -62,7 +62,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
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


