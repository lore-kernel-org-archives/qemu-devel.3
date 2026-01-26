Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5320DCF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5n-00073v-62; Mon, 26 Jan 2026 05:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5l-00073O-AS; Mon, 26 Jan 2026 05:45:09 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5j-0005V7-9y; Mon, 26 Jan 2026 05:45:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H60b0Hm97BGuMnHINy7ghTpXIUBWZ4COF9agQNjRGj3Gr0Vu/QWLoAr5ukQT3bP3+qJj+Du+fedOk4KM69uZOP5ba76LyRmsDMU7ttS+Bu4kBCjXzrcZCxYRh+YLPAOTQ76CGX+k6/nUd0CBxk+cFNJxTJjGf4jWKZpDFzNTG3W2QVARyyWD0qcGEN4uhg4LW4+ezw8t/uA/A6FTMq0PHJVTVAK4GWB4hifdL7yC65iHyweaHyXG6p3BTT3iMoIcxIZX5QiHB7tOaSURaQSZhIwtSH0Yr6fXsRBPIk4D7rNHCMKLhTyU7cTY0Jask4RDX27njXMBrHkOzpG+IK9ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt9dNFuCiu8mQx1gnk/QJZVIThykWJ8fjsq3vzqy0Tg=;
 b=dNZmNXSS1bjZz4HsiiRJdTp1Fi4CVUEur8x3j4TyRd1n+qSvy7dH3EuixmE7zAzdMvow2pjZn5W0rdjH6AFMgbtoCga9zbWprc1GW+7KIwdgG26f6F6Pe3yV1lKL1vFPqV0RjdEPmRcjzcWJlbFcvEMseSjXS4gkK+CLe+7JhIxPYJeHpo6OALVKGa+3ti5c9vhhwvghZVPPgnk3hHnJ/I4LCUB+g4LTAeXU5mD2RNxof0v8BwVzKuX2AZUuetkz88lcc5xycfIU1cqVuLKjIlIfHc19g6P7xJtQIEAFvNGf7KWSnf9L4AIRPveb7JGr9RoYr78xl5uVgbcrkcXX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt9dNFuCiu8mQx1gnk/QJZVIThykWJ8fjsq3vzqy0Tg=;
 b=amBNXZ5pI0LBktTQuLN0/egqvzhAU5EaR0jj3cDrKU+Zp5rTstx9FHKHx1IqFVfAjlkShhN5lJJvP7LEmQ97NIV0+0FM+J7pUn1kuT+CxHi3e2l3XuKXci1ShOyACuzrSfolL537MLypTB+Gujt8Nos4Fn3mtXJ1gYNtwvHx3zcRCf8dewuTn0e4/VYAM+IzO/y2CNB7ykFMj9gNqFoCZRXYK8Bft6ZmSxXQ29CX+stk+EUHAgeR1wYhK9Tpbae3hECJYMxuZ1WQ/wO7fYPshrzTzkNIlr1tn0B5lv3aNDApnyldEk5pIhNZJiYgVGjfG1MLUf+f7L5KzUayupvBnA==
Received: from PH3PEPF0000409A.namprd05.prod.outlook.com (2603:10b6:518:1::46)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:01 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH3PEPF0000409A.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.4 via Frontend Transport; Mon,
 26 Jan 2026 10:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:45:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:49 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:45 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 05/37] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Mon, 26 Jan 2026 10:43:02 +0000
