Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A5D3515E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rBU-0005h8-Pd; Wed, 01 Apr 2026 04:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w7rBP-0005gZ-Ks; Wed, 01 Apr 2026 04:44:15 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w7rBL-0000Q9-Sp; Wed, 01 Apr 2026 04:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ78UKi14UOL5CWDpLsmPkOqbFVBldQLGqQzaLfpYwo+NJC2mTXk4NZnsQkU/Z7+OeAL4JqGezCQeAR3jUnKubYL9DwIlMZPkruDIHuCNFVA1iR88/5VLg0uu5V1Em0rHYvQ/CemzygYjgkDYHAoA4Kd0E0fK1y+HPRis2pmUiF7kxp0HzKA7L9y07Xht9tlLRDu1LG4/GX5D2DXMADqYRRXZ7ZMRnywCNgoX2/WAway6EQQspzriY3aX6nsWwSYDZw9g81eJCRRgFNdzLHee6BmMkYzhTiOZuUJ0EcsL6/uP7AbY3ULFcGQG6LcJ/8qsm7tYXo+U52mJzBaEfRNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flW4oCEo2tGJkCiCyD3gLyYSkze2ET9BfrihRrrUKn0=;
 b=lUMu0v1jxdPaBG9nV+1L4jFsDkqS3RgC/TvhBv0tl29vS6u/yVi4TcnVilD8eKN1Ccq2xIUihWDNmqg+iDeMmUbSlP0JSloLpYmHpTnSgaNhZFzn1ZzbWHV84JjsnYJX8PXSREKu0Q9Ftb6FLIcvyNwS2CGcSQGC12LKy8lc4KimduVraKiK5QAHyXiqh+4OgQFsrfdFUwbHCANsFPwgrg2c7kEaigYvniGnrUV2hTYTNT6sx7WBFPlbV8IYFeMakStbIa1fS42H72CZ+clgFTDPKzs+DiZ75Di//YbhQNcdKJl6+WBakA462PhkwYFmjOwxxukMvG0cXWBM/loq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flW4oCEo2tGJkCiCyD3gLyYSkze2ET9BfrihRrrUKn0=;
 b=GNSliASPfZywq7SHck4R5ejqXhurJj69B2OAt4nidktUdsBQAZeEUQOxGY2RSMRfii7MsxKKHaB6ZydlybLsw/mPHOTIw6AtJ/B/GEMWCSfvQtCm6aN7xEV1cknplf/ZtbUnR07583oYkR/5vr8hSqDY9wLAZ6A813pjv9dlF56pJo3PUOWb3stoz2LMCLPaoiWx33u/r+oZmrOhGRFDQZaM7+ky8WVdcdT8xE7++qdklNs2QXpFSaAzyQCjYW+jRCidXxOpFbJh2z/f6RUoJ8ei+Kt1Ait8uu3DMaWhAxzIRf4WMhxsU4PgEic5qTl7iBFZIVTZp67IZntTFmYB4w==
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:44:03 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::b5) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 08:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 08:44:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 01:43:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 01:43:46 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <skolothumtho@nvidia.com>
Subject: [PATCH] hw/vfio/iommufd: Control dirty tracking for nesting parent
 HWPT
