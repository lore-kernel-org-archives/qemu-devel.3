Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C922FC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzy-0006y2-Qi; Thu, 26 Feb 2026 05:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzw-0006xR-Rr; Thu, 26 Feb 2026 05:53:36 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzv-000143-AO; Thu, 26 Feb 2026 05:53:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk0P8M6LXgRFcf97qEUuEcJFYl1lm7czgiDGOPz03iAzoxw87hBW21O21GKi8+EnXU+sYLiav/Gk49z1bEWJnqh3c/EYSipJfiCeCVqIcr+Fqv3iR4nW7wYsJX2NGfcFosjNUF3RW8b+5jEGKkXjFGdmalovTwGZXQQRCCyUyktH6B7W+cPXviqtRzBGZBOnVJRylwc/FP8wCtD5XXO9i1VdbpnS/bY7hEBZGktSmsF8Mfiy0KBZK4fZ5jY73Vj4WOWSkSs0Rk02PFTp3iajsCbh/PzKJu2bmKWTBqJ0ncey/FIruqy2fbbCW/Rql1Qsq5bCI6jYb3jKiz3o++3yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S61x7R63ORUo7+JtXUZhMBJsd312E3/fyghDga51pPs=;
 b=dwZp7mpvmBBFitmtp0u0ZIRazT7I8mePE0iZbgKnjkfRHfshb9CtgTwEE3Zf5GPAMusKylNHwgULPY3kDA2vfBEWTq2st5WT3zxNbXh3xeQCgBAjhzCxAQ0Xy0YqOm1Vwhecy83ZpYTpB2g/4glZUMMvnufhHxiWotFLUsz535rQsen3s8JthfNwNmz+0j5mSfvi0Qd/64qNZGeq8liFD10OP4HLS9BixAlX+H2XeUPR8cGCH7KSVfV8jDzcg9OPjJtMrBEB7QZFwKYTDxv4vM4p4EfT3AreX9SdzUD0YHtCMiQ52gOnjuQKUBV7N6O/pU1eK7R455WePh5f0rQsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S61x7R63ORUo7+JtXUZhMBJsd312E3/fyghDga51pPs=;
 b=piKbn7qrSsrc57f7IxUNDoNU7VFWNqmM4hPaTzqKe82HOiV3ScHXfBa01VoYSav/WPXC82h28h0KNt4KF156PBbly6h3G4glvMfs2QZyAoD8BXTrCVgGANww+DRATBE5/KIqAtEz/S/o2q4GichZqjdQp5xwcpx1siIsTXdzv6eD+5rM4Jo4ic0J0ewS1SiHCzwlbI2Wpu2RSzf80SERw2NLAmpEZ7V0YnLxoy+XXBOiyhacBgmYBTVp/zab7z9wUSZ2xQW38o9sOXXQvE1IAp0S9DUnldI++zejxLQXxB5i0/3l82pm5GQmWjEf45VAU8DzFM9gJvgRygFWl+tZKw==
Received: from DS7PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:3b5::35)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:53:29 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::8f) by DS7PR03CA0060.outlook.office365.com
 (2603:10b6:5:3b5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:05 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 26/32] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Thu, 26 Feb 2026 10:50:50 +0000
Message-ID: <20260226105056.897-27-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 623d5f8e-a148-4f8b-7d6f-08de7525467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: uF/5v+AT/t2Bmjo4aQsEQ0BptsHMkWhFSnqbVzs6edtck0Ysit0Z9W0RUg9iTKy+DYyArR/2umC0gtRyj/UqzVIljCt2imTVaZRuu8xj853jIE5uitx9Csd+yiW6uivO5ioejS6R8ybb1dF7ib0pEFxByeRqzxlqcr+7sUXamvym4S3kJSv45q+2as734cMFhR1eXGSSpwJTwut+TjZ4QBouk+2Xov4K+GgHyK/MfdkFNTYC3+8J0oK7tG+z0BxlyCA1NsHue1VMyDyMWFj2nwVcPFI5vwbbMWxISUzQDSVrqupqZ+18z/kKTdRojackolXQOx5jahFZUudYPdYzhur/xRQn8/w12Weiz5YDHpA3JOZF0bsyc74u9Z8t27FC99+6YF8aHnsCDKOeDrO2KvbCOpvoEW9buL9btX5ouRa96c2/qsYKf7Vi39SU/f+8O8/zt01oSAJ5xRTUPQR3wUTXGzDR6tffz3ZbfXQE3LJvyBTLvgKYYedOi7Fo5h0Tonsu8Y7kYZfBNdw8VETAeCixPFA1Uut0e+372/NaPHqR68k9AFVEESeDd3kGxbOJKwPUsKe1LyLg3EgwYp45SqAtFMb6Wto/AzB0cMQOkEFGttLHOduJoFjt0ir1eHOjtc+58aoJzxgSZGkXSzpqjHVO1Jb9RXGG2/wVivVoomRhb56Ulbnvr7I+RNAgjLI/ULZ1U4hYeGhyPXC4jpcT4S58gj9MvvtSkACe3ZBof+Ed4g3gjL/tHcUAdsb0sIIpEdj5Ks6bfdwlyrDhr+c5wrO4qRIqnSr+uv1ywiBWW5N+GAvJ7UDHtl5ITspaHFaUIKo7MVkG3yXHCq+jgBeVIw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /SfHyAJYPPgd3FpUrZufHMtTE6iXsBKeXKz0PRthMdcdOul/O477oHMZjyfHdE51unEwaTdtSFUlLGpG0Bq23s1q6rfpxs5cIT4Ztv7UgU48bUnb3Bh0Q67LDbSxjRtg6aPwtpt6KC6G8Wr3EhTKrNWvdc265xvr8xXAoBWq+XJdlk8EgusQBEMof6kWWSyIeSB8ly2D7TMBEpOwV+u7EyDBWg9jt6V4PkyQL3UMIAUYT5FE8D8ut+2tAX0nNuZtbw793jI3jUIbekS/aQ7+GbePlJx5rx/V/sPNwWzcZdNTQ49BRi6Y/0sNJvg/Zs2WXUmNGknGRoSx9a63xjiiq70Sb4VPjewzYHa2cSl27OLlb9vsVPhyJuaBwNl4K3M4K81mSz3/++1PwuCrywnGPKIi/mSOtgRIG/vuQrnoXHv7IcBL6U6NL6j/tJGL1sj3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:28.7244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623d5f8e-a148-4f8b-7d6f-08de7525467a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
IOMUUFD. This requires the guest queue memory isn't only contiguous in
guest PA space but also in host PA space. With Tegra241 CMDQV enabled, we
must only advertise a CMDQV size that the host can safely back with
physically contiguous memory. Allowing a CMDQV larger than the host page
size could cause the hardware to DMA across page boundaries leading to
faults.

Limit IDR1.CMDQS so the guest cannot configure a CMDQV that exceeds the
host’s contiguous backing.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 5afdc5c8a4..a379341c0a 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -11,10 +11,14 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include <math.h>
 
 #include "hw/arm/smmuv3.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/ramblock.h"
+#include "system/ramlist.h"
 #include "tegra241-cmdqv.h"
 
 static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
@@ -618,9 +622,38 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     return true;
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
     cmdqv->param =
@@ -652,6 +685,16 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+   /*
+    * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+    * queue fits entirely within the smallest backend page size, ensuring
+    * the command queue is physically contiguous in host memory.
+    */
+    pgsize = tegra241_cmdqv_min_ram_pagesize();
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(log2(pgsize) - 4, val));
+
     return;
 }
 
-- 
2.43.0


