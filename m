Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37821F4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx6-0002gx-W7; Wed, 15 Apr 2026 06:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx2-00026C-BW; Wed, 15 Apr 2026 06:58:32 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx0-0004DN-T0; Wed, 15 Apr 2026 06:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIn/fmoRqxDByduIqXQkvA54m4tQ9xOyYIwwzKgh2ag5mND7FQh3w5GGRDvtGgn63uU5SXVIASHU+mqYwJLMXkdwGhFXBcJzfi6qJxGBD+i5kcKRz/PqcvMpCv0WQHB1Y2QFXCfS//54lz3exIJC70KLyZQ16uDcuJ46+NK3jCt86vBBE5IcuXSZr/P2D3xFIgIEWTbgETiMZR1oXKJGxmLN3eSduxKtuugj2uLGC7tayTcXlhT2IAivfs8KzcVkCN11QcwRl+BKTGYvQ/o8wheFWWCOCG8m6tk7zt00yOiIaOHPpUXv4s5xf63C+XWqRcFhg4QfUnlMLfc0e5MtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Juj0WNvumwVRInHmfl7LV6k1m6l7SDkEF3bxlNpJQ=;
 b=xF9Bb3rBE3V4VHTPj5vBRFweFag/vBjHCaBwuVoF0Vus/7Cu9rQ7NFpQqMy90+Ig2CfykeoEmtb2GjkdgLOZGmkC1fKQ6rE52TDvsfd6NsltAcPz5lhlkx2qkqVkQntgi0NVp7B/5AXr4NmwToDYAqh6YWCYJNsssnjDGu+qYz9dsfg+gYDdWLC8IWdFVcjDc/LDsm1wQJnWGPLafaGJVNBeteAR41pZ7DxYWmPqS60iM0S6ELLgRiaPCc1j1SzsXnExm/zXo6XHhsj4fJ9qdmSqT1LDqPyz0+1P6bQzzied6r2ivRfs+R9hgz4YoVHJ4SPtHg3TUVggfKYj0/vXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Juj0WNvumwVRInHmfl7LV6k1m6l7SDkEF3bxlNpJQ=;
 b=Q0gjRo972qX83O7df3aXQTeBp1nxaV5M/ofLiZTQiKNmG9oJwomBGDXvvQEXgDCqCYgYMW8v6gQ1iyLGiapOt74za70xlvdH5PBttUhlGz8eNTUtVLO0jvKgE4AygiAc/m1r4qrDWipGZx1EYOP6n70g8FRDE7m20n3hCqNdXqoxr9yG4I+uhW7aPThs1QErkL/+IPR7xHCnQrvAfQdt0Y/+g7YJquuYDHEXgDNfiG2fNM8jHbGnQc9LJI+kG5m66xvdYHk82E+7Hi7/n+VGOLRdF+540dDeR0NbJ4HTRSLuPRoc6z06rZobUq2Dcj6zzB+A8Wg3YMFw0R9L5ncuLg==
Received: from MN0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::33)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:24 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::2f) by MN0P223CA0030.outlook.office365.com
 (2603:10b6:208:52b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 10:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:12 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:09 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 26/31] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Wed, 15 Apr 2026 11:55:47 +0100