Message-ID: <20260126104342.253965-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c0da49-42a2-4b3e-c7f6-08de5cc7f46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1k0MFRzWnFWVzBjVUtweHluZFNUNWlTUW1LbUg3NUUya1ZZdU83cWpYaXdO?=
 =?utf-8?B?M0JZNnBkc2ZHQ1VNbmlObEtHOVdYVGlCRDhJUkUwOGFFZXZhR1RpZDFJWEYy?=
 =?utf-8?B?cWtJTjVnS3NhMlNVNW0xNlRiQUJ5N2lSdnF2WTFkMkhObm5uRzNvUWJUK2pL?=
 =?utf-8?B?dXpJS25FYWhCUGxtNVBGcW9NWkdzdmF2K0pRbldzNFJza0FVMGVBRllwTmRX?=
 =?utf-8?B?RXBZMEtVa25oejZPaTRXcTJhcUtQV2t2ekZxM2tIcU00bmdsWXJ3bXlpOFJk?=
 =?utf-8?B?cTUvTEtXZmtxVkszY04rTzRPdWI4bXJtbUZsb1I5RTZqQmhmMENLQmF0U0ZT?=
 =?utf-8?B?aFcxaHNoNVNnL3FUa3VuQnhxQ3JpcnA3NXp1SElJSG9KRW03M1hyYnNodDdD?=
 =?utf-8?B?N0hsaVlQSHF2Z1lUb0c1OG5mWkhQN1dJQ3JMWkJSbWFNYTRwajB4ZFk2djY4?=
 =?utf-8?B?Q041SVA2Wm1rQ2ZGdzkvMGNURmpFNkR0bzhVMktVZDNWOEM0QytXTE43ZEhv?=
 =?utf-8?B?Z3dNekJEOU90RUJlTDZKeUVBOXBjbmRyRmV0OWJiRWM5U240a1ZBSkFVNnhS?=
 =?utf-8?B?ZEJDekovOHp4WjRmTWFaRzBLcFJaWE5nd2NZNnZTV0Q5RVk4NVBFVnVqWERX?=
 =?utf-8?B?Z3gxaUpmZlVnS2RUZW4wOWQxdjB5N1lhNjBNaGhzRjErZmRDWFdxT1FRRCsy?=
 =?utf-8?B?L2F4RXRKSGtOR04ydWhEVGtNNEFldHJ2MjJ4VURPbUt2Zm9iUVBMUU9WcHdP?=
 =?utf-8?B?YW1RZkVwL2VNOHkweG90NWR3V0VSVC8rUHNXSkNFUmJtMi8wRnJhYy94WGpJ?=
 =?utf-8?B?SjA1RitUaWpYWGI3UWdoSk9ON2s0SktnNTN3QVZoOFhNRkdNV3VoNXo3WFlq?=
 =?utf-8?B?TnJvcnRhVmNUUDFzbnRwN2RDRzdLUWRUZGRPa3B2ZkYrMmROVFByeVVzRzhB?=
 =?utf-8?B?VVpNbVBjWGpJSjdyNEFyWlVXNFowWHRhSjM0WmZNVVh6dGx0VG9XT1Fnd3hI?=
 =?utf-8?B?QUUxTE5sUGU3bklvS05BT0VMa2ZWQnVEaFJJUEU1ZlRMdDN6QkRlYXYwZitX?=
 =?utf-8?B?eDllNkVraHF0MUVyNC8wUnFFWHlPRENDQU1PemVEdWo4M2ZhL2liWGY1enBM?=
 =?utf-8?B?cVdlRjlvUzdOMnhlOEtWc1BXZVk1aklGYW1rN2p4bC9jNXlVdEx6YUZMcXlT?=
 =?utf-8?B?OTVNRTFwY3VOSW5xeE4xZGw4Yk5HU3NQdkpQQlVEN1Z3UE5zckdpSTJVa29I?=
 =?utf-8?B?K2MyRVUzdFUvY29oQVhmMSthYXlHTE1pNHUxaWVnbUVoQVpaMmFMaC9Hb212?=
 =?utf-8?B?N3lwd1p1VG1vR1dCeGFSK2tOMHFqSUlZYzZIcHo1VENRZnJ1TzVjZXJUeXI5?=
 =?utf-8?B?cmFPNFFzUExjVWxGbk1kYk1HK0tNR0FDb21YSzF5ZkVia2RoZEVYOU5JeTUx?=
 =?utf-8?B?aWtkMHBnbk9BQ0tmZ0xJSHZaV2Q2Tkcrc29aME1lNFE4Ym5YeWw4LzNlS1Bn?=
 =?utf-8?B?OVJ1cUdkL2k4VnBab0h3U2VvMDJuV25NREFQbWtlanpaYm9BVDhybFkwL0hr?=
 =?utf-8?B?L1hvREszZWVOajdZa1lZR1F1anNrM0RIc3h6RG9McWExTEEySHA4aFpWQjFJ?=
 =?utf-8?B?RUdjWjA4ZGoxaEprNEFGTmYvZ25ESWhoanRCc01VOHFONDdRT2Y1RU9rQkNn?=
 =?utf-8?B?bkczK1o5cUxKWmgzUm5Lc2xiTG1OcFlOVyt1c1IvQmMxbGlXdUN5eElaWnFq?=
 =?utf-8?B?U2pGRjZSbkQybkUwWTFwWE1vYUFWY3VjWlVoSXJPSTNNYkw2bkJMZzBJS0kv?=
 =?utf-8?B?ZVF5dkJYNkRVZi90dm03ZjZ3L1lad082MDM3Vks4aVRDK1VPeHdteHBCbkx1?=
 =?utf-8?B?MHR0R1FiQmY0Q0l4UW1hcU9RTGdENkZ5L1NsZGdRM1NTbTM2M2xlQmpNOC9N?=
 =?utf-8?B?UzBmTE9YVW1ZalBXd05ka05aUzNxaXZlTlR6V0Z0YksvcFRnNFlhSjlwQ3ha?=
 =?utf-8?B?bkU2M0d1a28zVGdURzdLaEtja1YwOVFBOVQ3TSt2ZG0vdmNFRDBCQmlkSHZM?=
 =?utf-8?B?OVhUU1ZhOXBQQnJvSEZOTWN3SVJVRUFCZVJMaVFPS1NzY2VSU0piQmhCTFBK?=
 =?utf-8?B?ZER2Sm1DTzlJVzgvbDZudEFSUlhXQ1dGckF3SXZ0cUVzWXFiNFQyOUtWN0Jl?=
 =?utf-8?B?bXhyUkY4d1BKb21ZWno5c2w1YmxuYWFkVjZXZnVFSEJNLzhUSVVZVkpFU2tp?=
 =?utf-8?B?NlpRM1cva0VrK3pBZUtQVmRrU0VBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:00.1912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c0da49-42a2-4b3e-c7f6-08de5cc7f46e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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


