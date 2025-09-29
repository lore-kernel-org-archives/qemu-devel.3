Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E14CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6o-0002Ze-QY; Mon, 29 Sep 2025 09:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6l-0002WQ-Km; Mon, 29 Sep 2025 09:40:03 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6O-0003Cp-SL; Mon, 29 Sep 2025 09:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOeBJPBiS/v6qqom1D3ignBnkKZe3xeD5IU0Is7vUpDj+wMHEQnDVUXw3ZYXUWwnVPF7n5wBOYZQS8Nnq29egOATIlgq5+wicraQpoEDpEenCSbzrv9sZIJ99bQrNXf5gK9y7Db5dj6p9fRIAvygFlfCdTDAOcc5ibCvaSU0c/T1Amq+oCX6xD+xpqpRFYPubdcmqTy1oNng5KdUUlGSbdDtkddR9Ms4Hu3F/V4kYoTMp0e4Y2Xl4V2OgsTTajgYB7aHdJ4cnlkiUWgxbEf87TaNPYUe0PLLO6eetzXn+aNn48Lu0Qx3P+HzPI17WOnXwoT29MgYrcQOxMoyLefaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piKo55anrTAQc5aI+2wwqg34kU7fXdvsTtdVf7Aajrw=;
 b=D7TTOd8kzfUuDl3S2pBFGOmyEIoUImlPCZy1JHvt22seB34BMHDtxqyAeUjpQR7OZ918uI5QRHF22B2h6w0X7aSkkw754Ri9lf+6RAdJxo0k9RjdOKvfh4uWxejk0s+rEzlg4zOGbS7UPjL5tdaF3ot/VkTnQZBjRdn6pYaF7J4iWqlL2nA2biMkibE1vSWcu0UJnFSLBeUQSQoCBpqkbEiu2+Pdi7a5fa/f0U4zBg0Q4JEUyLK3hXMOBfYPjF6ohi4Q8LKVWr5X3AwnOVHnlAqOIg5kMAO7TTHXCcYRL26dqVwt128PX1jCmLiCoCMLkGMC6hDZu1V/J2LgGkMP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piKo55anrTAQc5aI+2wwqg34kU7fXdvsTtdVf7Aajrw=;
 b=SN2N/kyGMM5BFlIr1X4n9UG0vvAMAg2JjNU38DmntH2BWuNsjCtFPmU9R2nqahiMusXk9BKbabAXY+xZAGMYvWL8tddLUvw+EUh11q5GBN74BxWPAJ1Y5aYMsVYEJx24FH2TqgKqehRiKJOr2PMO5LFx7cTWzUNdySayLInXNuFmmivwTicUHNVgl0xGjEFGYrrLGoE+XsXL0EYBf8ZwFTqLY1UgRRg89I4dxpDgf0s2M9peSZ8rzXZAMbBbaZEfj9SDMTbMqLzpUxjyMQUXYzv0dEpG64vN/tvCkf/RcXoaQGHTlkoesgylXq7yBE5WBIIyx0NaiVvD1+6TS2Ikvw==
Received: from CH2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:5a::38)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:39:30 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::60) by CH2PR08CA0028.outlook.office365.com
 (2603:10b6:610:5a::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:39:11 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 03/27] hw/arm/smmu-common: Factor out common helper
 functions and export
