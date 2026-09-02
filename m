Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DEDC624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i8Q-0003gC-PI; Wed, 02 Sep 2026 06:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i8P-0003b2-1D; Wed, 02 Sep 2026 06:24:01 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i8N-00071o-65; Wed, 02 Sep 2026 06:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWCRyxpENxigUgo/WmFezQwQ7UmwKrb5DAThkUdMJ6cmVk4pTYPUGGEcikH/jKedxv2UxnRuQBN6kisoDHFcNVSvRnL7SICLZ/7scppsauB6Q45OWP9BypVFV2itwsWTnRg5zMMzQwzllKxzVPBLWuagOjnQ3L2qZeDkoPYk34SsJEEUPy4n2K6JhgVGU9UCkz1GwpjirK7YBXhmAYtXPZvDCZMCzjvQ4Zp+V0M2+Y62ZDwSIMKcU6ZGAfgJAI5zBiqYs+0CpIAp7Fs2FnvLfU1Gp5kLZ+oPmOMJmArrdF/c/TA+HUkK0TViPpY8PVQFob5cY0vloMQ/NDxIAbIuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+/UePaqY9ItB7Dqpgh8uiy6W4Q+Ko11anPfYsDeaO4=;
 b=ueb7wK/66qpprqVEgjfbiRQGEk6fyyCnAKXIcT4ayOUrobX5wPMsQrLsYJssRqqHYQLyeJ3uUUa3DKu6O8K3s2ior8slFZEj/iTDZDaZvoLMLKwkX9Ce701vMikvxkr4r7urUiAUlk8o5yyTH8XMhQRM7lzuVNxASMowJSIFaI8mF6p5x0h7sMKimuBBcJRldtGUdRbZE9lVUqOp7IvIcl86tFDzCTMbqU3BcYCN0mQvO3c+eJ4l5aTNrbzykRfJoMOnXzm5/OHRqkKAyaGNYKObqHoL35khKRYBaDiCIoC+FvdDVfRiA4E/EjyJHNsf6Gz9b3xf7VtZCANO9AIsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+/UePaqY9ItB7Dqpgh8uiy6W4Q+Ko11anPfYsDeaO4=;
 b=EmLvwXZTeUuhRA1Gfps1ZyCaDl4bzOIo8tSV9tSxbcFEFSIbMA36q7vXaNEn26Npg35ViVMMrD1VZtodxFDJiPWJAimif8wsBOP31ErX6b3XvbJY9EIZUS8z7FKDXb/8bV1YbIsVGPCqqnbcq2kF/zLHbqRzuaqcTGgt/OwlA0UmAxCX8MBIpS3ioZOgCLJwRLDqF4sJJGGhd3YQwRln+qZkkhKoZ8MDk/fwVOUM3TqJmrf0MbJ1zrZDnikDO5dLGchvsJrPkvIb0+jsNI5tLe65/eZRfPGR32kwHNlI4h/P0WXr5U9QZWrtjN8Zp5WYFEQhqBy99+JJ0EOyM+7X7w==
Received: from CH2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:610:60::29)
 by MW4PR18MB5207.namprd18.prod.outlook.com (2603:10b6:303:1be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:23:53 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::22) by CH2PR14CA0019.outlook.office365.com
 (2603:10b6:610:60::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:23:52 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 2A3EF4186B53;
 Wed,  2 Sep 2026 03:23:52 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 11/13] hw/arm: Add Axiado Ax3005 EVB
Date: Wed,  2 Sep 2026 03:23:50 -0700
Message-Id: <20260902102350.3039379-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW4PR18MB5207:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a47f52f-e720-42f3-7802-08df08dc4992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 52hFnjMm7p6+Vdzue9tf4q7ym34FndVLItsEHlp36W2/p9doyDXpHtdrn2DvMCCSgDsDAFzC2rIQbKgNI0NyWPX4BQdcdtCYnziZ8Fu/AxwT3qJB3JOZhlncZ4cPMG2BzeLSQiDop8Ga7xqauusmg9EskrdA9xJL+tctaFR47Dto+0VOdR3Yn17fUxoexmm6PPKjvEQY89BHqBrMtLcHEsiKjxhy4qJwcxSMuiJekyk3yVR3245lXimYiYYHM9QIPTvnIT3IzVVbv2DreVfiyJsQCn3Wpi43cuLWF+V+TfZatSv8CgSwSJydWukupk3IzHqYlqqi9VPdZ96HMLDYI/1yba+sU5KtdWMlTW4NutyzeiHfbP47m376WyX8y73mqFzDVlnQycYSbI23/BoTEAllKw5NRHHl9AwFLkd20X2HW6cOXiUkP5zPAziAWkC9ilu4uf5rRrN1VmNyBOj2EvV5uT3mSE4RKAcj+fhxAU7UgcUIBUlFF3Cp/8ZysViD+Whr+lgKMIN7ZbWCaRT5aHSPATcIBw+K3SWffvDfIVvgwVtVfX0h7mVBFVesoOEAsoofoX14e3U+Zj7fKq0Hgy4p4wd80hnhDzrJ2i7A+XCYKTwLhLirl3gwBX3SaRDq88L+Vnptva5ncJbcbBo5z9yBnDNRIld9wa2dFREXO/2HXj0WuO7qp90Ac3CRk3lT8Mh71CVF1R5KizYz4axZAw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xCvMHJYhFtNOypXRTiQO0pj3zhLgeKANOp3mXXBM61z7BPelpKg2OGNxsNqBY+JJ/VFYHOlDMZxeIR0aoBma1HXONduOp1v+/rCjPaBcWRyfW+0XJXeHGgGiraGF///DF07leahLKLzsgY0AFyyKnlHzvdSMid2hjH5BJ42ySEnfVBnnqSeOFRZzyglI9tRsIh4/tBIFPYS6VlYUe6JshwE1Zvq6yBXyapGRFUsjx1c+UqAPSvATLLO/V5nlvwskUr9UtOXkoGeSoe7fkCYfZsSyY1UqmMrP/JDhYNuNnDYvCBiftR3RovRQbt+30tYYA4gnGarTG6yf18bz89A5blsEzU63P3+o5uMI+wKld4I/xLMNhKfn+IK+DLdbWqdIgOP/SuZQLpMD5lqX5T+e/F09XoY+xiDwxPwVu8tg/K/9twauiOY0GgiYIyRBQMtM
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:23:52.8334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a47f52f-e720-42f3-7802-08df08dc4992
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5207
Received-SPF: pass client-ip=2a01:111:f403:c105::1;
 envelope-from=kchiu@axiado.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add EVK ax3005-evb built with AX3005 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3005-evk.c            | 117 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build             |   3 +-
 include/hw/arm/axiado-boards.h |   9 +++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-evk.c

diff --git a/hw/arm/ax3005-evk.c b/hw/arm/ax3005-evk.c
new file mode 100644
index 0000000000..1330597e6e
--- /dev/null
+++ b/hw/arm/ax3005-evk.c
@@ -0,0 +1,117 @@
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
+#include "hw/arm/machines-qom.h"
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
+        .interfaces    = aarch64_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(ax3005_evk_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9fceb8d2e7..8d9c602b88 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -115,7 +115,8 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
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


