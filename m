Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859C4C88E42
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tdD-0000qI-Tl; Fri, 11 Sep 2026 01:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc4-00009n-Sb; Fri, 11 Sep 2026 01:15:50 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc2-0005ka-1W; Fri, 11 Sep 2026 01:15:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeqyBU7agYHzve1xWOb/2kpCKezOBHgCHCeO0/ejXOh5S8tsZDuxgazO5NG1EggF+cSTGvZTFaduAqOw32nE/4NmAMPRi1z1JFj+3m6vYq1W57igG6oYKLye1brHj6PEvnQmWMLpxxGB2Dv03B+hdCe8NFZ04HIAmk59tOrRq+q7F7tZYSCh8jRMKGimv29hP5E4rNFqANvzicJs8YaQ90eiXenNYiFmdMkqorWJNeXWbWE/tvES6M1NLa4WM1blSh+0hYm/cqAyNOE8KSJu6DwEmuw7pbTmp14Stx79gAivTIBI11FLX8xYA3GGmsLgUD5qor1hraQfy8OhG1dEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpojpxuIpNgtMmSo2CtH2SKlTkfM5GfE8sI3QPnpt5k=;
 b=gxl9aIvLXIJeYkUoUnVaGIblYqJcpEYNLwHONfTut92dIbgSgV4GEz1ij9jSI5xgeQb6qYCQ8D0kwrKgO/Y91KSq5ZLXAQDCHFOAoFzI+Lj1jdpScrg+S8t0UPmFAOe6E1ogy/LBDnnlQ/lj2y2pIfMzDouKl/ULHRQx9XX/lU952msJlsdKinho2DfkrOz304Zu6NIKUPnKShrPmMVu6mSePN/sLGCrOId1FijurPpBa7/JRoHXoOWLXxI59utDcva8a8Y7XElbQi7vN8F3iC1OSTzc4acMFxtjNobav2q/6jfD0mUoc/pT665nt/ucc7bW5AQX8WgV3cyrBafo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpojpxuIpNgtMmSo2CtH2SKlTkfM5GfE8sI3QPnpt5k=;
 b=ryLQL4/wvBbuTc7yOUJ2vQJAWzUeIeIDAu0cKfO7tEyZb9AioP9U24psyYIrxq/Z984sSCO7orpepkFBhyqMCeMpTUXFxSiuLm9NyZ02GLoUOXB3NPmt6ku+iK2e4dtxpxMwxQdPC50/JZCZqcuG89GkL6B0swzCJNRYO21P9ZgrrtTcCeu440JVGK6rJZLR0M/lOornmXn2MQypw1YDMTRT1PiX/lM5XLOOiXebtq+B8ThxwzCdtfNGYxL+KRr165YvfHru7T72ZrnlQz1xaX+ai0LXTOOTw4gM441KnhiZfFksbVjtKVAfvl1lt03Uu3Tf52P5JCJUd3oMNxLHIw==
Received: from SJ0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:a03:33e::14)
 by DS4PPFBE7AD12A4.namprd18.prod.outlook.com (2603:10b6:f:fc00::abc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:40 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::83) by SJ0PR03CA0039.outlook.office365.com
 (2603:10b6:a03:33e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:36 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 14D6C40BFE11;
 Thu, 10 Sep 2026 22:15:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 07/13] hw/arm/ax3000-boards: Add modify_dtb for
 discontiguous memory
Date: Thu, 10 Sep 2026 22:15:26 -0700
Message-Id: <20260911051532.2378501-8-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DS4PPFBE7AD12A4:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 356d833e-3b84-413b-cf6b-08df0fc3b64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3EtBIhxxJD6bAUHt3V8jXmjItWGJOHUlDhH/yuZ8D2N4MnrhiyM2nEAX4K18B4cAHtSRdXFuycqkc14pkbjKRaRSSG0GScJ4O6W+A6AWC4kXs3VVWVL0a1nvzLJ6ojPkhO8Sl8Ril+J8vg9XmIQXqxjwu+G0XPM8/kHxc7iCvrhpF3IRkQXpIkjZBn0xj8rCRMU5N4hXbvuEyjit6yjyoLrXtXC+Ng0NCwKxFvttvaQ2R/MuiSCQxAgyci7XpD2OqlaxTB4SApgy87WKEm3M2W+NwRLe8VY07O4k1aGCY6WUzM1ZdeqyBmiWMsH8bx45hAZ4kjVWDBu538WInba4pcfWvVXIQk19uEmksnp+Wnn29WL/OL+PHF0MSPKlbs5lR8fBKag7rJsLbxxXkJ7IudJSez9hjGhNIivsRWJOgVBgV6/P1I52lY151nKMi6lHo8I5aVil6+d7WM0EfO3H0puBnW8oc+jqsMHK+em6haYwmPRB0BllwpJr9966lbeug8x+nmxdXF0M1dOtXEm3euFvnZYK4XFwK8QQ0rccOi2LMksb/dFbN5mHeZL210/hHwUDQx2+Jh24EMCqH4WzcYK6oEbgLEDu0MYYhwU9lfu2ePtCY3htqmKkd9xJ0aX36Y2NSzXYhwebcuukEMfTsplaA1IBU2Y6Nh5Rw2fipP0+xzK9ZBbarIlTxEbhJkSiwA9r6EIYjQ0rKAo/UUdHyA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pAkga8gudNlz62oU5Wr3CFYBePfqrmV1nL1LBPHh/qgXJd7j9R4MC9U8YzISNltXrkgLBe1YpJMl0IJkkV2/0YX+s4/iISIfo4Ghg4r0MLAHWtGn7jSE/4upVW0AqlZq6X0ja9PtIl+p6MCZD7Szmq3fM7XM0zOnM25nYva2xT7vYix9sMwfiYMzj0cirnoSVPh27tLtHW8xZEire6mO3/sRzXHFOc4Osha92TZtOYVnnDOswrbOAy46bBFb1Ez6FVN//3Wno9B1yjeJlzx+4Cpa/kMBWf6oy/VFbiysUJlYwCFRPhA2ohtsa3Zk+wFLLXYdc0hSaYyvm7gj3MN3eXd2DkDoLkVFSU/Gu8L4gbv/WHbvz2BHVeeiAFrXCFO/n4F9ksoMeHtswE87MU0bOtwNaacfAXf/VVQ92dgAjJF9/aRWl8D5Jg/MTPZrD7rj
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:36.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 356d833e-3b84-413b-cf6b-08df0fc3b64d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBE7AD12A4
Received-SPF: pass client-ip=2a01:111:f403:c101::7;
 envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


