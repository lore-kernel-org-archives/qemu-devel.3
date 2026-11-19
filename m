Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E0606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=WwvXhi9H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwMR-0003QI-0j; Thu, 19 Nov 2026 02:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLb-00032o-EK; Thu, 19 Nov 2026 02:14:21 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLX-0004Kj-Fp; Thu, 19 Nov 2026 02:14:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+n04BGdVbwngMZ+wEKys2VzQou+IARflEq9TCfiaqCV0e4TVqSUSTtG+f5WTc8H1O7OXBPVqunHwPZ0KRZPyBK+JiZSrt+Kh4Me+KUYb8pEfCTIoAg8zh/ILpvgpPv2uQ0EMfwvnJzJW+ZFVVytDROMVrhKqG4s+GwBtjnfk2kgbPwTsG32hGu8yL0xUo6U9qTZcQrNd66YnZYGh0oB37YY1R4qT1fgs6usSQ+lk4AxUtVfWX4DVIVJ+YM1sUwCQ0oxVpheCg06+0Sy64LkcR8/J0yS7KB9tXtKwIDWKNuZrhkNE9UvEcslgmh3YtYerDbUEGVwTOaBIXGjz6pk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tq/3ydKB4tLApYvl1AcAT53jQkswj0eYt+ASGzl1/M=;
 b=xdhbwPAFAYHUphXmH3uJxQPqJngbC0SuGMGKcWZAm3gKfjBeojEIm3KrtNHdf+zH/RwfrIA+w1qY4LaF5j/6cCVMP0a/Mz/kGhzS6Y7Ymhqv+eKBTWmsOXuXv/PsGeVnT+dj81RPfpnF7LDunuh/vdw399DvykOuFbM1kfJBgfkAXl4D5qOji+AuHX37Ar1MoHfExnxX8H3kLp/QuOwneLmJUT++qt9fpXxWVmHmaGx1U7f5lau5PWeknPissMhRK3sPl6AgZig0kU5Nsa5XJw9AkniSdPjt8GEVivgNtI2C93gh4oKgJUCrHW/4XTorreU/iYBPCJ1RgxDMJxoEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tq/3ydKB4tLApYvl1AcAT53jQkswj0eYt+ASGzl1/M=;
 b=WwvXhi9HWPcTQbWLrOv1rNmLXZvigxppjkUKnNF8sTz01QiR9AislobYKK+mTcwBKtnnkZBhWuHo/atllwtuIiNePhWrfj1cpwujh1N3bc9WVt50DKW0RDKQLdlvBZ7H+AodVgbL9cmgChFfqHh9f6en931oe9iUVcHCJOk3TO0DiuClBrmJ9k/emFKFcML2z5hvMjTj0HyKwnI6LscMdNlIP1MMDcCBMfvG3G0YSfwIKvRPtoxfyhaQwEM5Nmsfsf7awJx3G1y3AUEe6eYWle+Hi39CsIFAtY8gW7AOq0zSUc+FduAcpbwmvmvdB/oaYe2uqt90tA9I3zwkk74k1w==
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by SA1PR18MB4661.namprd18.prod.outlook.com (2603:10b6:806:1d4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:02 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::5) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 07:14:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 07:14:02 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id E6D1D40BFE16;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 11/13] hw/arm: Add Axiado Ax3005 EVB
Date: Wed, 18 Nov 2026 23:13:51 -0800
Message-Id: <20261119071355.3520249-12-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SA1PR18MB4661:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a4434f3-e21b-4936-0198-08df460cb05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|261009223027099003|56012099006|260925022911599003|260925021311599003|260925021911599003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: vxSqjwvp5auCJg7o9Iu5LusqKNfC4RZ86Tw5ZAWlujdHihWVXXPYLZOZaLPYgRodrREOjsUPn82cIWsGpAFzbj9MlXd/n9lxVksYOwkXpJHUC1g7fpJlD3euSpD8qYIoOBKrOWsG5N/NDRS0714E8IxlFbVlDP8x57a6mdyFegGUAGFet3tvI9KLLg4Ax5KWoTj2E8SlSRUw70/P2IIaoeQWwanzhAyLBuriB4z4hgrGEVHBNt3uIz9k3ytAraAAn5PzS42lZ5Jyurm/mXFyepxUzk9G/hUacRuHHRMIMbAcfmyx3io1pu+VJttg8PCzGrenvvshqXnpt+OzwfFHuBgBQG+QSTZyJ4vAtJaVhhzwA7Pkp0rH8AAYGlEBVg/8yolQHJBM7QyQwegb2PMQ2qfrfr7l+ROnkeHykN3ruXlkr6d7dndFI6vSGy5XLbM4xzWbkK3dKu2/VjueEc4R3AiIaVeTzgV0Bki9f0Aw4Lv1gVXcSfUCDfp1TxGt7lJlBexEyTfnoqNrEgcFzVOSfdfE5ujKE2NQmDNMLnykTUF5PRk2PEEFKAA1MfsJFBjYSBZRqkiWDvLb5R6T73XjYui2eHzyACqR3tgx+j/O3smvkDNo7XXzGp9aiTz/xOHRf1ViajpvY7lKy5UlY6fuR6I9aWGsTi6Q0ZF597POjdh3pAcJltVudbPQpBerWN6Q
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +SSiEj5Z661ue3+RLjnY23TC8mex5WA5tsb/+22r1pPbuVxmk3p05VstIOoi7imoJbegqvdTptKrhaLpybJciz/Pe9dFYEnpD/btqa2v0AtEXYCkQmy5xW0ueCJqEr1U3UT7Bkjkn77LsBFKQDwRo1O9AQFPVFQDh2UIVN0oCQr6AtaZwkTKf0on/NsagG/GhTsQXbN7DyY/Ixw+sGqzWqvdr9cHlqjsDm9+Bp1He9wAch+28nqA//CtaiPVlKcGtb9okXJP7Jyicz8Xn4PMgrsI1Hzw/tyoi4wzXS7PWBruRlwsZh3USR2qUibg74Ol1uffQHXNe52pHbZiIkdonzz4QkHyzl3sp/wcUKtwZ0xQwRjClSW7JXVFwkls6OK4XyUHqXIEe6CRpC5YbmUnoJMd9TY8Cfiliv6Mkqk+oOvPT82zQj8Ze48jhIqEft7v
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:02.0805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4434f3-e21b-4936-0198-08df460cb05f
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4661
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=kchiu@axiado.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add EVK ax3005-evb built with AX3005 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3005-evk.c            | 115 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build             |   3 +-
 include/hw/arm/axiado-boards.h |   9 +++
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-evk.c

