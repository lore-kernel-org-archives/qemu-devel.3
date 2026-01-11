Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3722AD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Y0-0006YS-Ud; Sun, 11 Jan 2026 14:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xy-0006XG-Lq; Sun, 11 Jan 2026 14:56:22 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xw-0003r6-Ly; Sun, 11 Jan 2026 14:56:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDPonjyaHs3pu4WM4useNg7KAVqaBBYPAuKh0PMp9PH43p4xyq1+KjZy0t/DifvQgx8sKyN73hI9vL1vwfeTq5stmLZTUKRPNh4YruAzwIQ4Q5RN+ZYna3Jo7sVXFjTma4plxt7R2o06rL2aOfeP4Biek48X48KrO+md/bLTReT6q5S9LhHlIwPOv8xmKFM5u+kqFwLv0cek7Uu8e67Rdi+u0Si03nHJ58T+Z6kBETLXL52rpzWu0sffgnEW29ikP7mb21IRYitERNASkzEB9q1s4MhL0CtFshEGz5+Pg11yOSKHtG/0PZLvcvRUtSu5mzZG9/UHks1NBCJawiG8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as5Vy7LvIyUsT7Gn2J7GqA1lTSQU3ESdZSuAkBNTi+M=;
 b=dcsOI1WCuidUOYu5BfPuFAEyJqB70J6DndIsHdffN5/BsrLvS1+HDA5oY4bXD0ay0P9w9iwsAIsqofuNKUJw3qnxF1T+5c0TKv9fgXBigtKP0NVsWEB7JnKzX6hqRh3d3PClZOnIY4bKVm0QEj1fmwBSOHrW8a4OD4xNG6zuJqaZxI3L0sgt3hOft8BOZzfOBI01P1pQtj8kWvjRNLvNR9KykGHFJd/lLqfj8w4swsEfvv2ENpErC7ipPEwwhiZOv80L0gI+3uLL07ZOacN61paoMKQq54fJpqorWlemMNn/qtKnPVxegB0aQkx1HveOjC7OTl1lqDuzwVIJilzK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as5Vy7LvIyUsT7Gn2J7GqA1lTSQU3ESdZSuAkBNTi+M=;
 b=HJqJ+Ai4ltCezABI3ToqhWxXRNLj1Pyy9+nSvTPgoz81WeSMmB78ErQMk6B8uMyAsgZwd9IfoBVlbA9hih+VZPiWCS0jYc5DfBL/Px6X3Y6Naw5LBuvEaaU2UvyYCEnfV940qt0o+SNhmDUM1H/mfQBf6PA5fO+SJsqJIyyZlqFw+UuN8H6RCxdfTs+Yv2ss33qdG7YNWb7WH/6OZijscJIpmUu90wzgUBT7RmO7VoEkqY2Im/vjZ2V6NKowO02zrUWZuvcVYys3wCO80KlgDlMMwb+gIibN0+nuWRG3kmRfS9NKB5i9VOLcoZOJHp5tUTHTIhrGP+yMjBz6UAcsiA==
Received: from PH0PR07CA0064.namprd07.prod.outlook.com (2603:10b6:510:f::9) by
 SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Sun, 11 Jan
 2026 19:56:13 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::3) by PH0PR07CA0064.outlook.office365.com
 (2603:10b6:510:f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:58 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 04/36] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Sun, 11 Jan 2026 19:52:50 +0000
