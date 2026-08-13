Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC18C5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuV9z-0006Ml-5k; Thu, 13 Aug 2026 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9k-0006Jx-Qp; Thu, 13 Aug 2026 09:07:38 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9j-0005GY-6Q; Thu, 13 Aug 2026 09:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9XHMkJMIYTHFBer/K/25NHZNKST2OzxTXnBSjRw+MuaKZvaH6z7nyIVup86Da+1Z+FRqnuWO4WlnGKXB2J9Zewiv7A5GFqBnuycz0Nr4fU5waX9WdhZGP+wS8t78FQXFN51SvxJBxV7nQhkoZ15oFByPr31tuaNOncK/rbTFOCjwEXkXdC0E86T+1/YPc1mBEp+zi6Wxe6UUwmVtqdIWq7H43VfSTd1HXhh3LelwsnVTUkNOMwe8MuF1MzH1+uFdV93oofjs5s/m1gbK8RV+zryPYdBJbzXBmRHh3AmEmBJkxMAVtU6ATHg9iZwdPfbBJygEUjypiWs0EzObzfPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkas+geyN3YOn8nI1EGbea1yVInp1OTKw3lunlAlQZY=;
 b=a2wvrABRm64Uew4+4haa6X3mQXyOkXqYtm4am9Rqn3bOs2d+EfqdN61zdUKRU8bmgOGlKaT7yUNLBw3h7hv+3FS8JJg18q0bLYjHMcycDEh8s+TsirrQ9gVAPLr/WTt8XLHeb0KnvhqTTL7bP4GiVVIB6d2XYmL0vlP0+t2COM5UG2ocfT0vDuneBofABMIiPINzXeJ1uRz6ahRZ3Fl31uyu0cwHNXpM3/habxxSQdopSz5UQbxanuuBeJz4QiOdzyQr2VbdC2JNifQI4ilfzv2ZTBfkohzeV7YtQuPuATBJhDwpm8ETTYbCQnAuHyiSrFdV3kBN0nodI2jnH0drCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkas+geyN3YOn8nI1EGbea1yVInp1OTKw3lunlAlQZY=;
 b=gLOOXX7uV4ejgBzhYfkB5pT3yIiDNPBCKkwATV12LtRJgBo/CxL5Yn1qWNDkqYvOnVcZMiLorIy3I4FLOq2VR7Ct9LdnwObxAjq+OW/7DqMlm7uDEqOCHohZc7cZQV1pk4mcJOTZvAu1GeqzXFtffvgT1K1SCXD1GVAUjixdt0NzBKwkVZwERtzoWNkuCANecd+MqduHOeR/QFq792WfK8YDLWuJPf/gYkBOAlDiPOM9HOWqhmXaaWOguakz1KaWm9Cw1YqoZFuXfe0tI7PEIfs0IAI0MFEe+7Q56aZngTiHlxHPjx3a99gWctEN158gH+/XifhwwI119RdeGSWGpw==