Date: Mon, 29 Sep 2025 14:36:19 +0100
Message-ID: <20250929133643.38961-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd6ea68-b088-43d7-8feb-08ddff5d9d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qTDd6Uil/qSM/k4a6xTzPoHZ/Q+mkMsSo0dYJ3JzC1HhZyrHPb845+mhIUdg?=
 =?us-ascii?Q?flGV7DYLDSTrli3YJeLvQn0GDNwu9KaDN2W6ZMD/z5Y94+q1+IIhMuu7WSO4?=
 =?us-ascii?Q?5QRD/KmoR+A8IQG/lBAr9ERyyenz05SdaODfqKtYX4jJgVEvk6nKByK5t6Eu?=
 =?us-ascii?Q?vNjiEXz/ygE9HKB+1LHFYOgi04X/CnheN0D1dpmNFgioAGTVuEwkwLHazpwC?=
 =?us-ascii?Q?Wx2aDzfGyi5UfdZScdq42L5bQumrBuCMQWK6WRWWH3jEr/duNVn3567doVLb?=
 =?us-ascii?Q?5AL1IadLB33YAhKPCSUARhvlcC8hodLxP/cjzw7xAsYv5rN1ji91emh/CGRf?=
 =?us-ascii?Q?7Co8goAwQ1qsARDIzUhhssI8MBSn5gQze7IKZZzHrup0AmQcVnoYQ5iYEvD9?=
 =?us-ascii?Q?KHiHsHrrK/kMiGVl8VL/Hv/hOSrqJi2FwjriSfglymfxgJav0gPWUWgwd3Se?=
 =?us-ascii?Q?Oa92IqBlZk/SPKa75E68kv7ydrF9SFFC5bZDWFSrCCs/NVvHaSjykCgC6UoW?=
 =?us-ascii?Q?rHdGheb2ew4wdAvSOBMqhnoxfwwl4ElvsAb8Qa+j0DUhMG/te0yl0bE2O64x?=
 =?us-ascii?Q?bj+fQW4I+u3A8x07aWpKKXmXShJKPm49i43W5x6zo82cj1ED2GnVAEPtBNjd?=
 =?us-ascii?Q?IWRsZH/reeyL4Ucne6ZQe57UGP9ksnRdM78ywkqT0xcfTK4AH5a8G61OzVnc?=
 =?us-ascii?Q?f8eUSKb1nPoRSn3g5fn/uLR001+LU1tYEAM2zPSkstbLbfaKwuBBSKd0uEDU?=
 =?us-ascii?Q?IVi6F/qfeLYZF8kh97+v7meUL6GCW7tQFWFtsyD2ADJwqYxqSfzu7t/66ygM?=
 =?us-ascii?Q?1SazUo1kpZoVLZBoWcS0Lvx+QXQx4+3Y/0/5jUOeubCg0AEhkk1MgK6ChsKh?=
 =?us-ascii?Q?6qkZefmiI+kUQmWEo7JnyaQzI6K1zr3QICwAHL5Y55JLhMlEmLcrA0sv/LQQ?=
 =?us-ascii?Q?PjRH/UpH5OkLKxuMdfTIH7TF3/SUpwQdQO0FGcB/1Dwwk6lZBq6rbvggpEBI?=
 =?us-ascii?Q?AsTS3LrQfSdoC52HhlKyI3mHzx1QR0DgvWch19CVkRG85tZajUnz6P4gpNS8?=
 =?us-ascii?Q?5pcmcUF9oXsq+Po8dqm2DaB9tj88BV1qYRK1ljJvUMfHXFsYbnwZFSVMOuc7?=
 =?us-ascii?Q?Ih+/ec62HP8+/1irfxCCC1Ryf4ca56gHeDeC51HUlYFLfO3x31cvcarbh2+j?=
 =?us-ascii?Q?bpZ2TDjy9KjHjX5MxfYGSFQQq6zzuDqgQo52WkmaHFZ4KwqGEmt+cG5GUOBR?=
 =?us-ascii?Q?a6Va+iiqKeIdg833mfi3twqw+UgsjTqn2iYsGwgdp4dQ964DnJA8/OBV+5yc?=
 =?us-ascii?Q?42TyRVDZs10mkH12UFwF+xw5b5ZwxgNUof5fEBDbr/wTcsOckZRRxswD45P0?=
 =?us-ascii?Q?wlZPU/rnUHw3TZCBDncgZ6lJp/fwdzyFpD20ue7ee2PVKN+ImW3JLELLO9W7?=
 =?us-ascii?Q?Hx9/WBnJugRRJ3hPSyLd2BIKzhwOPG+QAQovP4eSGvnKvY/QmuEHur/A2mcg?=
 =?us-ascii?Q?2cdz5R2K/JkUSZGkH9EHOl9h2Ib8xBQwzLy9xPvSgs3oRwXcFOCXCk/yzpDP?=
 =?us-ascii?Q?goJolh0tlc74TTXuehk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:29.5697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd6ea68-b088-43d7-8feb-08ddff5d9d93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Subsequent patches for smmuv3 accel support will make use of this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 44 +++++++++++++++++++++---------------
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a7612184..59d6147ec9 100644
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
index 80d0fecfde..c6f899e403 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -180,6 +180,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
+/* Return the SMMUPciBus handle associated to a PCI bus */
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
+
+/* Initialize SMMUDevice handle associated to a SMMUPCIBus */
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
+
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-- 
2.43.0