Message-ID: <20260111195508.106943-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: b16acd02-92c1-44e3-6b98-08de514b794a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djJKWTJOd21KYldJc045NkRYTVBXRlZrU3ZaSGU4K3U5ZGl3ck9DbHdnazhR?=
 =?utf-8?B?WDNyZ0UvTkxxM2pTWTlDWVVCa1A0aDBjTUVMV0VlSzBWU0lsQ3lKMVMxUXow?=
 =?utf-8?B?eXBZaHdsSGVKaGNMaFZyODhRMU9MTU5vWXNCVmZ6U3prY3dtL3R2TTZ1bFBr?=
 =?utf-8?B?bmFqaTRCOERhWEhnbzlkNyt5TU1JQkNvQTFKRVJjNFdySkhOcXpkTUtwQjBD?=
 =?utf-8?B?UWI3YXkxbHBVV1Zub3BEbkpvRC9KOTV3cEQvVnFlZDd5ZTUvVEFVMWl0a0cx?=
 =?utf-8?B?VE11YlVOV3NXa0d2d0puMUkycmZ6LzVYM3ZQTVd4MXhtaEZhMURNT2Y5RnlQ?=
 =?utf-8?B?RlBWZFRhUnVKMUkxMUJTRDE5WVFpU0U3eEY4SG5mOE5ac3Rnb1IrSHRJUGtp?=
 =?utf-8?B?dEx5ZmwxZEhMYTRRNEtQblJNRk5aRGFDQkVjeTZkUzZzRDBUdEQ2U3B0OEVi?=
 =?utf-8?B?N0RPVk5iM2JUNnVtQU9yS0J1eHhXMnlxY0hrbkYrWHBXejZjZ2swOWIrSll0?=
 =?utf-8?B?SkRmNzRhZk9sTFBIZWZ5eXduUUNWU25YbStSdHhHK3VXWjJSZWx0cEU4OWU1?=
 =?utf-8?B?T055WkdNNWdRODkzWVVsYjlERGhNeUhZVmcrSmE4SHdIbVRiY1BaSGhpSWF3?=
 =?utf-8?B?aTZZV2k0SWczS1Zsekp5YWJ4dU0xZWp6dDZ5N1dsTkdQa202NmUvdGpCY0M0?=
 =?utf-8?B?WVplb1U0QzNTckp1bW9JM3hqcTV5d0tIbGZkOVg1WjIralZmSkhaelU1V1ds?=
 =?utf-8?B?R1l3KzV0V2ZOUnRsQzBwSTE2T2J2Lzk0bnpZNTl2RGRSaHJzTy9TOW5FRjNJ?=
 =?utf-8?B?TEwvQmVZRWVjQXBSN3VocTVnVC9zWGZieVFrSGsvSEorMWY5T1ZXb000VWwy?=
 =?utf-8?B?UFZabm03ZktBLytCR1gwaWtRclc3UmNIRElMVHhoQWRNZTlHYnFFZEM1L0VY?=
 =?utf-8?B?ZmV6TG9uUHl4NkhTUUlPdmE3Y0xGUzJIQVVNVFdyY3ZyUVd1SnNVc05yRFh0?=
 =?utf-8?B?dnc3RzIvbzlSNFhnYkpSVjVMTDk2by8rVmdLSUg0TkJPVUgyMjhGblBFQThr?=
 =?utf-8?B?ck1TZ0VnNGhLcGxsWklUdEl1RWZodmRMd2VQREFPSFliZGE2Wm5aY3dXZWxR?=
 =?utf-8?B?RUJZTlJ5SnRBcENSZDkvNWo2UC9hbGJqSmxkKzd6aktzWURIT3RoS0hrTmYy?=
 =?utf-8?B?SWEyQTNzc2hkanVnNmlxTUJScGxPNHVQSElSVjh1ZlVVVHhOVjVOSHl5ak81?=
 =?utf-8?B?SkxyS29zVForckRDN1pBYytBNUluQ3NNc2ZUbk1GRnRQc2RLTE90dWxSVlBa?=
 =?utf-8?B?V25pZUtOcUFuYnVFZVR0dVlpUVFlelFDZ1pEUmtDR05mL1BraGlJRVhDZ1NC?=
 =?utf-8?B?VlFXK3FSNC9EQjgxaHE3NlpNTUxFZFpmODJUMHhTcnVSZ3RGSEpoRHNjN1Bn?=
 =?utf-8?B?VHhMRVdVMDBnUGZUdWxJZTRWVW1FYzFIdHhxWUlUb2RvakFpMEw0a2ZWdXFY?=
 =?utf-8?B?ZUlnS1ZUR2taM3YrREJOcVhMVjB4TjduMDRWNk9PTkxZMzFFbTd1Q1pTdEYr?=
 =?utf-8?B?N2N1MDNxSzhSSFA5RTJOa0syTmxyRitNR3VDbDNlUmZXKzkrMnl2cjJSK2xz?=
 =?utf-8?B?WlRjc1RrNDBHbGl4RTFYS242d2taZXgxZEl2Yzk0bThXTjBQblhMODA2ei8w?=
 =?utf-8?B?eWNESUFUWlpRTVhoM1lzQTQxT0VlQnk0a2RBcXRId3BuMUJCcDVIU3hrK1JI?=
 =?utf-8?B?TzFmbDBHYy9OU2dFUWV6SHJVNXBCL0NrNFdxWTRicUwydUp0ZjlUVnAxMGtW?=
 =?utf-8?B?T3lDaFZYeHZMNmhKbks0ZERCR1l5amM5dmp2aWJucGVrSkFoK2pGdVJPZ29G?=
 =?utf-8?B?VUtYand2eU0yNzEwdG9mazVUN3dIMjhvSHdkV2VidkgzSVVicHdzbTBwNXVF?=
 =?utf-8?B?UUJnL01FUkIxZ0JPRWZkc3BmZjFhVVpzaGZoK1lZdVc5aTRyWlhvS1g1bHpy?=
 =?utf-8?B?clNVVUFpbHZTRlBWc24rQ2xNTjBHRUpHS1IreWVXNVQ2ME8xMFV1bW16NDEv?=
 =?utf-8?B?M09hdzU2emZ1OTdaWENwTVhLVmNDajJEUEI2WmUvSE9IWHByeFBFOXhGSG5p?=
 =?utf-8?Q?atbE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:13.1332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16acd02-92c1-44e3-6b98-08de514b794a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 97d747e206..c66c452737 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,8 +626,13 @@ config FSL_IMX8MP_EVK
     depends on TCG
     select FSL_IMX8MP
 
+config ARM_SMMUV3_ACCEL
+    bool
+    depends on ARM_SMMUV3
+
 config ARM_SMMUV3
     bool
+    select ARM_SMMUV3_ACCEL if IOMMUFD
 
 config FSL_IMX6UL
     bool
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
index 985dfb345f..95d44f81ed 100644
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


