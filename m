Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F36C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRu-0001um-Rt; Wed, 21 Jan 2026 12:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRf-0000vT-Qi; Wed, 21 Jan 2026 12:56:46 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRe-0001O8-7u; Wed, 21 Jan 2026 12:56:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAEJssLzc1sHan4+TzIQ7mxwn5KdLi4cxfWjIxL5QLCIQO4/lYopjKNKE3w8dFhRZQS9Xk0J1gCbPSQqIfPuDGqNAzXJxG9L9ySBr//uhd5RpVIipg2BfeHHzmcf6QQtAj6fZ/CE0n+O8vd4Rq2LxPYNut57uxuIbCrVKwX9MMl2zZj+xMEcP+xRXglcM6XcVeq9ltql8kKsoR1K/WBBtRlmGPWk2JVRa8lEt36Jtu+klXeVkPqtyYpqP4bpl8I9DVUjro7uE9hTyVwobZALQsDLs6WgiGBVWAOEXxNkVKiWu8b4inf4CiQYp+MTwu54yFD9MxxHcF6jWJ9/Eg2bXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGygZWjuGNmSVyIpY0rL/hSCtcCF99RHSSCA+KqHfWg=;
 b=nAlCkQNzcJypgFen10WvNedRW/g/eVmxrVaROjZ0RcvNPJcYB8h75YGCLlEf1vdUxHH4oxFFRNrllSG0DQn7sbGFFjguoZxiwootV80hpMcKrWsBabBZIWbwvk6YESOg/IOB9pSTvRpjzR0mT4P0S9zfOCfDeyMNunb0w5Pss4DYtDO4Tviw3UgkF/udKXTumwYMCTDFV1UZnwLfLPW6BYPaCxJuOD8FI2XuyHzbENwDmKj5XWDgClYOmWL3mwhE8kJ8BWeyfY1mcMyev3BU2V+ExmE+OCencEfvxhuc4DHjKI77gN0+hdddQf5EpeUm7H4K47BvMPpdnhSMLcajWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGygZWjuGNmSVyIpY0rL/hSCtcCF99RHSSCA+KqHfWg=;
 b=YPuA/hCaY9ifgRF06roFJCqKcpKEVFQU3rBFGMVBhgVK/ZkA8hqp/nOBJ0bmwZ0vmVgyXDoN6u/cIm9sXZTN/yH0R2wtGQ9jrZRRguHGuq+dqTBX177R5e3DeJg4Rt1pr8cWJJx+MZrtPoXn4zI4BZUfFQa5wO/MDdLEVo6S9ZyIcEmDguCYFdujJi9dSllPmFF732AZKEbFuSIiZ7d7OZ8esOgC2IkuZpqhllK3sU7GPmI7Qhog1yZsXngpfmzViUMrQmEGEKLuQGUe3cea41lH4+Tm08RKHTaGiGnsfKQfPpumu6ENoSlEoTGHQcxa+woxo22IywRySNXt5xJbbA==
Received: from SJ0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:2c0::8)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Wed, 21 Jan
 2026 17:56:35 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6a) by SJ0PR13CA0003.outlook.office365.com
 (2603:10b6:a03:2c0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.2 via Frontend Transport; Wed,
 21 Jan 2026 17:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:17 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 15/37] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
