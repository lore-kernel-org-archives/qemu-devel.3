Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21966CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnQ-00051D-Gn; Mon, 22 Jun 2026 02:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmn-0004oY-Bt
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:34 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmk-0006cy-Ly
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqGs/1Wi6nFU3H6kN2zAfy3xGYy8CrrbYtxvbO1BmOP3wiVnIfJN9caUzEIhei/wqaI9+OKDARfCDA7dcV9iocSf8v9YkkA+VJ/PntXQ/mc4c6hT3T7aICVbqGeCG/ErSI/XMHkeb9mD2xUYNKjoYmVNjDqLSqk35VAOisq9npKnh8Wh3rvfEKFHYUnQCL7lEEKP8+s7YtwhYGpfVBf8sa1nnUVYs/ZC8TiqA+7Y87+ciCsXqKyT4OJzz+T+1Dk2FB6HTYjtm23nn7m01o41LUZMEymxwvbvkzbLckY0/gzpVKpczPn/O8Q+bS38TtWm+Dw5DZ4zkZoRwN/z1r1rUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NgG+qZWkkidpb2JlA/wQC0LvebyKzewaQNViEIQvQw=;
 b=GtkTX3E2xR8gipYh0UmyIkMBNkdlRXFpWmu/i5YoqDggBHoXnBCLxAXMydjCImoz/foAGFjFZSsfxYOHFQ46y+sFekviQ5FKB+AyTbnNT2HHIkzNHzsElGF10zZF7r5L5P/iRcFH0LWIMzi4Xxh17rExawVb6aMiuSY9bh8B+8UydlqGQMLNNMZ3pxRUoxtaYs10IKnVLlOUPhLER7O3CtzZD5D50Rl7pkOg/SqwtkDLgw6EvzEyRSM7DQdv0ft1Eh2c2HyTHVh76CB1sYQByM0uY1k4wnQorUV+u3fI0PsmrWATMJ2ByfSPaNYkBAL1vT+hikhAW7cCpSsAgZhl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NgG+qZWkkidpb2JlA/wQC0LvebyKzewaQNViEIQvQw=;
 b=nxzxsoQyNbIjjw0MSZ1u6FLDXSnL1veU/PqAmxztOs484zeH5XYlVGHBPNxRnysOSq+ZazRJYscSBog+GrmB9c58hAdIpuyIikUb9UgbvafO7dulAzClt6RbCht9iJDnm2klzw5l68qNV08g9xnFXVTmej7eXFzc5bmJxyasnNICtqeR51JWqJdWYuo0xwH65CaMVuWJQy4UwObY5X8UNd2JHPs+hpa0JjKkY+QKxUJ1d63TamTDgcVoIIDBq1UPlScHMD7Wa1/mAl3yRW8oLKxfZK16joUm1T9MhtdxwNZC6+3GC/Tl7+XmhwYrueMQPCcWyo4BO221MaDvM41CWw==
Received: from PH0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:5::19)
 by SA6PR18MB6342.namprd18.prod.outlook.com (2603:10b6:806:41d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:05:13 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::9c) by PH0PR07CA0014.outlook.office365.com
 (2603:10b6:510:5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Mon, 22 Jun 2026 06:05:12 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A571340BFE12;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 6/8] hw/arm: Add Axiado EVK SCM3003
