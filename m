Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A19F41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx2-00020c-7W; Wed, 15 Apr 2026 06:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxws-0001gx-BQ; Wed, 15 Apr 2026 06:58:25 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwq-0004Ae-Pf; Wed, 15 Apr 2026 06:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AocwmxAanq+w/yfnzQKk3XicVIMZ/tZMdhLnM1p3DSCWtDdVSE/usNQWL91OHPGyOf/V3CQy3qekGJyoyjPL1+WQ1r44WqW/YL+XoLN2PblWmAJ/cAYt1A8xsmlXOLZRCCr9Gss+Yf+T/S8S7UEoOGouwk80OewflCkrbEv7YrleoVzbL84un1fad+7ol5+8nmJFY0pFYji9y9pbqmA+Gn3+nK92TFeZ8GynmIqf43IJW5thwxHSZmmpBQgKlKCoRzZcsYhrnK3H+Psx35hjLSxbdjO88Lg0A7b7O0e+PtlqD0xdDPNGW/SRzCSxhvVuXJImSO1XY1PhH22sfi//Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiJQDQMBoxk8G6zhTl81BDXOwm4LZl7q07yXrziFT1w=;
 b=VsUNap7ZyS7PM0YSyOiBdHUlRMr+2sJWsvMPR++8KFRbdrDDKA0u5OZjO63fqcL8u3n8771H0tGCxjcemVt8fMJU4+sWdoAZYd4WoBlSsJt9mrCp38Ajpw6FFqnqwB/B2y5M0RTWOy7X/beLNwvDZkCLkfk335THvgy3uFeZPb0eLjm5sC+vLvBLasdiyzhpW780u698WS4YcpkFs/pjy7wJ3H77HjSM9W9x7O4az0t8csvG/KxMCOt2SyD5vFTA6Me5HwqshgPZ81RlfLGwtfla0LLVZxyYoVj6nLfqXTrkkh2ch/L1lnLNq4SVeTjmNH9Ltq1PRGU6NdDcL7DWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiJQDQMBoxk8G6zhTl81BDXOwm4LZl7q07yXrziFT1w=;
 b=JHWKaeTqP27X3J6SAZGCroMFWR2VN4+lvdHxWhpLX88Y8AHvTSmF6JA+S1AF3gMjDaQjDkEz2Cg/5xVAQEZx869IxgiXrI+irS7tBTrTvs9xW2GgqJyBM1bXtEIvWD+d9zXwmvgNj55hHK3GQ1nk1YkvkEvHcCVXBirun6/aG/Khj99yzX0dM2ZxT92h6YAvbCjMT343q/w7ywz6oAbyo1oDHA2LqavIzqkl7vqvvkuO1NhF3ssRemraP57qimuCm1nOvCiA+QTNscZjvIMwnNSgaOcqwCyZlNeogUC5asAAfxOfCoqdDvo4ThG46TS660QFKBK8+Yk/jsSv9GcIXQ==
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Wed, 15 Apr
 2026 10:58:13 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::f4) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:56 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:53 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into guest
 MMIO space
Date: Wed, 15 Apr 2026 11:55:43 +0100
Message-ID: <20260415105552.622421-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9218c1ad-ae1c-4d79-f97a-08de9adde3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bMr+PLK1VjbLqq+wwtw3MyEWrZbX3AwORsqfJV1+3oaP6hHuCnTIgR6Qtw+yGII0WEWwGOmClXwzxumHehE2cl/y9ishcjLjohXlCZ5YzHdg5Ie9KeQQ9+lcA7baDQ5fKyeTeL9AG+NLpxklhgZ5FNDEtZYF/kJgVwBN9etr/Z2K9jD6IuNwXJQ3gQZCQA5TdO5P+7uq0dCGlbR5p6fyBqP3syT/FbSuc85UldaAZM6smK/5hq40A0Pf4q4Nt5FixYVH+YUym1TlZhj0yz9Y2DIiX2Ie9SyL1SmNnqllJ0qLvApy7C7k6qT+geQVfiSD/pqJGwqSl0o4YB9MYLlCptpEfE4EkjvzNzwDegMXGdjyVlqCXpeoWlXR4hOJR5RAW53wMDcpLfJOaJueHhUxaye+wsSDPUQNRPMYdvSPiq/oy3iq124Sy/cz6wqlXzNIa1BQPjatS9/KWj8Krg4gsEXPJc7N+Co3SI5pRZh9x+xy+x7svg40JS5UWmGPe/E5xCs3RL+lCSnYk3EiKZLM2x7MWzhzrm7sEsyeIIYdBjqnSnoKrv2mIcX5UKDeiM3e1w9YN3lmC852pjicV4OEx8u5L5VU6Mf9lFdpYz9AkUpwcMy992FegzT2PwkxOdqi25nxvJTr11O5Icx7PQ2QBk61RNsy11JKGvHi3LH3oRp4wSLJxsa5ayLcU8cfUqrMWZ1lCXXt06BC/tKY2+Y6jQdhgH81qU42FIHQyLJBFRSVMoe++yYRKcYW34FjP9mgprei0HN6n5YR1o0rQvrWZg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jDWVI0OSMeWOZxbxsw5IShnXFIWHK3xM+uGAYRws8A4UkLHBDj7xHE/JouxyYTuIkVGPy4C7dbfolWBLo1fAc3ww239h3Y0YGfelfFHpdSDiilbnQ+/W5eK/mqA4yyZCWGNEGsO4DtS/BrmW+prEtHHE9zM9O7GsXHqS+dohAbKsI7rplgMFyB4MXYJ14fT+ivXiVpii0yOY5ctBxaO8tF00bQudbSalprVIjiBfhjvjBMt6wWUEEp2Ql60XKGe0DLQ0CTOeD4iJkZgVkkkEI+GhgfViQUghPqhz9/JwuPBbmRPDvQltk1OTXvF5UvRSGqEpwcG/nkTJ6TY8wDHU2toMSpSe6lbIoVuqYzBzwp1C/6fh08jCrs4Ve3jdrWJlVrBsILvmfZQQNqA+6yd2Lxf2SvZwzaxxwGC94Dqu4nti9Avtx9ZE87rEaSP+x/dw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:13.0826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9218c1ad-ae1c-4d79-f97a-08de9adde3b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
 hw/arm/tegra241-cmdqv.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 039d86374f..2befa6205e 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -46,6 +46,7 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
+    MemoryRegion *mr_vintf_page0;
 
     /* Register Cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index eb619e1134..bf989dd51f 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -15,6 +15,40 @@
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
+    cmdqv->mr_vintf_page0->ram_device_skip_iommu_map = true;
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
+                                        CMDQV_VINTF_PAGE0_BASE,
+                                        cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -72,6 +106,7 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     hw_queue->viommu = viommu;
     cmdqv->vcmdq[index] = hw_queue;
 
+    tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
     return true;
 }
 
@@ -312,6 +347,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                 cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
             }
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
@@ -438,6 +474,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
         if (value & R_CONFIG_CMDQV_EN_MASK) {
             cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
-- 
2.43.0