Message-ID: <20260415105552.622421-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e84e054-a102-4066-b9a0-08de9addea3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: i5F5wUCRBOtwPxmKplh7srHU3NWNYSrMrLJvl4KKoowQjJge5d7BXPt1O4Xu3aymeL2mroVuVtmsD8p3fheCkLgeva/K2E/T9ubRLPPkBM1MfvQhfNKd2DuecXMhksvjBz/veF1ozwWl0QIYFl0vvozJA5lwLDBQxye0OVejvc5bFxNdbexOwUCTE3dGEGqEgn27wKxib/89IuDe2CYgHivjzxA9f1AlyRm+oQuYuEulq2a/Fd1zm8exuGonUfA7TrU89ZNCVIKPTRmVkn1ABuguCArPwVpeQ0F9g/39q9L+1m23pbhONVKgDL3TD6JTZeC2QFAiMxULliW6P/x4ZXr1VAP0oK2lFMxk1eDYfAia18FTM5MYV65lMspjcbfqU1mPSw/4pW/c1hm0lO9lnp7am8XW6Q1vr9Az+HYzl00mLqVnfRk1E14nTFlNpwFRFsx+yOvPJ71wNIPa4x15fIN4L7h1ASBX9sPp6eAz0Dbu2u+z6W36RMwMCpYYUarwcdbyXlIunD1GzOhvibaaFXNddTwdOQ+ZP0ef4OFteNl/0IsGYlZU82msvvlPpIHdb9/Wz7ggYctuMbewoVk3HoMYKbyKRoN4ZC5tN4dchcw8oSzGVxLnKxWuXZgxYGXl5OlCIFVTk8RPkZg49PXpQx7HGjyIhSt8K2B5TlQ4P8e9TdePzyrj1QaZ2elRkM3lLPCdbqvyGyaI9emSMsX64Gc10ec67+143NsPRKS8jltCVhaC0rBzFGD49fK+3LT6okHRDtTdsD3KR/qS5mPOUw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zOjHtDT1QEnt6+uOgvD5KcJaJ3Wu+0l9puuBkrJpdyIPykaMtAqbL4pKz2SuaEnh7cSz1s7j1XAtdTtlAWHlOhK44IrUk/0evjCeLCj+a96wGDhwiKgD+rcGv4bfNW1GTFwrPkeOYDsW5/hBflRmGMTm9DFa0S7/52Hr/Wh0HB6vKSEBjJIF7SIrDX/RxFjSBMYcvXJEsRqgFchocklqdMHQc9TeYqR5nFwhEuhjAlaFDCXWr5dxQ4oMLadiFwbxAcgx3zqwM0plA4nFMnYl6Mpw7XaCQ74BfEUcQLc0rwUuTt+sXaFpefPmNippky1O4Y9W09uPvS5V4dDrPMnOiekN8cESIyMxtYCaNgHfPfXrlwL3Ku5UDGDiNh1Cs2IUfe1Nu9XFQur+4L4RhC2DhNHfzT1XFyojr65SvNSa8CX7RwVxRrnWQwcODi1AFhcr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:23.9422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e84e054-a102-4066-b9a0-08de9addea3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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

From: Nicolin Chen <nicolinc@nvidia.com>

CMDQV HW reads guest queue memory in its host physical address setup via
IOMMUFD. This requires the guest queue memory is not only contiguous in
guest PA space but also in host PA space. With Tegra241 CMDQV enabled, we
must only advertise a CMDQS that the host can safely back with physically
contiguous memory. Allowing a queue larger than the host page size could
cause the hardware to DMA across page boundaries, leading to faults.

Walk the RAMBlock list to find the smallest memory-backend page size, then
limit IDR1.CMDQS so the guest cannot configure a command queue that exceeds
that contiguous backing. Fall back to the real host page size if no
memory-backend RAM blocks are found.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index af68add2f0..2870886783 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,6 +14,9 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/ramblock.h"
+#include "system/ramlist.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
@@ -646,9 +649,38 @@ free_viommu:
     return false;
 }
 
+static size_t tegra241_cmdqv_min_ram_pagesize(void)
+{
+    RAMBlock *rb;
+    size_t pg, min_pg = SIZE_MAX;
+
+    RAMBLOCK_FOREACH(rb) {
+        MemoryRegion *mr = rb->mr;
+
+        /* Only consider real RAM regions */
+        if (!mr || !memory_region_is_ram(mr)) {
+            continue;
+        }
+
+        /* Skip RAM regions that are not backed by a memory-backend */
+        if (!object_dynamic_cast(mr->owner, TYPE_MEMORY_BACKEND)) {
+            continue;
+        }
+
+        pg = qemu_ram_pagesize(rb);
+        if (pg && pg < min_pg) {
+            min_pg = pg;
+        }
+    }
+
+    return (min_pg == SIZE_MAX) ? qemu_real_host_page_size() : min_pg;
+}
+
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     int i;
+    size_t pgsize;
+    uint32_t val;
 
     cmdqv->config = V_CONFIG_RESET;
     cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
@@ -681,6 +713,15 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+    /*
+     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+     * queue fits entirely within the smallest backend page size, ensuring
+     * the command queue is physically contiguous in host memory.
+     */
+    pgsize = tegra241_cmdqv_min_ram_pagesize();
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
-- 
2.43.0


