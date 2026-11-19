Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB3606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=YjnF0dc3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwLt-0003Bj-Dk; Thu, 19 Nov 2026 02:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLV-0002zy-SN; Thu, 19 Nov 2026 02:14:14 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004Jr-UL; Thu, 19 Nov 2026 02:14:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ09ClEiqccuvjUhH/14ToqiXsJhwKLr4z+HjFji4ZuNnOj66RFgivWb0gKMBzLiCT6V6TnLQG4HrjV4Qx7k5FHOLeGPW0hO20HSRefdnh7V0ODd6g4vud5xJl1wusF3bzdWQItHGGJnKFA0hUzwXeif/Ema+w0LhdFW+1AcX9d97IKYj6jb/ZMP3yoL/F4QPldRDnOfM673d3/8xUgZBhoOUG+7H17vx93BHUhzt1fO67WIT2zsrFSt5Oy5hDw7WhgfWMet6sya+h4dJmBSD+bAV1nS8kjzNRaShRVnWpIdexRmHAnMlFyqCi2nFOy1juJBDu4/0WqXl2LyXltoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpojpxuIpNgtMmSo2CtH2SKlTkfM5GfE8sI3QPnpt5k=;
 b=s3CJXeuiV/OxaF3Iq/1GwUfRlF+VE47chUjibTTkheWXdmJuXPNk+ildo99sX7UKpqkbXYwSaQ/P7K3nrqq8dAh9St3XFqFxgg0GFecoDpWgFqjYpCxV+s90aZT4QdrGnuDiPO7Egvkxcs8gxY+tY0c8HhrFu192S1Ogp/FuKB7xbQx756UzIMVaBfTlqNQopWpH+f2B7sXfUCrxJ8kkIb61TWcKI3SW1i5DCBfsbe4Jo8WlPf2fod/JI++CQgmMJWr9RViTLd+h5YNkdAg2dSn+wiXKseYMsXaCbkvhM/qwKDAErcmmQUmPfyYCiBrscV7g2MzYp1mR+HVBD/vFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpojpxuIpNgtMmSo2CtH2SKlTkfM5GfE8sI3QPnpt5k=;
 b=YjnF0dc3c/kVqPj1SpYZvEjlDbLezO0AmQ1+D4Duq1eDRoWycOvDU4oPrPRTnOmOs1DnrNSo4S58cXcsC3axKSXbBbVuhQDM+nXAHlzUo/YOp4fPeWkcnbC/ibjxHAnxy3hY96K6753vv/fsUDv/J8bvnIFDpm2X0Q3aCYK0T7oLyWeHVyKtacBSuAdY0z7MeClaVNJaz2CDw5Xx22FxwUaS7bQvDCBq69AVi2R+fu3GAymm2bH7FW5qfBonMjSRO4oYgr7yrsCZvYqtSS4OFnkECrjrVg0DP196a2/53+PNpgvkgurz0fk6sk6/E/tYpKiiVPlS9cw2PFC3wP83Wg==
Received: from PH8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:510:2d1::22)
 by BY3PR18MB4530.namprd18.prod.outlook.com (2603:10b6:a03:3b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 07:14:01 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::32) by PH8PR22CA0011.outlook.office365.com
 (2603:10b6:510:2d1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 07:14:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 07:14:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7EEB040BFE11;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 07/13] hw/arm/ax3000-boards: Add modify_dtb for
 discontiguous memory
