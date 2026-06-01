Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66414CD6E64
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1An-0001FX-3M; Mon, 01 Jun 2026 07:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19e-00074D-5o; Mon, 01 Jun 2026 07:50:04 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19c-0005BC-Fw; Mon, 01 Jun 2026 07:50:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9abiQ7sOxxTSCh1AscWPYCZa3IYjLAkgGa3bSoYA2FruFWGVYqxpIuGXFkPX+qboM51FIRm76mrLCzeC13iDPDQYqh2pL/KPa3OwUBuuspyjHIsi1NOImh5E5DcBuvJN2l/v4xh6GgH5QNmlH1GQLp9GngynVSiFd12pxfY3Z4Asns60Md79HgC/54Fu0YIE0eJFu5OL5GC0seMZyQ4IECaOmH+0yafBryaTiWDYEsZPB59pAxPQRvW3F3BBKl9QUH3HAnvMxNJSj8DrNRH4LAiAPQaqldO1RTJrSWcK3RWWpIJfq8+MU8OoPreEPctWHsN6BggjbB1GJfPQKNshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txiY8T3vcBdwsJHkwF99vyXiQjATtN6IbhOk4LWs6bQ=;
 b=olGfFscYDtv7RAbP8f5SQ2K6haJI/FQRYGZlKhaOYTrKRDa7n5jhJQXpEyO4TPgxwXTlG7ezJaQx+aEJiRN5CwFUIFKNxOA2+l9MYrfUNg/rrf2DMcy3T/018XrZac1gEQZrm8xVZEGeDK/Ju8RptRENwgNJOI102KRNppsjdCEcq7zRkJzzxrScgO2kTTw0L1HENyuYUEsvx9Px+atCp5tf9j38nQyGD3kSw2FiYMQT9ZFJqWnVz6ByXqd3YpskthZH3C27Qro8mHP8Ix/eLieZUCbWU0jPjFds5icSUKsIPw1Yqs4NUXqtZoo+oKyKxpTqT27k8Eb7uP44hPvWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txiY8T3vcBdwsJHkwF99vyXiQjATtN6IbhOk4LWs6bQ=;
 b=gMZm9wwSDjO7oRvkw6k5aVi2/DhaBGWnuyNQxx5wJo2+FBD3vICDMq15XVdB6Izni5f+Vcl+AMOIn1oGCupzMgJRB2knYL4JWo6ipa1DE3d+T/KB6epIUkWkTspyAUt39YFWgDCBVo4TmoyCZsjURKc9CW17f7JUI7EmSBpuH43/hhe7XXzID02wjuHKMkeQx+q8fzMz/rHKM34p2LPkkQ/o3TIXU5WiLrwohzx8GcSZ+ohULH3KEwNGrSBrz8FpC0DjR+ay9fhA/9ed4YCZbTaaWEk0VlBlCq1oC858MW26c6o+EaFXZDSqMqdToMuXo4eZN7poT1OS/RqQuykViA==
Received: from BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:49:54 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::4a) by BLAPR03CA0107.outlook.office365.com
 (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:46 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 25/31] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Mon, 1 Jun 2026 12:42:15 +0100
