Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DCACF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7u-0001wS-Ko; Mon, 26 Jan 2026 05:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6x-0007rv-UU; Mon, 26 Jan 2026 05:46:29 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6p-0005be-9M; Mon, 26 Jan 2026 05:46:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni371AmqvBbrajbvUTBQC7XCY55hXDazdMf20W5dyQU9vdTpnlWHi2YW8HIPQAMZA3GX+qSfUrMCWJZpQ6gcXYxQkbq1U05e0ISQzYcdXP4OP1YhnJFb5g5w+JL89pMi58Tsim0r1GnB0OR35R0Np1bXyTdIAg0u7Tkf3z7y4vrQPYFX477KHK8O5Tt1xcuZdolPYWinjfdlFZPgj68oJ92T0eZokTRlgVrUrjFSGHQVBO+XLVzONE2uTPiU+h663YpaZ/a1bIcr1wQz8Cfp2dE2a2F48EfDnTjNTQ+nyC//2jsbwKALev+5MZYI4tWRjarN06yQohwUGcCKOEShwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3X14qvreyiCNTcEpkEHgyfxpvTPNGi7wM3/BjAnLug=;
 b=AE613yYdr+7LMajWqRqpyVxPyPUAhBocnTc1zeLhaLSfhRSiVFkjiSLlWxqd9kMjJFNFHp5m9FBbx4JSsROZrzq3giBjs4IfLQhu73tgoC8eD/At4AjwRJiuYgDetY64/zpmZfPT44yfvtZexbLnwbbU/66lq2NsAfNxJXyfz2xblDR0JHm4TdJHfcuOeejnCfGxKSEvFpdTUB6brUPcO+xKhuYwDgYyxeX8XaFy8m35sBNX7VUHoLdFWHMsaLC6PRDarS4Ewy45kUl11Q89wMFem8Drdocyu/9nhL3LdF+mWHpEz4JTNNDaqZ/RCpFYqhTHXOLitbWSt00UBnSpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3X14qvreyiCNTcEpkEHgyfxpvTPNGi7wM3/BjAnLug=;
 b=XXMC+tJh7XwJ+j+3PZlVU65F4TzaCdK9VwV6fePuUbbmH/cCYv3/MTHpSCKovwhWGG5cqEF25/xbvRWZ8fVXUdpaqgj7q/Oa6U6fBOScks4mQxzzoKaq+DnyAmjRpoPLECYRLqC5fimsZX19aQftVJUODwoU+lHFkl7wo6WUaP84uS9CqZoCawKAellOuU23J7FrNMX77kJyrqmyoHq+ZRHHst4OS7rGJirren3Zg/AXk7sms94m1mVJ5pK1kCAf3yLpUef2X7zhVw/naOOzHH+hY1R465AK1bYGfKwP0S5PEbFgmIzT6rolEOW+5zZMPIuU/EeBJHcjyOwPDzWUfw==
Received: from MN2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:208:236::31)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 10:46:06 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::74) by MN2PR05CA0062.outlook.office365.com
 (2603:10b6:208:236::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 10:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:49 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 17/37] hw/arm/smmuv3-accel: Implement get_msi_direct_gpa
 callback
