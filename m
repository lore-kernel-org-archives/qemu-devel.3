Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B6CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHs8-0001WW-Lz; Tue, 19 May 2026 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHra-0000wE-Ho; Tue, 19 May 2026 06:39:50 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrY-0006X8-GO; Tue, 19 May 2026 06:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHEoMaPFoTsbtXOxqSg8a2CS/lSV8sy42xNtUe7yLiuM2AISCwXYfs1f+bQcMKsCdAEaCtuarFJK3fZ9b5aHJKCKZ4fS/rdfgtVOz510EWpa2n3tpNUu+zhfHPGfTgUUOIpKMtKXspPOjY+/mAW+5bkAp9LntafE7lB493KTa00uTxClRlZLdscxJKW9gjfc54y1ey1X4NglDJLG84OK8goufC2XjeRDBEAR8fSS0/W79Q9kUHk511LMEGwq8bf8btgk/6BbjJ79jm7g856XnC0uy4HtN3XoPw3DPfaBlJuf/Hrcj+9wXFut+TJ4JbTWSltT+83gwmE77Ywds2G3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKJ5F83CG6vTH5hm5T71otbSXOhpWgu4KbUTZ8vkB6U=;
 b=CiEABkrCrSBzYenk5VAAmCKWbSAdINq3GUHCTP2FB3wyu4mRM1OW0XbTNHDKCDjXbnRryIbIYsJcQVz0H75hQL83fVl19cahs/ZxMqbFX/8KmDOIyB3aHvxgxLu3oNb7hinym4bLlyZ1AqWtVDi+/QcgWMWZdihNvoIsl8tb9NvgDFs5N65E0BJ6RfbZdoNm+YMu3aZjUSXXwXuA4rKBDOPALAkzhmII6dJNx4naWZIwhPtPtwGecoDdM+fo/QrmrGUBYFAsE9JfueCcT3mxH6Ngs+H0uB8P4zvfkkrDw8swWnFdaF14pBQU9BAguB0GKSe5mfGlgkqf18M9k5mHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKJ5F83CG6vTH5hm5T71otbSXOhpWgu4KbUTZ8vkB6U=;
 b=UiKBTJy+S+CnOIHlgc8jjIs4JGWgMm3l4gSvcAX7tRnw0G9K7OWfkf1HB0keDHWdBShbk4bVbw2btBt7gT/xkKcsFTJM5yORDGubepwfNPE7+jEyTpn+HXx7wDV695l62KfTlnLigYCO+78f8qD87xbvk8SVQeJ6+OBuV31GrUcXe+CqECUlTt2QG0qKWhL/ePEDVkDG0STVLsw80TImX4O13eRg+2Ewv5h0YQUUTklkiTEsdNxfzYKKu6b0CsSH5wk4NR5mM+vMuu2EFe0EwkdZrbMlDm4p09DVcB0AZG4HiWVYJubMHArsALDvnMV068oSfG1LBZ2fVXJNd2HWbg==
