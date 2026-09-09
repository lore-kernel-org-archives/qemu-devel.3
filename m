Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF069C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyD-00041N-H2; Wed, 09 Sep 2026 06:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyB-00040E-KL; Wed, 09 Sep 2026 06:55:59 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004G3-Mx; Wed, 09 Sep 2026 06:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMCKFlu/bvW+WUwWz9yobDzGnk+HqQC7O9dHhAGjMFjqbnP1lAIXkpaRtlF5ahzGEQvW6SpF7sb57KOTsSlllpBvr8HETrWmWfDqGYoQfyme46fqm1y2qPCoiYW6bRuxThYbVwOesbdzeM+ilQCsed3TgNTQjox3pA7P5BSCaLQQClOHsKCDFB+VO/Lb3JoPA9VDDMr6JUUU53DjFp+Xwln3KemS99MbW+ObcvvpzY2JW9BoblyGgJVTO4h1K7F4PoM6vYjSHEahq1HgzabBJEZpEvZFrKFhfApKS8BPfMqsMs+DJTGHvar1fAV2SWMoy+G5rdw7Z03avpL1x0YFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDENCHauycl53NGiQnktHkQvDKsgoGYkzobA1FzGc94=;
 b=TH5jU91Zzdbdf50WHfxv2BB2knkda3xAq4h4TYzdmLNxTPVzizfZcCITAdotdxJh7CVezvkK7Q8bT9Ze5WWOqTGYdUi0EZrPTtWUgK/ZjKqRr2S2TDsRjl2SxMzH6jLNrX1cZaiy60QigAnuABeyHa/UE0yxUXF4Xman0iNewqL3Qj7NkdfKZ1/aMoHg0zZ+MpcbmQqs7FJs3+Uf2MFmAgRgXKQOE5XwsjfnP6atrb2KLPagassW4wj2R6fI4Eslh/FazfcR3s5SbSjTxhCgIuL7APTY9WNtQ7PAEtDW6ZV/dwDF616KrDjsqk5WdpAbwm2RtdlVw4n3xso02zeIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDENCHauycl53NGiQnktHkQvDKsgoGYkzobA1FzGc94=;
 b=DKx89HjDvVgReT5O407URcKh1FgySk3t2J5UUhINIdca0qh5XJErZhzZHDIu3GqPmUa0RPmlGkcjaLqEENKmbEueH7dX8s9d7RELHSkC0uTXX8NbotL2sV2dh4jcDvHl3Kca8SOyH64nF0Mn1ANviLJ9ETIBi2S/X9zlImlRbN9IioKXENGA/38xTFjNxQMl7egWVcw0k8reYpOWQ8lDTgy6tqijMoM0MNV5Pu22x2lVY4836KqHvZwPn6FOuRoIx0GEha9mJJ/6sNvWL26aMGrEr8UOjNmGMspkDvU9S58n79mIddLSEvpnkL3aMX9tleHyMvrg+RQsbA7aexr/9w==
Received: from BN9P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::15)
 by CH9PR18MB902990.namprd18.prod.outlook.com (2603:10b6:610:33a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:51 +0000
Received: from BN6PEPF00000070.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::4e) by BN9P221CA0021.outlook.office365.com
 (2603:10b6:408:10a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 10:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN6PEPF00000070.mail.protection.outlook.com (10.167.248.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:50 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id EA6D340BFE15;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 10/12] hw/arm: Add Axiado Ax3005 EVB
Date: Wed,  9 Sep 2026 03:55:37 -0700
Message-Id: <20260909105543.1478008-11-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000070:EE_|CH9PR18MB902990:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 992dfea4-bbb5-4d3e-4621-08df0e60e9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4fhclYoCVkEHjwpy0u3Ijx+l1u9Mphv6OSjBdhKLXTJojayzpGe8ezwEQG6R30T2GH8vr3iWqfRZjU0vaFUx7WxuR+Gg2SIzLR/eC6xDhh7IANeA+qu8HXc5yM7VTjRICfxcv9aaWczBIlmlk9M6xXglAsQ81OgQx7tCwObPNBRFBjrg9UiUFHYpT6pIBF6wuD4RZgC3QB5G1LKZsQ5Ns7KbukPQlWgPQR+OvKAKHykQ628cbuVCBU81IAMPoq7Rw+DHE8rtC9MS+nzEQkD28Yl2EgkxhYcG38221Mda+w+gttZa2emwrrIQMro4FAo/B0Fd7S6Nmn9MwDUCbFDw2GMiYZyhhKVhQstIhk24wmJg2wkqs/DC9xKNP/XO/ys4kNxA6+MsBguGFNP8u4yrUAoWlxPvVGJOwXX27HzgSoBmm2CnqhN+rc9J6HFeOctKzib/Bx/8RMQFCMOTpsyWAT+UsB3Ea9+v+uXnZ8JgMRwYCjqMOnsV8f6AYCL4/5ntVc8kvVSw9mOGh0h3DdNHlFIykr8njxxttJsM+1vVYcrzY9YFYazcgaoHdzylY02Dj2k376oM0eBH9usbMd9rH60iF9XSiaQvfch5sK8QO6w0DNJGgwKXZexGT32AGoGFzikxyVTU3vUV9W3730BCkq3EOw26yl7R9RBqpDOeVeGtf5xDtpOOaicvTl0AXIHJNplZ1n1mFlrQykV4LQICOQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mYg3yMeauPuBpPdrEfIr5K8Hqs7NPlzMPnjIkvzqpZr/z4ixcr3SLnVR+LBG1yu2HvZbkM3hgIq34VUU7NZksYezc8Ywy6k8EmO+7yuWl+Uc9K3OLS+maSw5zfahi/JeZFRrB9dbTGm5Y7Xy5zTXwJYzu1tpglfz4rQPeH335VFeRFaum+FTGhgqJKnOBVyj+Tdk9+dXx+PYc0qPwTcNteRfVaYH6qpA4uYBoNcMEWUrjt/P2JHI4QnuOZ7V2SsJRu9a0FdqYLXYlZhvoz9bYowUKmQt5H10naSuD3o+tW2TkKR8ErfmGS2G7eC3srqeDYbmfE3a0dEqPuSP4hdOPLx1fdWm1ou7peLf/KHPZhEaVcjogqzuROoqUi4wr5TaH2Zyignfmgz+En7LAvwdP+kav53uOCVeGXTMLNo1VqlCFuGRT65YtLFZFZ0PwWgm
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:50.8439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992dfea4-bbb5-4d3e-4621-08df0e60e9af
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000070.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR18MB902990
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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