Date: Mon, 26 Jan 2026 10:43:14 +0000
Message-ID: <20260126104342.253965-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2be45e-2a7e-40e7-3235-08de5cc81bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z3FN9r5/XsbkXIFqN5NnpXA3aKqBXAAmOru0+kaU0nHonX9eh1rsE1yt+Wgd?=
 =?us-ascii?Q?o/Gus+53SR1wngn9qu7uA6Sfx4toyz8Z1cOw5B8D2TCFre5XnnVOHfqVsvOm?=
 =?us-ascii?Q?sQIoo5pHichmqwOY4puwcT6tWNWfYz71m/tRvtW+xgfFORC8SyaiyCs294rP?=
 =?us-ascii?Q?BTE/gc4jAtHJ89epHWXI/FqlYp1GAW5cVe16IAqM8IE5fQ9ggEJs/flqXw71?=
 =?us-ascii?Q?pu+2w49qNfzri056l3tsFxw6wVpUMcD2ATRfjhk+xrHi7ZOo2Qf00nkNDQJT?=
 =?us-ascii?Q?QbDAIX9xn4SMlkyDXruCPsPxndQ2s3Pm0hxUPVRQGNhCkXsAH7Mt02E63zSG?=
 =?us-ascii?Q?OAKTEVB6ysZMecdCp4BZfqfgfbcLxc/oy0u1++hLH0MP33m7dSAr2p/uOPos?=
 =?us-ascii?Q?tetrzBmuPc5ie4Z1lUeJT+iQp2/njoqm86a84wzFObzBLn4r5jIHK4NLvg2G?=
 =?us-ascii?Q?k/qh8mX3anspVbH55WFzMrInt15eABi15MGnryk9L4JhACUA630AWQ0bUxEL?=
 =?us-ascii?Q?zG7yc+Zr43gYHlnK9DJsSKZjnTpEhZj+EXgjERxaViILOKd0Uzdjg0bEecIZ?=
 =?us-ascii?Q?BqI8EeQbrigIPAFOC1XEMNz1X9zIWdv/bVzcOFSVnXfN8qJMTJk7aRlUGBv5?=
 =?us-ascii?Q?Yw4xnns2BZKwvRvMiaYbxsZTvQwlTbc3MdwQD0cNDNcVqvgWqc5jB2vvRMMC?=
 =?us-ascii?Q?Ue/EiacAsrdER0fvRfJ40d+51RFbsQ+TGf9/kInAvL17hpU6SSUpoCbFY75i?=
 =?us-ascii?Q?+FNVg2LAUoW3DYt/6QRn4EL/i8IhnZwXIgbsciqR7tL0CeKsSeZ2O+ocGvXs?=
 =?us-ascii?Q?X6TbmC/lA7boKdfjmf312HCKtSUa53FXJ+q4QjLK1sneQcf8TNahLpP4kYle?=
 =?us-ascii?Q?XJyLqXvg1qGbjyO/LnGEHU9N0/+1Di9z8HsQQfTGaw3aJQTJJK+iEs9WEITG?=
 =?us-ascii?Q?ZaZ2sn+Pkp1Yde25qyxzrcbRvKGFGAECJ3ujrqZqYzXSDV1p3Bed4BuK3P+R?=
 =?us-ascii?Q?XDh0fzNk4hRAzC+n/a0ybFTKIcTGrvwkampQDo4B8cIEKCvFf73HXo3CkXKy?=
 =?us-ascii?Q?EXFcrl/gF+s0RMf3OsZIexMskNCVcY2WhIuIv8/e135P3CK7HP5oYwGfSJIv?=
 =?us-ascii?Q?ueDEkViAv2QE0n8ZEb83v3dDY+Icvlm8Y61a+CDNV5jJ3sJz7uzVidV2mLxA?=
 =?us-ascii?Q?9S43Oqmv25thfuVGPDDvdSpqP9uxx/gj2ceMTqgs09I49kcQXHIpBY62poAv?=
 =?us-ascii?Q?wao/qTpXA4kQ8n5UN9oOY58iQV/FZQUKr9vseFcJD+Q5ckAITtDYYv3ABYOY?=
 =?us-ascii?Q?Zo3Xe3yJhHi16QhdTFUifgDc3mUYPYc5t3fp5LAuIA10ievnRgbbDcQ9mfXI?=
 =?us-ascii?Q?RwTN4/e7dW2nSKzEvAKk5KrVw+gvGSbTBrclZevs+klYvHXWeuhLfqZrQ7no?=
 =?us-ascii?Q?YgXFdbbORTbUvzHROpeGokWpGc33pwsgN/jmlMDOTwuUaRK0n7Ec1/aIpado?=
 =?us-ascii?Q?0aBA6KhqdPIz07/TF959+DA4cB7f8F0JwPtg6Y2XafjWNJfO8p42AwmIUEV5?=
 =?us-ascii?Q?6I0uuNtNuzQPbenJRHnHgRhj5/qXl4BXWWp0gMR48ZhuWZKWxhVuzRjSnrSD?=
 =?us-ascii?Q?v7HXgiSKyL0b4TY8kbBT7Z3YpnSQIAx4Y4m8cqAO68y+q8UIByZSdP7V+mnK?=
 =?us-ascii?Q?AoWk5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:06.0132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2be45e-2a7e-40e7-3235-08de5cc81bc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
translation (guest Stage-1, host Stage-2). In this mode, the guest Stage-1
tables are programmed directly into hardware, and QEMU must not attempt to
walk them for translation, as doing so is not reliably safe. For vfio-pci
endpoints behind such a vSMMU, the only translation QEMU needs to perform
is for the MSI doorbell used during KVM MSI setup.

Implement the callback so that kvm_arch_fixup_msi_route() can retrieve the
MSI doorbell GPA directly, instead of attempting a software walk of the
guest translation tables.

Also introduce an SMMUv3 device property to carry the MSI doorbell GPA.
This property will be set by the virt machine in a subsequent patch.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 10 ++++++++++
 hw/arm/smmuv3.c         |  2 ++
 include/hw/arm/smmuv3.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c125974d12..c6ee123cdf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -393,6 +393,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    g_assert(s->msi_gpa);
+    return s->msi_gpa;
+}
+
 /*
  * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
  * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
@@ -497,6 +506,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7a32afd800..6ed9914b1e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* GPA of MSI doorbell, for SMMUv3 accel use. */
+    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e54ece2d38..5616a8a2be 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -67,6 +67,7 @@ struct SMMUv3State {
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
     struct SMMUv3AccelState *s_accel;
+    uint64_t msi_gpa;
 };
 
 typedef enum {
-- 
2.43.0


