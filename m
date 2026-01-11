Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE6FD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Xn-0006IG-CV; Sun, 11 Jan 2026 14:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xd-0006DN-Fg; Sun, 11 Jan 2026 14:56:02 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xb-0003pK-Ea; Sun, 11 Jan 2026 14:56:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5ORb3KgFBdwnPf1jKiPaOYRX/JQP26Ly8vro+exjauCajk9L/RKbjgr0QtnMGaVkPmhLtBVdnqjLlW9d4O3CVuoqL1twwtWV+BazM00F4E1tVMy7BpqsDmxbBfnacQRka11FEld/56BcvgJCjZq6EWWh4Mn+3XM5+xdmPrvobmWvf7QQiJfkYuazJgcbQMZoHaQ+YcMrxWUjuubYvuUXfo0S8qFL3zn+ht4lGSaS3VNyJaQSX/7cSnYdHdl34360ifBnDFItWoiOXFJ+hwku7M4WBljbaP15GIpTL9Kih2deZ2G/YiedfAaYhdCR3M9w5gfYpeHePV4INfdr9d9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNr4d8tCE+smPMLZQFtv5grSYEbppMHmTASWmeBCtLM=;
 b=p8Ted2eIp3JGpQ68W3SEzr+rtE0unZD9Wrkz1QDTL4nMFRcYxMtwD9b5BwQThJ/H8lLvilVWFzaJ1FHDJ3wyXXp6XYIeE300n2qLXhMVj3bM+DpBnZ6j9cfyLMB33wWpIvn7XAuyQ/BXr4yXrAfY+bmK/p6gyuJhlL++FEkWg9935Zye3yC9paxIF6scEsqMsLU5p674/T1l1w+2Guz05xtZoIeji7+5pOzOY4YEo5VjSmw8v44CUSKufZnIGs0xMIFtN2kCvWq7ykuWTYPYMlxGSU+zPhUdzFMQstebvXLbyyKUsJUjza+V4VieJ/pw7i0bBvOxv1UF/vAQlzmO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNr4d8tCE+smPMLZQFtv5grSYEbppMHmTASWmeBCtLM=;
 b=VgXEgXwMmk7RtoScirGaJ5ptEilvyB/oJBjZem/mBTGESAC4l/9tw7WTUigangvCeyKvsEcetYyycgAIPJ9xRZ6t29RHyDvniLJ4B8SPrjI0FxPp4NNf2uqmZp1Ed6bHZEYF6JyGG6I9d2A4auepzVNxQ/9XjGDWouMl2gnQt7d6I2VszBrQzxQiMDgyDCTx6aZB43pudOjg8KWE95O6TA58ZqKhkg38H6N906VMbD+rqcP4nFdq+SG0n7ZgycuQY/3B/HvJA2+QpHTLkSwQ5iJy3q4GLX3SoE05AtrC3hxwmDkHoOKjJKQHw1UcBnUb2ZF1IfaGbFmxc/so5N3X+g==
Received: from SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:55:53 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::dc) by SN7PR04CA0047.outlook.office365.com
 (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 19:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:55:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:51 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:47 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 02/36] hw/arm/smmu-common: Factor out common helper
 functions and export
