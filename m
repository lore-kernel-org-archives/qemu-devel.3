Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD5FC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRK-0000ND-BW; Wed, 21 Jan 2026 12:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQq-0008Ip-3w; Wed, 21 Jan 2026 12:55:59 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQo-00013n-6g; Wed, 21 Jan 2026 12:55:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQNlJ7eS//HsKFX6qWfiTP1R46/OSPZc+PMo1E6X9Khb7Ud18zXK3cy6MYIeVc4rBph5O+zIjZOaHUKJ8PHOylgTQrG9Y85iH5depOvcLZlsuJiAiQl43klSOhStKIO+LXZ64UKqVHU0Cjcf5VodissNLwBPTfclwIsoeBvd/hYm5G2DnMvVwVGdVm1fLm6YrGoCYCKZ8VNdO1WsCjsi/EeU5ilGR4zZqDwdxMe4RNMlO1CiRN/Ze8UBuV5z/j/rJAizBKZfBIQI9OQIhj63yHFO8yKjl+MpHRhkvGpILWkfheGB5PcQ0BD6uYEG2EoeEV9rgQtwMbEYJMFdVXeUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt9dNFuCiu8mQx1gnk/QJZVIThykWJ8fjsq3vzqy0Tg=;
 b=Kr2UhQd//yuTMpuAN0xf67ga3vnYL4+d0jCyVcaE/D9WhGBV+44Q/QV3gC64nSlQOafBAc/c51hj1PuR/4jx7pKq+/i8KuxFHDXD1oaKrtldM5Uyt3ipgDSCUKLLEhTmD0s5LHXmBmc03+K8s824lmj9ZyVGRoWbMTbCx9E441oHEek0rQI+ny9IiMZYo/TXyKqxFxleGMBKyBo/3eCx7dOFQwxQBuUYfmyfqig7WAp1vRo0vurbTSAEyFFzIh9D+ejahWjBT48LFiItMdcDuT0XznalFJQw4kwhBIVYs4GIKAsQmQNjfOAbl/EJyEzAV0RnxP/sxxKmvP9uaRzX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt9dNFuCiu8mQx1gnk/QJZVIThykWJ8fjsq3vzqy0Tg=;
 b=DJXUzlJXiws6WgQ3ar3CXNAymdqVsQw/Dv/ZNkoNwu3daSadVmKYKV2pCx9ylsZl/mJpkzFY+BgQg/bbYS6DcRSodlJIvi7XKOnNt6bYBEdbDTn2QH+r9y/qi8NR/GJ9TvlLSt4BEZqrc++EpPlEk39ao/JLfzEu00uOsb+7e082Y5SJVhvEHN0dach1Hnw5XF2HE1ua4Gd+bs8IliqzsTlYIoqSbB/OFOZvKEY0ASXEzJh//AbUhmMowmeYsRBeZsn6zFK489atW2WGw2W5NNz2ft7lVFNpGVZhXg3c7z/eMp1n68y2hD5Hik4iLsMfxXY63WVtM13ZOLsRr8Qbsw==
Received: from MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::24)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:55:44 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::5e) by MN0P220CA0030.outlook.office365.com
 (2603:10b6:208:52e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:19 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:14 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 05/37] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Wed, 21 Jan 2026 17:52:10 +0000
