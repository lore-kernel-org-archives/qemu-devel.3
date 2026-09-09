Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3001EC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyF-00042s-72; Wed, 09 Sep 2026 06:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyD-00040d-4a; Wed, 09 Sep 2026 06:56:01 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004G5-Rq; Wed, 09 Sep 2026 06:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGw0x8GzL4lMMvxOzahC9QgzfVey/DmbIaB4TPHpgnEmvTOOxDKWIWbmPKp451WAsb5ucA9YvjytA5FsYiFujQ8/IDdY40XPb99SC8loslmMgyYCI413t3nL2HyEUinui9cmHFhRE+4TfbUo3yV1/CYxPkf2jaIwXcI74RyM3oAlAqhVoDJwZniftfrWXniZ6BHgQYswIdqv89XHz0/ZS9bdusMl0StbYS5ssu56nMQtVsOZjSb0Q7MjleGV7+m5Z0O01K8art4q5Oy+U71RbI0BCss9oSP/EcmU0YUC20k/q6oEPj+7aYH6ZFGvraFcva7gMa691eCluaAh3fAWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpojpxuIpNgtMmSo2CtH2SKlTkfM5GfE8sI3QPnpt5k=;
 b=pMP1jX4fwuvY1xXHcle56eM/L4Ql1lozFDdtDFj07U8XNdJPdS8QZXMinPoTvnyFOillPux+Z9IQ14m4+b/ytw/wEJkshIYRBmvb11agjHjE7z/AYp1N/mHiwVtCs86g4Pqs77GRa1KUJMIfOg6ToR3cUQNwTMm5KC8MA1sj6QCr4KpalXPpmctzmhILDaOkBoPowk5cnpE5HHSMAnZ4r6u+iJS+zLM5SWhnhm4Co+N5P7fYrT1aD6kVZiV7hqbg73vGoccitbmHcTFTHUytRmUyUKRdqiqC7ThoThCGMAaG8jV4Yg+ul1LkGF5c4xMCMq65iYFcK5iThGewaGCCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpojpxuIpNgtMmSo2CtH2SKlTkfM5GfE8sI3QPnpt5k=;
 b=e9dr2yG7FI7uYD+jMpCkglBHPsyMox/vwAS0tm8G0g7mznYJchKpRoToFATYnUgJH6L4OnYhYsKjZQbkdauLCBvWbLl8fC/rpMC2kn9rrU/ldT+y7hGx5FXzr6+r7JpFIFB80iwMxwl1sIGlv4ZcwrW/Xlr2OJ+Mv14YDuWgeyp7t9hGu0gOEceEFZ21dWhXt3+zqlWj4W8rmRcdy7Db6FRf5MnDTlfxllOeKS50bBQlMDn1VDvcdNMBWRzTcrxM4kEbcu724Q7JJ3MpvycDKpJXZ4DLwWpf/3aloDsin6BfCk5qu3AEhqGeknV8BRz8/RSJgFhahlO8C4e6SiuhDQ==
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by SN4PR18MB988541.namprd18.prod.outlook.com (2603:10b6:806:21e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:50 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::9c) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 10:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:49 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id ADD8B40BFE11;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 07/12] hw/arm/ax3000-boards: Add modify_dtb for
 discontiguous memory
Date: Wed,  9 Sep 2026 03:55:34 -0700
Message-Id: <20260909105543.1478008-8-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|SN4PR18MB988541:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 255dbf35-126d-47d6-38f7-08df0e60e923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0l0tCDdvIjfz6tSf3gXBN7zF/3QIhpA8RFoRCCqvlF48hVVnPAC7ENEH40ZCOqjHbl1d+kKSu4PKeyXCFo1iwxT1Ytt3ZX3c47rScVQ8bitc+QCvTkmMqxwPMiR6xz+1w68xBiCK4W7q3C7ZCBSo/vvnY0dGqVorvAobqzLqLPxlHZ7MR38aLSHXEmWAdwRsXZA1+opuUf7PuO3SZA4IEZ3wyomKaLx+u3n4zzir/MM3MrnVRG8iryy+UNmrWgHlJL44Rb/yBVBNhi310N8RvqwSpPLGAfyeFuYtImcVPeQhJPodyfX+Hz4udCwrpejeqPIbCbUaY7M8+/zEuwE2DyYzgq9Fi7C2R9jHNk5eb0KjczyawxJ0Ds0X36FzT95k8I3b3ngxkaro4zF2CsSNfnsXOg7b4nJmDuypchtc2oOBFXslBZv0QeVMKcudTuozWR7MyxN9y4qa8c8/dYpfXpuFdXZkf6WLG4iXTrGhcrZHY4FqdetVWGuDS3PG+ajw3vN0DfC7JlLer0oAjGaVU4kv/rbLs+mCq5lKZ3Q3Y9WKndkepaNiC+30PlO4rmkJrha8lwHrjKe8fpcDSFmQDaJ6CAJVJowbQCfywA2ZPrlDk7ygvSR6egojYjknkzr7BC2oyNwkP5v+qz/txYgurMWltVxFbY/2Xuqz74kB1EB6itrP8HAbmzZR9R9JjDFNpQA468bbiBUxvqJ4JtUtEA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SfNSFYo88UTeCUX6jiRkXx6ketJKrPMGc9UtV3OCyZED9zzlnb3kifkLTk9GT6g0tSXSZCR/RUPN6B4PB3YBQaYOIp9D8kCiW4+kEA8yytxjIZOrW8ivADK4M7B/ZiQVOaLYCglmOicv/3yy9mUCiZYQ3cgx6YrMK9MU4Z+GcPuXkFqbjxZDTCcYnpIkktQUHth1rj4JwPDFDEYWbDPmTCaUDDFqtCo5aLAVUN39xLS2CEvwRN2we1SmZNyikl8S0mLRB2lpzzf3URSj3qAYPsqfxC6P0hunfa4gIfYx+Z6U+v5hAxw58Xp4IrPWa177k2IHXBDpuJ0oPeiXwfRjQ7H/eQMu512Lsv5+NIWnVjAde6GQZDKHGIcHkAJtvBfTep8pfd8agMzlT4x+IbpYzlZBBuPSsXVKd5B7aKJRbDRl2V9c+65MiEKXXUoeQ+L8
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:49.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255dbf35-126d-47d6-38f7-08df0e60e923
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB988541
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


