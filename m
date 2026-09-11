Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E86C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tcr-0000Ko-E6; Fri, 11 Sep 2026 01:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc3-000095-KV; Fri, 11 Sep 2026 01:15:48 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005j6-J8; Fri, 11 Sep 2026 01:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUX7j/+NjKIcydvAqhv9+iuYpKVdO0il7Eh0jNT+M3O3xIVb0QUQAsLv5KSIqANpFJagFFl0Htz2f3k29OkGNHDHwQmLadHxyrQjVWAj0lYEVXvYdAOBqNg8UZFEZfO9zvvmx4rkgyt2mEouQrBkbL3bYKcAdVfmR7BRTLNfuyivbfOi3kBykZqBHKdo/3Oo0ps6Tw0H4kjulhmenb/9xd666VyRONDpHHtF+NLu07/9baCmXgxmswhL+mKCJnTH6U3ZB/21K2zbK+z6px6JPTcIlQWYEnzNokaqE36UyZ4ahp8FJzYcGz8DY/bn0JQllGMuZXR1DpTO1UHVXdtfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDENCHauycl53NGiQnktHkQvDKsgoGYkzobA1FzGc94=;
 b=y/s8S+rJJkn+pOosIM2D7+kUW6yGSDbLfsN0TLgcsU6y+ctwu13ezeWPk4FlkCSHKVdRHvwh65CUKauhsMsuMJhWKEslobse9YW8EfhVjnxBButczc609s4ucdE42ocTF7Eb6fnA/mZbTHpH9nVZxoeAyNTVtfeQRLFdOYB7LWBc45FarFupyDQf3VWcKSroXjjU8k5n0WByzuT93aRgz0KBSSlUd9FEHSZCbCKxtZxfz55aZujoJp+2KqQTF6/l/XwUm4rEu/qGbTsehwMwTCpdk9jNi4TJmXXlUSrcBdfqc2IRMq54KhE7VLC7CW9oFZEFA6ivEF7Z5XhtMaZbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDENCHauycl53NGiQnktHkQvDKsgoGYkzobA1FzGc94=;
 b=ciXU6+g5tiC/har9DbL3PibBSFp/beuXz8y+ID4cc8OQyoknxH8s6I2+bHFPy3WyJCF2rmvJb4AJ3K6iJ9Tcl4vydUNUyuDM0CYIukitIgg67AmZctcu/CEjQxBvrsQtoK0oeeW2a4YVwtOxktPvhBFG3duHWtoOiVutm+I65rtFgrjJ2dCLqR4gYl8YXwbOui3AyydX8y5ZXGLTdLuFgL6rewIvTRH82VZ5Kuf5LS4B5ZDtda0su9APx3DtqTGPz1wuzbSgs2EE2jsKWTLkYeDOYElwG9cA0DTdYAjK0Ce+YHI2XuX49oekswh+FkwrO5UvaMJr3fdL2wgMuD+g8w==
Received: from SA1P222CA0066.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::21)
 by LV3PR18MB5779.namprd18.prod.outlook.com (2603:10b6:408:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 11 Sep
 2026 05:15:38 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::5f) by SA1P222CA0066.outlook.office365.com
 (2603:10b6:806:2c1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:37 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 8491740BFE16;
 Thu, 10 Sep 2026 22:15:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 11/13] hw/arm: Add Axiado Ax3005 EVB
Date: Thu, 10 Sep 2026 22:15:30 -0700
Message-Id: <20260911051532.2378501-12-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|LV3PR18MB5779:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f2f78ef4-463d-45ad-a7e9-08df0fc3b72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: iTb4TV/ticRFYBMJFvzwdgTCuh//8d6L9SFayxpYw98uIwzEb6Gv4qlzbEAtv7qDwghDK1CySTo3yMSUKnSopMA5p7NywvIj2XoM7MZfHcEn2AmXh7VE5KeI5nRMXtHZsOR2Ul05VidY64RKHf3efHLFUXKJpzCc6eeNxTPfLyXTO1/duStEmMXWkl3HleFhPajAi0iLW2xnVng7mfTKfgQtF0MOycXTi6tiziy65Y6osSkvq7FchREVlKPvzx93xgyDMKqxgPW3qjVq16hqTBBXDfCnxT4uxz1JYY4Wcgegsyg/H6viKVIP5CeUum96NOOHby0b7pTetQ4KQLdJezDkbYunA2T1d7A/hPHX9KW/njy/ahmZB501Fayzq3p3A6JSLl4+32ZAiXJoZ47I6b7mSCQkgPZl9ylHSxN9Gzt0aEeUubutnWGRIKKEx+r9YVmBiP/ZOlVU07ZIQ/SyAqzCOgaEFZ5YKlm+2Q0B45tiwvc3hdg4yIVUQxRqHqs59IhzfEeYq4rhOvJ1NBwLPk6zge15SdteJerVXA2TiyFQcNsbsVsia8I6VLJ1qe+a7jSYNN03iyQwOyzsA43xXuH/07yBzd6WPACZtcdHo+fBq7yYl7YlN3z80igeG1MPWlqeViINTMzq4WBFqhJGa5EbXP6fja52dpR9WQ1ZW84B4YxY+O6PeBNFQInahz7HDZSx2n5Udps4ew6X58Rr3g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AMMt9zaxAuJX8YnmNFSb/7iiUBH/IXp2bCkI2ckQHUNVJIqa2HLoGA1B12C7xOe6fg6iXR0zGmDb/SJWFpc1tJO/0hJI6j7JItGFOijMlFx4okhUWZPZ1zyCZ1kjbP6d0PYYuv5SS6s8+puK5Zcr93H6hvp+wSDc+/gSIZiGGiSogYxE+ioxzwTGGwmKvYBqxjHGPJkM7OLbeD/tg3q0t1SDQ93PAEkJeNA+sNJ/YuC6J05XAA1a/bQTDMdrjRoybenu+9XbpY6mU9tJO3IjgeV19Pr5Nk4x28DgMp0yywsvT+2Dl7GS3UfP2mMDCWN7+69Ft2cX0YjR2cP1CDSvrjO/fbsAK5+KVOZZeZvtpSbURR4O73KGFAKDDHKNxjzgLQKllBNsrgRYBWOpxR/0Vy2r1DshIhbNs/I7YFsH1ZhxWaddtvVSyYJFYuLLaPkg
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:37.4772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f78ef4-463d-45ad-a7e9-08df0fc3b72b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5779
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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
index b6a036c953..3ad06292e5 100644
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