Date: Sun, 21 Jun 2026 23:05:04 -0700
Message-Id: <20260622060507.83195-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA6PR18MB6342:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 67408699-a5db-44a5-dc33-08ded024393a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: SRQ2RcN9vHu/HYtStHtjCq5KHp03lHs1lZMNiQx0V+ikHB3ClvH7ntb6eB5EHO1/rdDS9jULwN2+VXZh865nKBArE66hf0b8Bw1r5Ys9+ra5yj9repagh6pZNshmyaKl8zr7JjibAZnjfowNK6yL/D51DBwmZDw5QnYa6S0/1MPCdzO6GNOEST9eR/4mlqCL5g9nx4axTfJVMAq9ynckNFhaxT7yH8m4eChBIkekd0PI2hBjX/av1InjbHX3E8+iFdglKL4VjkkvK41ciaBC/Om1HGAgJsLJQ1WbwGn8zlL+7Vxzu8zkq4QHh2Tl6yYruajm/eoYYtBLAQ+WyLAm5FElK3ZSPfk+xgD2pDmNIZD2WNZWuXnCEOR/VFW0DCXxF1dTMVog4jeUPfk9AqURxyWY7yRxnrlBup3v46NuIO5lUqdwDiF5D+TctM40x5M8U4HQqsJlA9lcMkqlRxio6RM292WhjoZt+Mco7RhL58T+RimexXvTbdcnFZEZCv/fykgDu5puqMRgIAY2z59mX6vYy7PSyntngjTF+QjXXdK+xsqj3KqVmX5tlYPSc1RFj6mBGJeQ5O1hf85h/QiJpeF4yzR2M8hKwOAKabFn84NS0ujkCCzleFPA7TqQals89XZLxk4t+ehhVPDao2QWVfOxuWyjSCIJCKgE3ynQX0pNQA+vzlA6U9H3d3zNCpXMp/7fjOAqf6M/XnxMlaEIYQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pKSiRCtJ3JxG0V04cr/b3h4VE8VdHcyNefaItIPPnT/qFcEvHWCW9YGPSwiZBIvTySNKFaxGIa8WZMXEPz2fEKLJv19rYQNvc63NUv/SgP3rJ0wY3wPiYJ8aw4OXpjDnhjSJhwK+g3ppt7ylXqqGkamT9wMsqJT6zl5yOpefCGofFr7a14rFtwqBZ/ZWJA4GMe2sVjjnM4ZldibRSVcrXWddLBDSeaibEXNz2JTm4mU3dYfVe5LLJbQu+H2TQzwisWfWSlawUypEMmpVWoKICHMY9yHl6rMA4Oh2nS1EdZNwTcBd+nKXHAYkEFkOyyf0UlzlVDKYwRDJD07E6lTqaJUJi/g/6U2P6ndbKFS1RZJ0XBoavkOQ/vNoSPauwoLdfYhmm45HXhrAlVcySs0pFdLG+aSsbmNsb9zoRaKRQ7tD6Ym3SuIMiUD3WR1JgFET
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:12.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67408699-a5db-44a5-dc33-08ded024393a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6342
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add EVK axiado-scm3003 built with AX3000 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig                 |  5 +++
 hw/arm/ax3000-boards.c         | 56 ++++++++++++++++++++++++++++++++++
 hw/arm/ax3000-evk.c            | 27 ++++++++++++++++
 hw/arm/meson.build             |  3 ++
 include/hw/arm/ax3000-boards.h | 28 +++++++++++++++++
 5 files changed, 119 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 include/hw/arm/ax3000-boards.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4a201dc8236..c63c57fd18d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -731,3 +731,8 @@ config AXIADO_SOC
     select AXIADO_CLK
     select AXIADO_SDHCI
     select UNIMP
+
+config AXIADO_EVK
+    bool
+    default y
+    select AXIADO_SOC
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
new file mode 100644
index 00000000000..4b8deec15cf
--- /dev/null
+++ b/hw/arm/ax3000-boards.c
@@ -0,0 +1,56 @@
+/*
+ * Axiado Boards
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+
+static struct arm_boot_info ax3000_binfo = {
+    .loader_start = AX3000_DRAM0_BASE,
+    .board_id = -1,
+};
+
+static void ax3000_machine_init(MachineState *machine)
+{
+    Ax3000MachineState *ams = AX3000_MACHINE(machine);
+
+    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
+
+    ax3000_binfo.ram_size = machine->ram_size;
+    arm_load_kernel(&ams->soc->cpu[0], machine, &ax3000_binfo);
+}
+
+static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = ax3000_machine_init;
+    mc->default_cpus = AX3000_NUM_CPUS;
+    mc->min_cpus = AX3000_NUM_CPUS;
+    mc->max_cpus = AX3000_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+}
+
+static const TypeInfo ax3000_machine_types[] = {
+    {
+        .name          = TYPE_AX3000_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(Ax3000MachineState),
+        .class_size    = sizeof(Ax3000MachineClass),
+        .class_init    = ax3000_machine_class_init,
+        .interfaces    = aarch64_machine_interfaces,
+        .abstract      = true,
+    }
+};
+
+DEFINE_TYPES(ax3000_machine_types)
diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
new file mode 100644
index 00000000000..a1708488710
--- /dev/null
+++ b/hw/arm/ax3000-evk.c
@@ -0,0 +1,27 @@
+/*
+ * Axiado Evaluation Kit Emulation
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/ax3000-boards.h"
+
+static void axiado_scm3003_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Axiado SCM3003 EVK Board";
+}
+
+static const TypeInfo ax3000_evk_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("axiado-scm3003"),
+        .parent        = TYPE_AX3000_MACHINE,
+        .class_init    = axiado_scm3003_class_init,
+    }
+};
+
+DEFINE_TYPES(ax3000_evk_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 0254b82df1a..8ee5307a919 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -112,6 +112,9 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
   'ax3000-soc.c'))
+arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
+  'ax3000-boards.c',
+  'ax3000-evk.c'))
 
 arm_common_ss.add(files('boot.c'))
 
diff --git a/include/hw/arm/ax3000-boards.h b/include/hw/arm/ax3000-boards.h
new file mode 100644
index 00000000000..4a632661e1e
--- /dev/null
+++ b/include/hw/arm/ax3000-boards.h
@@ -0,0 +1,28 @@
+/*
+ * Axiado Boards
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_BOARD_H
+#define AXIADO_BOARD_H
+
+#include "hw/core/boards.h"
+#include "hw/arm/ax3000-soc.h"
+
+#define TYPE_AX3000_MACHINE       MACHINE_TYPE_NAME("ax3000")
+OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
+
+typedef struct Ax3000MachineState {
+    MachineState parent;
+
+    Ax3000SoCState *soc;
+} Ax3000MachineState;
+
+typedef struct Ax3000MachineClass {
+    MachineClass parent;
+
+} Ax3000MachineClass;
+#endif
-- 
2.34.1