Date: Wed, 18 Nov 2026 23:13:47 -0800
Message-Id: <20261119071355.3520249-8-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|BY3PR18MB4530:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1b40a63c-eb37-460d-b355-08df460cafcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|261009223027099003|56012099006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: BG4dv7atpV+cKu/V+c/LEHKrVsMkrkClyh0TXBZVsITI76up7bUbyir7xK55m3IPg89zZNWd+uGRG+VYh6dLbuIywImH43vNmq3jJn/3s2KkgaJflTxOcN2fD7ASPJYg45MPMzEU2SgfMU43xxB4HvruRILU+TzpYwqrqHmxbI10uNHEPDUxPs3CiHqNYLh9IRX5cOYJEzgwxXmBydO9diCrMZ0ulPKTlm9FbRJeiX6P/7+C0D91Xb864cvXdAGkht8Ywk782K0qIgn7mp48dN2LwOtBFnyG3ibLuLu8CASh+pn+Po/8oDQOtc4P5838FtNm7LglgN4lwHrxqCPWfB6sy05h+D0NNid+K+Xmu91ZvM3kNIU3jkgByXH9d+lIZTB97iWCD5Lwd3/gGfxjhtAnKRe7Xm53NOGCqyq8KlPm3qND5MG0ji2FUhcuJHpfw0lwaVqXqhjSFhqKQdTPZJdMQp0r8QAAovRTkdDMfbXhbjFpN0mMJGcagr7b+vt7FCSGMs5EtXIFGmoM0u3WaEkN1HuXAuypXpMmEo6d5l/qf/GgvdhMjtp7imKzyi4NlmN31/luqC6ciZixPQ1Id7ozRIQWVy9QcpoYj3EV5bOP6ZP1K+GiEAknG2Qk3hw8qFeZ+gZUWVo5OpAPGAK3Vq5XcTnrd+dE51f5UfaPoiadhFq1GJXidVROd1AngtrqhF6krmusdmH5itZRENyCCg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vOSIOL5jOWTVU0BNLa8XH6lGiWJYsPG+1V4f+SLwktTwmiV5S4XhMI5Lcu5fRTYx7AfJIUnjFftkMk+yc0UfvM7v+/zYA9bIJMtwunEaFZoCr8nlsOoo3SQaWfi9NM2IFhGNywLOlbD2ybGm32QLuJalHFKFV/a35q4qF7HB6EoWOSvQwM1PQ+KVe2zyhVsKkJ8LwM0gzUUWEYs0Kw6r4ZLLpIKt/UCk4PxQ0IXdGbNVnqZosXHb7x1yO8fVF4SpVzp90sLorERjcV0GJ0ab6rI5uZxJaXUq3q5NJpNfQbLmtCXXF1zdsbvbSn4XLLOTEx7dcxZgyBP8smI9Kx8dg1HIOQuQjO577K+/vmlhYaJwYgdiE1ub2qO6T50A4u6aaPNL7x+5bNaCF8O+PrfwXdopUJoWynTa1GZ/FxxPyJz+QJ42PSTGHaE/BkMuS9VT
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:01.1570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b40a63c-eb37-460d-b355-08df460cafcb
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4530
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ax3000 SoC has two memory banks:
  1. 0x3C000000 with 1088 MiB
  2. 0x400000000 wit 2 GiB

When user boot kernel directly on axiado-scm3003 models, kernel would
believe these memory are contiguous which cause the crash

This patch add modify_dtb callback to revise the memory block

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index bc1f818d74..75e0aedb4d 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -12,10 +12,58 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
+#include "system/device_tree.h"
+
+/*
+ * arm_load_dtb() drops every /memory node found in the DTB and replaces them
+ * with a single node spanning [loader_start, loader_start + ram_size).  The
+ * AX3000 DRAM is split into two banks with the MMIO region in between, so the
+ * generated node would describe unbacked addresses as RAM.  Describe the banks
+ * ourselves instead.
+ */
+static void ax3000_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    g_autofree char *nodename = NULL;
+    uint64_t reg[AX3000_NUM_BANKS * 2];
+    char **node_path;
+    Error *err = NULL;
+    int i;
+
+    node_path = qemu_fdt_node_unit_path(fdt, "memory", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+    for (i = 0; node_path[i]; i++) {
+        if (g_str_has_prefix(node_path[i], "/memory")) {
+            qemu_fdt_nop_node(fdt, node_path[i]);
+        }
+    }
+    g_strfreev(node_path);
+
+    const struct {
+        hwaddr addr;
+        size_t size;
+    } dram_table[] = {
+        { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE},
+        { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE}
+    };
+
+    for (i = 0; i < AX3000_NUM_BANKS; i++) {
+        reg[i * 2] = cpu_to_be64(dram_table[i].addr);
+        reg[i * 2 + 1] = cpu_to_be64(dram_table[i].size);
+    }
+
+    nodename = g_strdup_printf("/memory@%" HWADDR_PRIx, dram_table[0].addr);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+    qemu_fdt_setprop(fdt, nodename, "reg", reg, sizeof(reg));
+}
 
 static struct arm_boot_info ax3000_binfo = {
     .loader_start = AX3000_DRAM0_BASE,
     .board_id = -1,
+    .modify_dtb = ax3000_modify_dtb,
 };
 
 static void ax3000_machine_init(MachineState *machine)
-- 
2.34.1