Message-ID: <20260601114221.457995-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: d768ed76-f4b1-4428-02a3-08debfd3e562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OInKKhMOpiNJ7HPAUF/3jtoPjLdKCEna+VY5TaP3wIR+74uuaoNv8l3Sp7iFmdj+Guh2wLtG1YjUOlziFQUp9334LwOu284qQNI134hpm6ezU/47zUDK/e8qfmjPLd5rdFFGqv80cHBYtKmc30I2KD7IyQA5nx8O9hRmdwztlfoBREzAIf3YJlWwf9apkSk9jKsw2e8v2T+VqJ2c9aS0o1oq0rJSxT9y2maft8T9dCuhPEu1s/6siF0uzeWim1tlJEdyk8yO61oKUVH4nDc2YiCVa/hhFAM/DajK16UkpETV2KSAT/gd57PWs9d03sxSMa4406mnFQc22kfsrbuBfaJSARbfdTh3hXlzoffdco/pvKClBQ3Mu7lP5sCDWIjWO1pCXI5fg/StdJQsFEzU+OcBXvMARoMmmIrqxLeeKOOIYPu+13ioEQB5k7vDZ1Rnxq9XNuYMa/Jf/DBrcfLKO7OxPU6V2WAegvg8E0bbHWRBHcNdhnOXkMDFaOYlJzRMrKHpiPTrYt0nuGik7sreoZ/7C1i5lL73GWONBv5ipjkk/dAuwbAg4HCP3XNLnxGiIS6y7goDSeyJZMFvwdZLTPU99QVgqqdjglxgGW4J/0IlOHY1mv0v1Qg7M3gNu334W6MTXoL55l3YDVOOcOAnysGnOCjAulY9FiEX4DdPLdSB5rIFwrb7FUutfv0jvLAxHvKbEOVFcQxdUWuHSlvwForfWlOr80+FGYDV3Jyc0A8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DKgpvJDuIUUEHYx6oQorS6MeAHYrsGNgA9khFHDkSBkiskmmOCFsMOQn6b/2yVnbyXLbzy1kWipNASoHrFYbcDZXrJBPPoRaaPs1EOGNPWNkGSjeU6/SwRY7HH+ZCNkCd+S5BJJ9CwwNIsHkW4Z2MoEDS62xXjgrInO8WUQPiUYSZ1JkZ9rFD3sQnlyF9RREmuvYsKlRI6ghYtRhz3osVS6OwOQh2TnbVjxZwBTmFLyNvrmZrv/k4B82wtWKHaa0n3sF3Mu92Tbm9X7tkb5QbhRdjwQQc0ljm7U/gzOJZBrzKIuv9MwRmrUHnetbOeVIPqldqzwNGRIP87m+OvalaTTmm6HvE2AyknW6ayrwQ6ASROXkbq9gIRjvwmh3/OWlWAkeYJYa3CsAQJEebTfdhIqm38AxhpMSiKDy+OW8g8V1MxFI+s1AFQrVAnVXo/Za
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:53.8764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d768ed76-f4b1-4428-02a3-08debfd3e562
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nicolin Chen <nicolinc@nvidia.com>

CMDQV HW performs DMA accesses to guest queue memory by its host
physical address set up via IOMMUFD. This requires the guest queue
to be contiguous in both guest PA and host PA space. With Tegra241
CMDQV enabled, we must only advertise a command queue size (CMDQS)
that the host can safely back with physically contiguous memory.
Allowing a queue size larger than the host page size could cause
the hardware to DMA across page boundaries, leading to faults.

Use qemu_minrampagesize() to find the smallest memory-backend page
size in use, then cap IDR1.CMDQS so the guest cannot configure a
command queue that exceeds that contiguous backing.

Note this is done at SMMUv3 init, before any guest queue GPA is
known, so the cap is conservative. Maximum queue size is 8MiB;
it is recommended to back the VM with hugepage sizes large enough
so CMDQS stays at the HW maximum. Smaller backing pages reduce
CMDQS accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ac17b56c1c..661c46e3d9 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,8 @@
 #include "hw/arm/smmuv3-common.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/hostmem.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
@@ -874,6 +876,8 @@ free_viommu:
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     int i;
+    long pgsize;
+    uint32_t val;
 
     cmdqv->config = V_CONFIG_RESET;
     cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
@@ -905,6 +909,22 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+    /*
+     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+     * queue fits entirely within the smallest backend page size, ensuring
+     * the command queue is physically contiguous in host memory.
+     *
+     *   IDR1.CMDQS = log2(max_qsz) - entry_shift
+     *
+     * where entry_shift = 4 (each CMDQ entry is 16 bytes = 2^4).
+     */
+    pgsize = qemu_minrampagesize();
+    if (pgsize == LONG_MAX) {
+        pgsize = qemu_real_host_page_size();
+    }
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
-- 
2.43.0