Date: Wed, 21 Jan 2026 17:52:20 +0000
Message-ID: <20260121175248.87649-16-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 697832a9-2b00-4834-6960-08de59166b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H39c+5kzlxit/G7C9bTJc38VrFJK8FhVlJ8SXKtw21DlyQlOfpmJ1EF9Ae5T?=
 =?us-ascii?Q?L3L1h5F5DsL/wxMuWDvntGiswFwgWpUes7TPMo0qKGYdU5Thc+OPbYKFxnhF?=
 =?us-ascii?Q?FzOKDHJSPg1+G3vbPoxCB9CQO2TBzOE3pMovzwS+te6dXt3sjDePPJ0BRC6P?=
 =?us-ascii?Q?8Ms2BKEtRHrhleNiEjuPVJmH1At5VBQ9403ymLp5319UbrqzbrSRb4Ml+bAW?=
 =?us-ascii?Q?6RwHkYBP947FiEsR9wDCwTABnu/d+mkkeYnfDa/QZZBQxKGW7oRvQSk/E8OX?=
 =?us-ascii?Q?jV3gbSmOD/Da6NUGG1x/LH1dwkbYkgKM3bl3jRR2n6ntUlhhf+KZFRsH6b9n?=
 =?us-ascii?Q?VTJKcpJPGVxX1umuoa7RLYrzjyVFcvQVMgl0onqElcj8ZUXz3Dh+B+IAu4rl?=
 =?us-ascii?Q?4119LDiVVtLVIyA1gpWACHpxh+flvjkypxwdQprKi+ufzZk+GTwbC64RwlOK?=
 =?us-ascii?Q?m0iBc3vxzqVfz1QKFmew94EuFtO5cSMQI7CWGnjLrKWJQxXzugwTcUIPZbNq?=
 =?us-ascii?Q?3P0nR8Q4Ucb3brUqf8UPrpfQKl5FkazlaTutir23NJNZjOlQ6KvbDDKYD3op?=
 =?us-ascii?Q?ge4v+hZYaoRCREpQhYEg8wQi8ivBaFe3YnShAFl0vRhDlPIq9ASTBHoL5fQQ?=
 =?us-ascii?Q?PKMKgj1KWO7Xq1x7CheKXvuJZ/k7GWuuIjuhjq6GyAivF/9zjn58lfIqHydz?=
 =?us-ascii?Q?kxqPPkHeSTi2+DBZzrxFNK/gvBcNXl7aMhU7upmhDlbm5GX81KR/EKIQWpbE?=
 =?us-ascii?Q?7Yh5/WyooOvL1d+kCkTrUVFyXQmZmPYu9pqEc3wxCp2jUpnqEF6Djan903iK?=
 =?us-ascii?Q?/CJhW5VeiH4sDu03X1zXKnJHBivkjhqtZTT5fpDLUy/veV9CQMeSRLyMe5hB?=
 =?us-ascii?Q?/e1nONTmqca3ii/pyDmbWmEqQEhusNy2xwCXgp00Q/kLAofY+JA5mxcL6PAP?=
 =?us-ascii?Q?LMDqzU7NdJhfseb0hvpvMl8ECOYaeHIlylxAR+oZhoII3UtSm0h1j4KELCQA?=
 =?us-ascii?Q?+1TbJ7LeiVqHa6oRjZWjIwErWzCQJ4Y/QUEilWRJtf5EyqnrbwP+Vp7sp2qy?=
 =?us-ascii?Q?p9EB7CdXwk2ozCs+qZCOiJ9ztiBog/yrHLLIOUL0v7gRE2IiKp3yJv6IIEcf?=
 =?us-ascii?Q?MBqtFu0A9LI18/SD6tCtfFAlNFF5Sjfj4flhNNg70OQNKsRpjbFQdPo1WgCE?=
 =?us-ascii?Q?nyX/6k5bbANk+z2yciIFR3/Ws84pEZzF2+p0Jun9j0odGUTQlx8/rqoYrZg0?=
 =?us-ascii?Q?uo0BIkDYaKfL3zWwtU9+1JOdSoiCjnwFXw+4kXEhw3aTek697aQ2ZB4Q1WC3?=
 =?us-ascii?Q?u0V33KaIqyVnFJ3cqjOhMq/gkQYe16FUAlp3b5uc4NGktMsWdwtuNkKit/K7?=
 =?us-ascii?Q?JfavSp0ZJxEoH2yuMRSEx6vVBb25leHj6rGpD5PFahU+h20R2ZE8D1jktQWW?=
 =?us-ascii?Q?SE3rK1+FpA6VFqQrlHhpfYg5X2yqJQq0+x3LhfaBP9u7GXRClr93pw5uGuKw?=
 =?us-ascii?Q?Y+3sI9rQBieNFaJjyGaPHPrj5rfo2AKJFPiYOqakImj17dCUsRgbxzSTuB0M?=
 =?us-ascii?Q?oLf8pWCbCPC6qYSPan0wplYxbHBDtkRklFEpbUYuC/2lH1pQXwirEJY0Avoe?=
 =?us-ascii?Q?LoJ8lxE1YrEQPklOCf7RdHh9OPqlmZAtXzQGlJg0NOB5MdEb01rRL3nACIhw?=
 =?us-ascii?Q?0EuqXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:35.3994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697832a9-2b00-4834-6960-08de59166b23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

On guest reboot or on GBPA update, attach a nested HWPT based on the
GPBA.ABORT bit which either aborts all incoming transactions or bypasses
them.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  9 +++++++++
 hw/arm/smmuv3.c       |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 877b7e0e17..c125974d12 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -499,6 +499,42 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
+/* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+    uint32_t hwpt_id;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
+                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
+            error_report_err(local_err);
+            local_err = NULL;
+            all_ok = false;
+        }
+    }
+    if (!all_ok) {
+        error_setg(errp, "Failed to attach all GBPA based HWPTs properly");
+    }
+    return all_ok;
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+     /* Attach a HWPT based on GBPA reset value */
+     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+}
+
 static void smmuv3_accel_as_init(SMMUv3State *s)
 {
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 4e20b646dc..c7ed4dce3a 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -46,6 +46,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -62,6 +64,13 @@ smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+static inline void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7e29284267..7a32afd800 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1600,6 +1600,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1887,6 +1888,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    smmuv3_accel_reset(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