Message-ID: <20260121175248.87649-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc1cbf9-33ac-47fe-ba91-08de59164c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVNCcnVwL21NY0FpWnNLdDJpcHlHYWtnZEhFMVZtc0Z1dWYrbk1vZWgrbVhw?=
 =?utf-8?B?aHdsT2xXNGlQSkVRczFsejN2S2RkTldtQjhEMGlhL1dWamJZWWZZM3ZXMWhp?=
 =?utf-8?B?SXRTMEdmbmp1ZkRmOHRiUVl3UE9HeFA5aHl3dDNoUklmVmRFb2VSYW9TNW5R?=
 =?utf-8?B?SFF4a3BnNXd2R2lGazhZaGV4OFgyM1FCc0ZUbnpNejBoMWE2TUNzVTJBQmM2?=
 =?utf-8?B?UGRObWlNdEd6clBBVkhYa1VtMFFiYlJ4S3VFYnl6Q1dMY3lidUhzUmhvZ2hB?=
 =?utf-8?B?Q3gweVZVNnBKRXBZaXFienNBMDQvR3UxS2UrVzZHY0h5dG4vYTZ5K3owOVZ0?=
 =?utf-8?B?dUJOdzRvL0s4M2FPVU01RlhCdW1XZDljN3Z3WUpRd3dlN0tvR2hQdUorZldF?=
 =?utf-8?B?L0JRcXN2WnptcEtROC9CNHE1VnJvL090RGRncVJRN1JJRlpyVlZiMU5CQnp5?=
 =?utf-8?B?Z3NCN0hIYm1Makx5WG90enFkZGxDZUM2cXRGRkN6dTY3bm01SHg0Nnh6Nlk4?=
 =?utf-8?B?clBXT2pNczFjZmJFQlB6T0pycS9XZTlBRytSN2ZLcjlCTEljMkY4TnEvK0RC?=
 =?utf-8?B?RFBoVWJZZUh5MHk5MitMYXVlZ0d5SkVMRVcrS1BGYy9kaURUWkd2dmhXSWwx?=
 =?utf-8?B?VUtrQVlYRUhkK0hmVnpUT2xVZ1BHUFVxdFhPN0h5T0tIK3FGYlhPU3hwc1l5?=
 =?utf-8?B?VC9BL2FYbDJUcytNY203bFBhd05YbTQvcHc3MmJUcitsTlZiTWpqZE1DbkIz?=
 =?utf-8?B?N3lza2UyK1Ewb0N1dFNQOUdUTXJCN1A5aHpCby92WTFyQXhadlZGM3d4WEpT?=
 =?utf-8?B?d3N6d0IyRHlBWGo3SGMzQlhGbDdVTWNjbEg0Zk9OeDkwd1NJVHZya1ZkOHI3?=
 =?utf-8?B?YUdUTWFnNXEvdzI2M0tWOFdqYmZjMUM2TGhxVzBoV0gwSkxvQjhZb0JrYytt?=
 =?utf-8?B?R21MbFpJNWV3c1o2T2FuQnZvS2hxMVpNc3lqU1lXTWpoU0c1WVJsQU5PTWVy?=
 =?utf-8?B?TCtNdDFIZThiNGlpZTFjbndiVEh5MVpuaHc1blAxM2xoOC9BUThKREhHYXhH?=
 =?utf-8?B?Z203ZHBIVFR5ZXBwbVNnOFhucHFtUmdRaUY2dGd3SklLYVFwZkc2VlE2b3Fo?=
 =?utf-8?B?NGhWckdaaVFkRWNpNitwcndqSDQwUDFMSWpPbTZQYVdrV25rMFdUZXp2YXor?=
 =?utf-8?B?WEdLVmtwbGFkSVg2THVhUks5NHZVUndFN0pMQlFrTGRwZlF3L1NaMDRhNFJM?=
 =?utf-8?B?YVNqMks4cnVPTVVyUEdXN0xvZlg0N2RTVXBSTE9mYkpVY1JFWW1yTUdiOElo?=
 =?utf-8?B?WmNPbVNjVXRidk5DZW5hRzB5aWJWTXh5VjZUVzJpMzBCU2t4L1NKcnFsRG1S?=
 =?utf-8?B?b0dqbHR4VVFGQytEaXRTRjB1WmJBVGl1b05HR2NVTkNiWFhtdHA1YkUrZTg1?=
 =?utf-8?B?TlBtVm1wdkh5YUc3OXhGMDZOWlVyR2p2My9vcGNNVkk1VHRVWVBiYzJrcVhq?=
 =?utf-8?B?MWJadXR4NWhpbmVBb1Rka2hpTFJiakNLTVZYaUp6RHJuZmtrRVkrcm56Q2c3?=
 =?utf-8?B?SUJhSFloelJRNi9wYnVCNG95M3UrNkl5cE1wNWFxaXk0MElwWUdPQ2R0b3p0?=
 =?utf-8?B?WDh2d2F4SnczOHU0RUVnNCtDSHRnOEF0b3Z3QWlabzVFbDV2eWhRRU5oRncx?=
 =?utf-8?B?UHhLdlZELzF0VVBJZXBZZlk2dWNPeWlibWxaMTdIQ1hrK09NdnNjR3VzQWtL?=
 =?utf-8?B?VFZobDkwcjZrdU4vYTdmRFBGTHdQWWdOKzJxWW1NbWdUMTI3amMwVnE1VUZH?=
 =?utf-8?B?L3BwdEJERUhFMmlaTy96d1FFS2RPT1VwTzVsdTRnczRsZ1ZxL0xKejZtU3c1?=
 =?utf-8?B?UEJ1bFczeDhWWVdURmlSbnMzanFrSnR2WDROUEwzWWxCSndhRDRnNDRTaTNv?=
 =?utf-8?B?Ym81VEhDcE8zLzNQTCtFRkZRODRRRlI1dG9GYW9CZnNmbDM0bzlUMUdNTHJ5?=
 =?utf-8?B?TzIveXRFVXUyREdjdHR3Y2JNMWEwUHZXUEZvSkxwYmdIMVlsN1R1RW5sSEMx?=
 =?utf-8?B?YTNvekI5SW1uajNkR1Zad0NvYVNoRUlVQnA0am5GSXFIcjI1eVE4dDQzQlA2?=
 =?utf-8?B?RFJpRFdmY1hxcklnQk15NnpuZmVzc25rS212MHdNOENia0libk5KYUpTNDY3?=
 =?utf-8?B?TEhXTlpnTFk5cDJXeFV2ZzBtb2QyV1cyQUJBSm5TK2hQWVNJeTlRMitWdWQ3?=
 =?utf-8?B?T281alpvVDRLMkc5NEQ2dnhyYS9nPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:43.1467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc1cbf9-33ac-47fe-ba91-08de59164c0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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
Tested-by: Eric Auger <eric.auger@redhat.com>
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