Received: from MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 13:07:23 +0000
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:07:19 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::73) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:06:56 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:06:50 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 02/10] hw/vfio/region: Add vfio_region_setup_with_ops()
Date: Thu, 13 Aug 2026 18:36:15 +0530
Message-ID: <20260813130623.2499506-3-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN0PR12MB6319:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 68942098-1615-4c16-7271-08def93bcd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: bdmSIa/2fl+EGwQncSqQwtNtDYgQAtKcsdBzQyxc45H329gsbK+yaNfST6lFWnbJ/+P42Lpf+uHbSkBWY77+zfVDnRVbiUAzhejTQuuuaGqZIK/SqBuaNTLDB97DzFufP5q44twIghRHBxr+LH/3ilw7zLsb4Z1yhD+qPUg9Z0ovwqOGYu6L5ipdSAgkrEI2O/SFQbmpUeIMfRaEPHp0MJieSConzPGdvQWW+Dg2AYPI26SjpBRvnw7zDWl+tA3ooVpOFft1OXlk7V+KQEWUwGhoNNuy53gaNGKW5omcuy9bn5K7u+SW684WEYKFBeDbpm2fdgYaUjXaaQl9XMwQAeG+d7TBB9Nal0N5zO/vOUrAKV7s6+H+NoYueOIl5HCcT+tVFAOBiLeaWx4/lQ8ecaxp6TIsdQH2DOAVX1OcehzN+HqppjyLRoQbVhgWTToun57LtFpS+eqDX+V3MVcvyZeQCex88+h3U3xmoJyigNEGnYjfEn4YAYAV7WwfiKh9bIBfBCSmQu+4BhBO8Mdp0BAlHTjf7XsUnxttuO0BpauMqSTAKCJ75B0N1/y56FO3+BhlgoBIeT3CRYg2dHJgnfNbea5nYWTEbqvMgQoevFbxZ5KMTr29TXCQWiNEFIa88RBfQpcQn3lffNEs32yrQu+J8P+td0x3D3gGJlrSYEqesZb9nuRu0WpX9QN/8Sqk8jua02wkf6yL1CkQ7S78LhuMFsEBDZRxrB3KJGbHzbZg92BXwWSXdV/15H24nWFi
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yojOo1AExh8+8kQlSgsWK7hRmPSonX9zLSW7InQkACfeyIVBYW5UpjemlMmJQlK3diXrZXUPlWXVK5rE4KGmKTEfPi6KgHYFJQ4u7fJzAsIDYsDVJSZzbEBDC10SYJOdl31G+0cbDLYkLxVhK8awejJfvE8bFVxVcdBSH0aN8Ay1qJpwCTmXd0wnpHOuW28nNJqqLvkuaMwo1loGgFj44NET0JK43wXsMKPkqtK79AxbeN3LZDba7A6fHrcOuap9MthtaR3eAnts1PbYzGNsy08xWMmo+PsX76jDa7fv+lWxv8abQWA5Pw5j+kYP94LVYcnQW5jFwHv2XhNTYPT15910D5uyebehIjliAct47XvvwqJ+g9eRiwgxAjIGrKWHS8xRSW9BEGBt9GUOshZbx6JIr4PxClBxhLUpristku67pZ3yFMdA9UciZFMnqI4O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:17.9823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68942098-1615-4c16-7271-08def93bcd99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=mhonap@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device traps its HDM decoder block, so that region needs
custom MemoryRegionOps rather than the pass-through default. Split the
setup body out and let a caller supply the ops; NULL keeps the existing
behaviour.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/region.c      | 27 ++++++++++++++++++++++++---
 hw/vfio/vfio-region.h |  3 +++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 54ad11a6c8..21b54978b5 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -228,8 +228,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     return 0;
 }
 
-int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name, Error **errp)
+static int vfio_region_do_setup(Object *obj, VFIODevice *vbasedev,
+                                VFIORegion *region, int index, const char *name,
+                                const MemoryRegionOps *ops, Error **errp)
 {
     struct vfio_region_info *info = NULL;
     int ret;
@@ -249,7 +250,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
-        memory_region_init_io(region->mem, obj, &vfio_region_ops,
+        memory_region_init_io(region->mem, obj, ops,
                               region, name, region->size);
 
         if (!vbasedev->no_mmap &&
@@ -273,6 +274,26 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     return 0;
 }
 
+int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
+                      int index, const char *name, Error **errp)
+{
+    return vfio_region_do_setup(obj, vbasedev, region, index, name,
+                                &vfio_region_ops, errp);
+}
+
+/*
+ * Like vfio_region_setup() but traps the region through @ops instead of the
+ * default pass-through, so a caller can intercept accesses (the CXL HDM
+ * decoder block). A NULL @ops keeps the default.
+ */
+int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
+                               VFIORegion *region, int index, const char *name,
+                               const MemoryRegionOps *ops, Error **errp)
+{
+    return vfio_region_do_setup(obj, vbasedev, region, index, name,
+                                ops ? ops : &vfio_region_ops, errp);
+}
+
 static void vfio_subregion_unmap(VFIORegion *region, int index)
 {
     trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 58b236f113..8d5699013a 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -39,6 +39,9 @@ uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
+int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
+                               VFIORegion *region, int index, const char *name,
+                               const MemoryRegionOps *ops, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
-- 
2.25.1