Date: Sun, 11 Jan 2026 19:52:48 +0000
Message-ID: <20260111195508.106943-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 176dff15-f3be-4d52-4246-08de514b6cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TkOih8J4lho62cKN947Y35aYib/vcAtWgxCCvM90qthJ2jWjUX2aKUr3qPAl?=
 =?us-ascii?Q?ZFgyV3xtbTNDS4Hzj+On7XJ6Ztjo72raf8DDwntnaPwge0lzDWFJlFhZ4IFs?=
 =?us-ascii?Q?T5fPtzXjDC1VnmtONHKEt/Ttunqf6MpIrFrAZYui00dbpA5ECJ3Kc6E7qWq5?=
 =?us-ascii?Q?e/SxXtcJPlgTaYG6hvGB0iRJn5XuMm1e7P6goUN1UF5BPzXXgAg9wOxbhakN?=
 =?us-ascii?Q?sPB4gSIq7RHzp00wAgj2oaiK5x2d7DCaMNOLXbVMHVuvXe6hUMIA4K/jICm9?=
 =?us-ascii?Q?O46U29EpmRrmM62XHpxhxS6Azptv0Ys2r03RxRBj4OORhQki8Pl3bjctG1rB?=
 =?us-ascii?Q?O6KdVTRr/AQ+Kr6Z91vNq3m4AzZULoLhBiU47ZdMpvIHL1vsmgpPPKp5uh06?=
 =?us-ascii?Q?ms2LXcN8dnIrnjsU/XFwp5Vr8xHqPt5x+m2gSBWQnoJYyWXiGdpWyhLJ+pPc?=
 =?us-ascii?Q?CRLFjHL1n2IyiqvsaIOStJNq96c/cRmcuW0GV0xcjbmLVubxXO+Idp+hfqRw?=
 =?us-ascii?Q?e3UEib/m/x28p5iU3VOolL/IbFxuub8EUr+eg0DhJ9Mn6wEQxfhny5yQWXaj?=
 =?us-ascii?Q?vJmIKsZaotA8ExBcRTXnVelXRHOYooLzevdfpzGJXt4arZkIy2iJCuw5hH2S?=
 =?us-ascii?Q?4jrRDngiV64tHEa+6YwQlThx/RkHT5hJSvinOLo3wYYbAswyb/ges36/GHQp?=
 =?us-ascii?Q?NGMWxtVt3yl9SzCiZCpo/0xijqyNlbJ+2vORt5r5ffnS3hHj8ziLyVLhkMFM?=
 =?us-ascii?Q?VbIUX6n8zhT2M2e/wuzsYDS65Ek7EUIXipkNYP1LpjCzgEnhQKkRgsgMN7U3?=
 =?us-ascii?Q?dYPRmooyoptfbb0Ur9ec2EtXJbgP1bqGIsibg9kCmSxAywLqaXzezFtIcEO2?=
 =?us-ascii?Q?aK1k/UgMUyqmwoDyt7OpjRm0bFocrhs6xCfKIIJbnVYESlK4hlSpJKcRdhbA?=
 =?us-ascii?Q?MVuR6xFrZeUKJ7VsL4H3LbVv+NCv0qnwLaqsASxAC7BiVW6hP6kdoh8wU27S?=
 =?us-ascii?Q?mrrtYuwDNRAOyut5iUMOIY55fvUK+xgVk/RmXorKceJiqkDndosRtIa0d0tv?=
 =?us-ascii?Q?kzlaqVP4uZc57cDVKtPJJmDL4MSgkXbfBcbFjiFi9m4ZfMFnkF1h9xwB+FFU?=
 =?us-ascii?Q?tS4+jP60ohw9Lsrdv/m/uiv9MbGDyqsxIOJQMuSijZMG+dPm1p/fD0pNq4VO?=
 =?us-ascii?Q?5or6lnBgj+P95qaOLDSA0iFjcF3km5CxEFFPIoiLeJ1n5irjZJsHxl3hy8vm?=
 =?us-ascii?Q?XyjCbPw1MGu+yIGH0Ic675tn98gIDXf5CSu/xQNGz1w5p1UnekYjSYNXxpXz?=
 =?us-ascii?Q?rIe4TuVWwSI9u5+rdbFrVgT7I/mPrbzFSUcgI8gh0qWSuD1vXSbPGZ81gBav?=
 =?us-ascii?Q?Iv6h/Jhu2SPqrMCl6Xs+73R5dnMTV4VnY3+rYzppO+W92uJVNxo0Xcbg8ozC?=
 =?us-ascii?Q?nLC+eiFdLizCBzBOardOvPSg9yGYyUFaf9iAljrHBmKacnR8XNxCSqn7vn1l?=
 =?us-ascii?Q?F6swRzYVtWYzuZYL3ONEYIXnPECMKzumIuvW7rViCI9isUYES/sK7GAmPfhh?=
 =?us-ascii?Q?srUz2LzJtWHIOD4QfMU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:55:52.2041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176dff15-f3be-4d52-4246-08de514b6cd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Factor out common helper functions and export. Subsequent patches for
smmuv3 accel support will make use of this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 44 +++++++++++++++++++++---------------
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e1b77cc55f..8ae120c11e 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -847,12 +847,24 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
 {
-    SMMUState *s = opaque;
-    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
-    SMMUDevice *sdev;
     static unsigned int index;
+    g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
+                                            index++);
+    sdev->smmu = s;
+    sdev->bus = bus;
+    sdev->devfn = devfn;
+
+    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                             s->mrtypename, OBJECT(s), name, UINT64_MAX);
+    address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);
+    trace_smmu_add_mr(name);
+}
+
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
+{
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
 
     if (!sbus) {
         sbus = g_malloc0(sizeof(SMMUPciBus) +
@@ -861,23 +873,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
     }
 
+    return sbus;
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUDevice *sdev;
+
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
-        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
-
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
-
-        sdev->smmu = s;
-        sdev->bus = bus;
-        sdev->devfn = devfn;
-
-        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
-                                 s->mrtypename,
-                                 OBJECT(s), name, UINT64_MAX);
-        address_space_init(&sdev->as,
-                           MEMORY_REGION(&sdev->iommu), name);
-        trace_smmu_add_mr(name);
-        g_free(name);
+        smmu_init_sdev(s, sdev, bus, devfn);
     }
 
     return &sdev->as;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 48368c8e89..ed8c085538 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -180,6 +180,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
+/* Return the SMMUPciBus handle associated to a PCI bus */
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
+
+/* Initialize SMMUDevice handle associated to a SMMUPciBus */
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
+
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-- 
2.43.0


