Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CF3CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsJ-0002Zv-9o; Tue, 19 May 2026 06:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrx-0001Mg-FB; Tue, 19 May 2026 06:40:19 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHru-0006lx-Jo; Tue, 19 May 2026 06:40:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCYT+/mVABjUxawclGTmgeLvepw1NBvseenq4kC+gIqsgESWH3KkBB8UPEFAtFfILE4UAXYSyD8ESobHzOxFuivZFnuSc2LbaE7d/6N22ledWtCNlmCNZvU04WxbpAZsE9FbTjvFm54OTcckFYNWy4tagia8xTjpwt5pvL4tE3b73Wp3H3DWSSWA/hK1E2oZPsuzkr8KOVcxqLHDx8TiJ/Siiom56q3E1VXkfUuJbb+Wc8d3xVpgW9zZWTCj3pOB5TbEfW9biw8qDmgsci9kgG38xmonvr+moV5nX204j8BYHb7pZMBZbXigpDsOdH5nZur6G0AnbNmChwwLYoCkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhF/QX4xj1OQsXu41GlLIgRbvTOFQM1Y3CBA5ZRtNmg=;
 b=wp3jr6EOjbki39IOIDGjjH6F2StEL5AcRyDyZe2BEfrzZyC+tXlQG+OX+Ble6pIhBUOOETys17zSed4Q6BJQrJzSkWaW2E8t6bi705Xqzniz/IShQKVXVnnolLQlDQIWrZkGBLDfQ9dyDpk0pEH/iLwuDasMKrHhQK2JQ4kZd0GCkt1GcmJiSHLEwpXtXvAah+5RlCZv/g3bc0SXuQw/3I8w/ntsA3eViunYGU5eghvnubFRoTt58i3wpNDtIXVBd2dziS3AeX80OPoYx1zlVDB19e5BBYprLyOFAJqVYBe2vSITt5NXr7t6KT6MPN2bbQSOBuMw5UbSRsx2tLZSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhF/QX4xj1OQsXu41GlLIgRbvTOFQM1Y3CBA5ZRtNmg=;
 b=YnPSX1CmxpWm9A8uLmIWLuQhoiMtRw9GI3TL7vYz1XoqkVPGPPcDqfSpip5Rb1bluEG9nlhqVS2oEr+rDBQRV6x+ZoIDVw/N5jAxKedT/RVMOy6t+GBB+o3+Dn6ZnKlcaZCO2CqfkbdAj+Jm5JzIHtDdx6jjFeIrGSS9689jKWh8GtJ0yU7C5ojdmJccY8bE2nXAcsEsgTDA6Upi+1AtUi6i1IbR3BhbnrcMU6jPVmBKmqraHjvC6mCNybKip3M6ZxEDDfhmvBuv6Jy01E2gxnc5LcFNv0W+3GvPp1Kaoi3qzvNO5cSayQvz0Z4DBmX83fdE6F/BnWyDiKg4ZsQgDA==
Received: from DS7PR05CA0066.namprd05.prod.outlook.com (2603:10b6:8:57::11) by
 MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 19 May 2026 10:40:02 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::27) by DS7PR05CA0066.outlook.office365.com
 (2603:10b6:8:57::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 10:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:43 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:40 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 22/32] hw/arm/tegra241-cmdqv: Map VINTF page0 into guest
 MMIO space
