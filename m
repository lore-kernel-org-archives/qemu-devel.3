Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CF6C624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i80-0002lV-CP; Wed, 02 Sep 2026 06:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7y-0002kF-W7; Wed, 02 Sep 2026 06:23:35 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7x-0006uI-Fw; Wed, 02 Sep 2026 06:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIVTFcfHhVZC81mI4/YHbQFQXQ7MnsiPG+G//W5hY7dLcqj1iPlB5NYC31HdFkQWbuFqd6TE9n5wunjfiaMu1UKyv7M3zh0ffVRFNGjbsJwmGaCFDyluuGoJQbcxXTIS5jqV1GIPyG5XPGbhHYwazuu4+BKY1bqbV2RRggQL1g6RagubQ6F6F29ynXBDeOmu9wg9AzlL8epdbAp4dPvlUNFT9/AEX7Bbji31qqwfCOepc7MYTRsb92XZGTcl/U8uRQUdEMqYHlCNlyjnLK81248oINYPzbNhR2bImMm3VUWhMoai2pVgcp2Ex6bEP7nnVHYkr1RjvOUDSHOJAwZIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdK29EIvdAPjx/GL/33knkdpNyU21m3mL9mtwvB6Jsk=;
 b=bnUct2wzTHRxF+nwnn1Uoseed+Pu9UaK36v9ekY+zCrAFA0nAY2g8aohs5+i+2Xabnnj7cyivCVcrSn/TahnCMjuBwnVHliUZduQcvzQO5FW64u5AYkW9V8AW8zCz+NUjk75argzDeWO2/3yMcQ2LH97OLy8PkMpSindIRl0MAHPYjE847+uy1+maKzlMbC/nbiqqBcn6DORkioEHUXYRQ80Ylv2XCiIV8eylLinu8iT8d+sDpVibCvTJtGQG0ps+qgJH4L9V8dqoPFNXCr0fL3zYH3M50SBWo6owcXwE7fVBFxbM6nSRtz753DzgsGS6Qjxf8RirKST5JOhuVJjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdK29EIvdAPjx/GL/33knkdpNyU21m3mL9mtwvB6Jsk=;
 b=RWmE+mg8meJsjUcbglITNlsN7r3Mt82c+LKzSojgTvX8IKO4dlhknYmevE8aGTp7pLA+r5vy4Szg5HHBbr1my+9HywqP+/8zdH/ZBDwwBlFF/F3Am+F8m5+5aT6DeWF0VXPZGl4cb47PJTOvNTsu1TXwniEjPFzOqySU1IWk3tcNifGKPq3JGxVQYniCv9Dku+P7aWdI0iwihyfd0syl9MEtqGVUjRIERgY4AibLg+FgTCNJ0Clt3qviJ12oJeah7YH8AaesEW9QReh2EEhhQE/1jEfrtGd0s5fVEtT/8CI/sZGRp7bZ7sd0s0iBUG/dEqaFdyJlnh3AaonGx0sjTg==
Received: from CH2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:59::16)
 by CH4PR18MB6261.namprd18.prod.outlook.com (2603:10b6:610:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:23:27 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::39) by CH2PR03CA0006.outlook.office365.com
 (2603:10b6:610:59::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:23:26 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id DAF0D4186B53;
 Wed,  2 Sep 2026 03:23:25 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 08/13] hw/arm/ax3000-boards: Add modify_dtb for
 discontiguous memory
Date: Wed,  2 Sep 2026 03:23:24 -0700
Message-Id: <20260902102324.3039334-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CH4PR18MB6261:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96dd89ac-9173-4099-1913-08df08dc39e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: TAm0U73wvXZI3cYs/escOBKl1S3aORvaEiiDD6yJ3n9wBzXAxme6r/Vu59HStr3CBdKbOujteunD+VsVQj1bfnenNSr/LRhvEp+tWAfsW/ppY68OhaFlAUScmzSVtqnVNw4UwHNjNsKTcINc0iC87gWXqhqY6r6cyHGbAUfqrmKNUPhkFw98GoflXsQxy0ewfWh3MIBEuKXBhfxAi/8UZsAdh/KAFcLIrSyYe0aNuWJbHbDgRQZqggbKL+5Si3ZLw64CB4GTJEPKICxrqMCqIzcIRJ2YWVvIfgnunc5yOEKTa24RJDUj6Z7j1iS8tU9wiyIrIQdKbQjcF52S5tkog0FyIsoSOvtjMMMLLasg3Wuy/D82QBlwpgwneC2itsYngA/rFhlFNw2IMDNpxT90LZ7zjMtEqzpgBt+52l0nnyEBSwoyzCXGLvn0yuudKunlm7fAoT5gLDhCbv49AelQ1g7gM/682uJUnhs2kyym1jZhfG0mI270Xf23kh+HtWKvh7tHxoGmVoXbX7olxvPAyxo966ioh4yvCBRAImNjOPwruA4xnnN44B/Phb0wHyiWTChVWUq4YEkMCy/DH1P75RQk0u9wsHqGH0spiVtlJse+frt2aIB2qJiDM9FfeHsTvS0owNffy5J9yKwtlWtBdwt0Tk1WRzickzn/34RR404teWY5inhEEZH2CfW8DDL9RJGuPxCJeyk3s4+rwlA4RA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MnuCWrVSHTpPzyfG39ry5u7+4SzCPBLgHdK6ZIJVMDWap+PTm1wpRSTZHx9oR5OtkNVQBy0Sl1R51vu8ttyoTI2FBR8+QhmmHJHH6RkxPHJZaWhm6LGu5jd7bq76sHH3aN7l1JU7AVjldH5VDYVPJDNfGQ0J5hWC8VvomkGbjj4doCXJIB+J1ziwwzFlednaIk2n1d065hnqWXz8dyzybfIV3r4hngH51EX61QzpMsz+vHYJgSUNXvQyC71UribuMOIEX0/MajEaYX2QQoRwgqKgKwU2ymN6MEW2csV1hKYKcBbrAAW6jSu5+bYDSd4kXQnF4d0vA6vGOmZWMQ1NRoNwPhDHRWBGIMHYSgPruCsRfY/QFX2BjfjgX9Gc4CyH1LetCXlVLA7PzRgjwtsE922zk/dgb0x6csskS0Muh4K4U5JEDD01aDwmV4zyCpXM
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:23:26.5156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd89ac-9173-4099-1913-08df08dc39e2
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6261
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 4fd04e42f3..33e936a0dd 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -13,10 +13,58 @@
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