diff --git a/hw/arm/ax3005-evk.c b/hw/arm/ax3005-evk.c
new file mode 100644
index 0000000000..0bc309f244
--- /dev/null
+++ b/hw/arm/ax3005-evk.c
@@ -0,0 +1,115 @@
+/*
+ * Axiado Ax3005 Evaluation Kit Emulation
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <libfdt.h>
+#include "hw/arm/axiado-boards.h"
+#include "hw/arm/boot.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+#include "system/device_tree.h"
+
+#define RAMROFS_BASE     0x90000000
+#define RAMROFS_SIZE     (100 * MiB)
+
+/*
+ * Reserve the ramrofs window so that Linux keeps it out of the linear map and
+ * the phram driver can hand it to the guest as a block device.  Any ramrofs
+ * reservation the supplied DTB carries is replaced, so that the reservation
+ * cannot drift away from RAMROFS_BASE.
+ */
+static void ax3005_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    g_autofree char *nodename = NULL;
+    uint64_t reg[2];
+    char **node_path;
+    Error *err = NULL;
+    int offset;
+    int i;
+
+    node_path = qemu_fdt_node_unit_path(fdt, "ramrofs", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+    for (i = 0; node_path[i]; i++) {
+        qemu_fdt_nop_node(fdt, node_path[i]);
+    }
+    g_strfreev(node_path);
+
+    offset = fdt_path_offset(fdt, "/reserved-memory");
+    if (offset < 0) {
+        qemu_fdt_add_subnode(fdt, "/reserved-memory");
+        qemu_fdt_setprop_cell(fdt, "/reserved-memory", "#address-cells", 2);
+        qemu_fdt_setprop_cell(fdt, "/reserved-memory", "#size-cells", 2);
+        qemu_fdt_setprop(fdt, "/reserved-memory", "ranges", NULL, 0);
+    } else if (fdt_address_cells(fdt, offset) != 2 ||
+               fdt_size_cells(fdt, offset) != 2) {
+        error_report("/reserved-memory must use two address and size cells");
+        exit(1);
+    }
+
+    nodename = g_strdup_printf("/reserved-memory/ramrofs@%" HWADDR_PRIx,
+                               (hwaddr)RAMROFS_BASE);
+    reg[0] = cpu_to_be64(RAMROFS_BASE);
+    reg[1] = cpu_to_be64(RAMROFS_SIZE);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop(fdt, nodename, "reg", reg, sizeof(reg));
+    qemu_fdt_setprop(fdt, nodename, "no-map", NULL, 0);
+}
+
+static struct arm_boot_info ax3005_binfo = {
+    .loader_start = AX3005_DRAM_BASE,
+    .board_id = -1,
+    .modify_dtb = ax3005_modify_dtb,
+};
+
+static void ax3005_evb_machine_init(MachineState *machine)
+{
+    Ax3005SoCState *s;
+
+    if (machine->ram_size != AX3005_DRAM_SIZE) {
+        g_autofree char *size_str = size_to_str(AX3005_DRAM_SIZE);
+
+        error_report("Invalid RAM size, should be %s", size_str);
+        exit(1);
+    }
+
+    s = AX3005_SOC(object_new_with_props(TYPE_AX3005_SOC, OBJECT(machine),
+                                         "soc", &error_fatal, NULL));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+
+    ax3005_binfo.ram_size = machine->ram_size;
+    arm_load_kernel(&s->cpu[0], machine, &ax3005_binfo);
+}
+
+static void ax3005_evb_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Axiado AX3005 Evaluation Board";
+    mc->init = ax3005_evb_machine_init;
+    mc->default_cpus = AX3005_NUM_CPUS;
+    mc->min_cpus = AX3005_NUM_CPUS;
+    mc->max_cpus = AX3005_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->default_ram_size = AX3005_DRAM_SIZE;
+}
+
+static const TypeInfo ax3005_evk_types[] = {
+    {
+        .name          = TYPE_AX3005_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(Ax3005MachineState),
+        .class_init    = ax3005_evb_class_init,
+    }
+};
+
+DEFINE_TYPES(ax3005_evk_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f54aaffef2..434cabdfd0 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -117,7 +117,8 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
   'ax3005-soc.c'))
 arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
   'ax3000-boards.c',
-  'ax3000-evk.c'))
+  'ax3000-evk.c',
+  'ax3005-evk.c'))
 
 arm_common_ss.add(files('boot.c'))
 
diff --git a/include/hw/arm/axiado-boards.h b/include/hw/arm/axiado-boards.h
index 566f22cd96..0f2c586d40 100644
--- a/include/hw/arm/axiado-boards.h
+++ b/include/hw/arm/axiado-boards.h
@@ -11,6 +11,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/arm/ax3000-soc.h"
+#include "hw/arm/ax3005-soc.h"
 
 #define TYPE_AX3000_MACHINE       MACHINE_TYPE_NAME("ax3000")
 OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
@@ -24,4 +25,12 @@ typedef struct Ax3000MachineClass {
     MachineClass parent;
 
 } Ax3000MachineClass;
+
+#define TYPE_AX3005_MACHINE       MACHINE_TYPE_NAME("ax3005-evb")
+OBJECT_DECLARE_SIMPLE_TYPE(Ax3005MachineState, AX3005_MACHINE)
+
+struct Ax3005MachineState {
+    MachineState parent;
+
+};
 #endif
-- 
2.34.1