Date: Tue, 19 May 2026 11:37:00 +0100
Message-ID: <20260519103727.899332-23-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 01309a7d-9873-4574-7aa1-08deb592fb51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BwasscSwL8nf7VB6JnEFL+0yY+qv+VDP8mpL7xAHzIEjic1Kwtm48NeQT2GlkwW4RMhQC25hFrj00/IzrmZGQauiqg7af+v92XwU8iyvzq3nd+mlyy4S68fYZ63iCCGG6JBMmSiYeq5a1gnbtRSjEg6avcVfrLA1bVYr3mpFuNHSz4G3Aj+Cm0nu+900dK/qg3qpbOFIAsJKt9XvuJsKYdAJlrnPaxe8n9KxIaca3LOhuK6pLa2oYt39xGL4xIvW4vEapE3apLirYr0Y0B1xY+LLuDCi9KiQ2pMA4JWxZDDQxK/X16su5KLvBPa1E2gwUMVLArmWfL9f/F01PElXmf6H1hrZDrBe6ftwBivv+ytKL0Z4omljByJdNM0CIa51+X+6h9k7bphbgUU6cgvrBTiDefN8aW6CF5zDpWoKQfgLTx2bGi7RfEWEOjF7qufj1K8iaSFgG9DroDjlWy2rK8NsNhWOEb/FOnRL/o/cEnQ/fo7tPEaO7V1W1uq0isqCJXzZlADxZ0Evu6tSqU1s2oUaHtSipbRf6kiefndsbP7ZOzddGvezEW0CcBmkiXllc8B9R1TraBEex8hPjYyoynB81Cf4PtpUGzzLnM4qOU+/cVvlzv2Sq8yhce+CeJbseMEoOtxuZVUs7+yr4QjGeijGd6mXINQaP9267q9Q9g4jhbsg5QQo0zTXxF9KCyl8qbC6jteMIQHpcQYkewR6YB5Wz5d0qoLLYjFYMpcOaY8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FQxqi33g0299i0xFCjrjW0Xkc6AUmE9GoT2zlZEOSjq3gF9BpRyzocQM9f06VCbs1WD/YTfXRgLNY+9Puqpo0JKiq5TP5XkWjJQ1y8k76D0BAuZUBBNFF4sHbfSiYDmg1KYRgkuyTHxioHwalGp28R+dDMWaXpXZNkjg/FzjEf0Du5wW5WJvtl0jFyZuYC64Lft4DZ7WyX9yTCkyEhluhKCxgYx65QwwOEGbClVZI3+b+Gn9qHzjitLAiO12CKuCr8Xt3F4zQxGtUKJtu0bQwp7zVPforW7jKpu1i1xaEyNbRhoYYFF+3HS4t/7pgdvneCUlpOGFSEhkV9ONz76j0/nZsgzCFhMlUt6L8T8NltroR96MVTt2RmprqE/t7VJKYAHNwL3nluyiZtAN0mSC3KO9PAMsylsmRrlHV3fQBu+2VpYnJl3Qj3theilwrEdJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:01.8028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01309a7d-9873-4574-7aa1-08deb592fb51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Once a VCMDQ is allocated, map the mmap'd vintf_page0 region directly
into the guest-visible MMIO space at offset 0x30000 as a RAM-backed
MemoryRegion. This eliminates QEMU trapping for hot-path CONS/PROD
index updates.

After this patch, the two VCMDQ apertures use different access paths:
the direct aperture (0x10000) remains QEMU-trapped and writes via
vintf_ptr, while the VI aperture (0x30000) is a direct guest RAM
mapping. Both paths write to the same underlying vintf_page0 memory,
so no synchronisation between the apertures is needed.

The mapping is installed lazily on first successful VCMDQ hardware
queue allocation and removed when CMDQV or VINTF is disabled.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 7a8cb2ebc7..e9e1933a19 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
+    MemoryRegion *mr_vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index a7e89905df..853c548e58 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -18,6 +18,40 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    if (!cmdqv->mr_vintf_page0) {
+        return;
+    }
+
+    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
+    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
+    g_free(cmdqv->mr_vintf_page0);
+    cmdqv->mr_vintf_page0 = NULL;
+}
+
+static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    char *name;
+
+    if (cmdqv->mr_vintf_page0) {
+        return;
+    }
+
+    name = g_strdup_printf("%s vintf-page0",
+                           memory_region_name(&cmdqv->mmio_cmdqv));
+    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
+    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, VINTF_PAGE_SIZE,
+                                      cmdqv->vintf_page0);
+    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
+                                        CMDQV_VINTF_PAGE0_BASE,
+                                        cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -130,6 +164,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     /* Pre-alloc cached writes survive the cache-to-hardware transition. */
     tegra241_cmdqv_sync_vcmdq(cmdqv, index);
 
+    /* Map the mmap'd VINTF page0 into guest MMIO space. */
+    tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
+
     return true;
 }
 
@@ -449,6 +486,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                 tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
             }
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
@@ -566,6 +604,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
              */
             tegra241_cmdqv_setup_all_vcmdq(cmdqv, &local_err);
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
-- 
2.43.0