Received: from CYXP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::14)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 10:39:41 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:ee:cafe::3a) by CYXP220CA0011.outlook.office365.com
 (2603:10b6:930:ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:23 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:20 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Date: Tue, 19 May 2026 11:36:55 +0100
Message-ID: <20260519103727.899332-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: d24acd36-03d2-49c3-0226-08deb592eea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yrcxn935+TjOUP6H1WiiifTVEEmJ4UQ3lDdeFRZ3HX8FVoicv9uHG0Rz7caTa318jJXSl8BdixfgJkbD6IigoPMfYtXN/0+WleDdYpdo9/Icl4t29khRmaZuztXp83sWL3cFLbS0zYhEJx6ikJsTEu2IJ/G62VvZDILIhrbbfGcz6wJJGR09DQVvUZIEalFv9e3yhuYDafZ8/s7SAHpqjVeDeEUE7RXrdcP1nC5Vkiacj8/M6Pu4KevRt6jVShADuQautNF2eMywvH6tXFGS//qc70cTXgrJvH2pckfKyu2PJWMppscTydXRCTkbkCs46E6UfCMzcX7rnknuz0r5xJ46CF9Ce+odoDf3jTNZjdvYpFttJe+jnNjiPjICGbbHbLyhciUl/seJhea+jLCTlc2mLQmTv++oSiCDxqOxYzeOABIVbtCzJpWZ49zLgCiGjTt1rB912KUHF55s9mnvgFs6OWYF2z+OU7nD/oACLnaNFT3WdIDv51OycOCoBQz6NrdUx5xqwFneFzId9LP5uKZ1wlXOGLMsT5EkH50UOKhl/3bToFx4+wwhwiA0+/rOURdDlWZ7fWfFr2ER1ajEjG2ABPyEZmLJSC3FlubZ3c20r/VmkdRsrZJqlnGHhYUvaxzSrMtGta+1g/wFdnWci2xfWi7B5Z5pmhmfjlxtGJPVaLTcRO8//D9P02kAfti9R76K8rPwBhOXffXrK+J2V2xN/1U1htBDXlDZ1Onob98=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZubwBjjyjVfbbNNRbJA1Z08jpMhOtW4KTDy8nM4Io+cI+H4huXghKTHhfOP7E5Xh+4T2/wjZL/NKCV201DNVcRYUn+4bhiRtTFm3lqA6x2dsP7SNplwzoAQ8eE9x31ClfmtnWnyKzVtml2R1gublG8irrgMpNd8AVlXwquYhWDKKgEVg79r5PRX8++vJh3IjwHHBJVjL9iHaa2ltDu+nEqyYoGhGQKMjI5D6m8hC6dyGjA3abyCfOlsytGaIqdzQfK6ajWuexL8vFCkobKlOaJlKU7HtbumOufpgLbsqXub7Tv8Y4AOXp+m0XVk1Bz6CZiOBoW1qrCCbe7g+DcGCqjgVIsWB68jPhvn0favlo5/rmdi1pSv289FRVzCPpyRI4i4uMgJzy/Xfza6vNx51GtWGzF/2nq2EqzP1zDjZw6RgSvlR/2KK4dmLA1geb9uQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:40.6037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24acd36-03d2-49c3-0226-08deb592eea7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nicolin Chen <nicolinc@nvidia.com>

The CMDQ-V CMDQ pages provide a VM wide view of all VCMDQs, while the
VINTF pages expose a logical view local to a given VINTF. Although real
hardware may support multiple VINTFs, the kernel currently exposes a
single VINTF per VM.

The kernel provides an mmap offset for the VINTF Page0 region during
vIOMMU allocation. However, the logical-to-physical association between
VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
to that, the mapped Page0 does not back any real VCMDQ state.

When VINTF is enabled, mmap the kernel provided Page0 region and set
ENABLE_OK only if the mmap succeeds. Unmap it when VINTF is disabled.
This prepares the VINTF mapping in advance of subsequent patches that
add VCMDQ allocation support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 50 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 6b21a407af..f0b031b4dc 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -37,12 +37,15 @@
 #define CMDQV_VINTF_PAGE1_BASE  0x40000
 #define CMDQV_VCMDQ_STRIDE      0x80
 
+#define VINTF_PAGE_SIZE 0x10000
+
 typedef struct Tegra241CMDQV {
     struct iommu_viommu_tegra241_cmdqv cmdqv_data;
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    void *vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 5d2d9d2e26..4d9f094b2a 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -9,6 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
@@ -228,8 +230,42 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
     trace_tegra241_cmdqv_write_vcmdq_page1(index, offset0, value);
 }
 
+static bool
+tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    if (!cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE) < 0) {
+        error_setg_errno(errp, errno, "Failed to unmap VINTF page0");
+        return false;
+    }
+    cmdqv->vintf_page0 = NULL;
+    return true;
+}
+
+static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+
+    if (cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
+                                     VINTF_PAGE_SIZE,
+                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
-                                              hwaddr offset, uint64_t value)
+                                              hwaddr offset, uint64_t value,
+                                              Error **errp)
 {
     int i;
 
@@ -244,8 +280,11 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
 
         cmdqv->vintf_config = value;
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
-            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
+                cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            }
         } else {
+            tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
         break;
@@ -347,6 +386,7 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -365,7 +405,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
         break;
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
-        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
         break;
     case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
         /*
@@ -398,6 +438,10 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 /*
-- 
2.43.0