Date: Wed, 1 Apr 2026 09:41:33 +0100
Message-ID: <20260401084133.56266-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fd5bbb-e470-4958-81f6-08de8fcad376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: nvpn0+kSTah/ktHc8eY2U7cRpA/kcsMKQhQ4vYsGqc1C/mv83UYhUowc4imkuTb//o7fiz5kBEBke2465TTkYX8o1LFnnIFTIVDcdj+ix5YJxmBq7vsoSTwfzuqogClGUr/Mm26sgRQ8KZpiuFXTBQCB9uZInBhEhzC4xbPl6WbVWeSs2yU/XGGfRRueBGwePbzZQtzuVSed16ueV2LFj6gcxTRENnWjBfrFY5rcTZb8O6KJhUeC6ifI0tEwK2UcMysZWXJl9FOfQUyYvrLsOKRaokFxstKoK8d14fPYGrufYnztb5beyzMK/C3uIGrhBObIL5XDvJMsVIZwYdOUcq0P0aOHbJ69Qznt4j8UFEMjxXcl8Ol05/VFQ9/zXuOAiXo4ffQNU5D7hP6gqSnHvuXJ1rwIDVwzsSXggaUvsWnwXmxf9AAXFzxkzC3L1VQASvNXusTqnEZQEvYrDR81Z4TOkCFhyJ4jhpIdS+J8FlKdFMRuR4fkRJUIdrBILLtULLOw5jo03hskF+YZuQRuqg4YCnooL0hzj6+4x2751WJF9EqgeyAdCC/h9Q3gdc9Dy22SWTaCpuNT922HqEWszgtCmKjFbBT9oc+oYMlJAxKAvdLu1fWeptJ4Y1vXgKrFecXZ/reYV9Mn+HqF8oBnPqObIERse1pEKzygR7BpTboG6FqBt/99lK5Z3N54qWUyc61O4gW/06l6DhsmW2+dHHtzKpMj9bUJ6IIzf6a5Krq2h/JGsiKdYa2sjY6AzPb9zlzLXJmbIBQG6kdEWxZ8yA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZjbEVr0n9nmx9yjCojIC7spf9gJP1zOOQNjg4bOaMt2HHGqDpyJ4cQB+XCrKJxJgT75UhNUHp1qa3tiPQHyPGMtJp3K97kHzqnXZi1QLhgGILfJO68LHuPBJMBHtLfiuYUoYVcvhk0TIJirKE6i3rlmAWX9vp5KtyHm4mDAVnCEUi2uZQVjdJBK8AQXOTUPXPbybUbus7YFyM8+reZ6Zf7hbR0U54VURIWuyDSjhhUFCDA0t6dNQjd/j6aTvzti855JR7uRRJVQG7ONzRuEcwJpcr6Gi2P8IagVhaaSkPiQkgmCKvQH3NzOXlwhvz+z090Ql8WybNnpZBiejF8EszOG1t6ENbPOi5p8LlYYBRFc9qO4B4+i+2lqg7d76fYO9jjHJ/nATuXFM9MeWfXXGKWMlJeUmPcS894Aj7y2sK27A1rc7ZnmiqWaxifH98KLn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:44:02.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fd5bbb-e470-4958-81f6-08de8fcad376
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

QEMU smmuv3 accel does not support live migration yet, so dirty
tracking for the nesting parent HWPT is not useful.

Also, nested vIOMMU use cases can break on some platforms. For
example, SMMUv3 with HTTU may advertise dirty tracking capability,
but the kernel supports it only for stage-1. Requesting dirty
tracking for a nesting parent HWPT (stage-2) can fail.

Add a vIOMMU flag to explicitly request dirty tracking for the
nesting parent HWPT. For nested cases, dirty tracking is enabled
only when requested by the vIOMMU.

Non-nested cases and Intel vIOMMU keep the existing behavior.

Fixes: fc6dafb98cec ("hw/arm/smmuv3: Implement get_viommu_cap() callback")
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/core/iommu.h       |  2 ++
 include/hw/vfio/vfio-device.h |  1 +
 hw/i386/intel_iommu.c         |  7 +++++--
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             | 11 +++++++++--
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 86af315c15..cd59a367ce 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -21,6 +21,8 @@ enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
     VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
+    /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested use */
+    VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING = BIT_ULL(2),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006..a95c5bf503 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev);
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4924aa4375..5ec5ed82d7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4831,9 +4831,12 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
 static uint64_t vtd_get_viommu_flags(void *opaque)
 {
     IntelIOMMUState *s = opaque;
-    uint64_t flags;
+    uint64_t flags = 0;
 
-    flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+    if (s->fsts) {
+        flags = VIOMMU_FLAG_WANT_NESTING_PARENT |
+                VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
+    }
 
     return flags;
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..8f7ae919a5 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -522,6 +522,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING);
+    }
+    return false;
+}
+
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb83..231635cdc7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -349,6 +349,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
+    bool viommu_nesting, viommu_nesting_dirty;
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
@@ -402,8 +403,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
+    viommu_nesting = vfio_device_get_viommu_flags_want_nesting(vbasedev);
+    viommu_nesting_dirty =
+        vfio_device_get_viommu_flags_want_nesting_dirty(vbasedev);
+
     if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
-        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+        if (!viommu_nesting || viommu_nesting_dirty) {
+            flags |= IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+        }
     }
 
     /*
@@ -411,7 +418,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * force to create it so that it could be reused by vIOMMU to create
      * nested HWPT.
      */
-    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
+    if (viommu_nesting) {
         flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
 
         if (vfio_device_get_host_iommu_quirk_bypass_ro(vbasedev, type,
-- 
2.43.0


