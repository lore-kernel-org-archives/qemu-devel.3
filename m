Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AFFC5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL0K-0006bR-Dq; Sun, 23 Aug 2026 23:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0J-0006ax-3a
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:43 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0G-0003zp-J4
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMcmv5BOrYheKY7Lf30hAV1FA7MCEuBtBA/jNgdEuffeebemUpLP40d59ryzC++y6eI5cgCmJA2F04TRw2E4cFs/s0rjRP/ZbuEIhqtMpB6sSSjYGHcDqUrXkiOObtpaGRvmRZ7XQAkqN5TyPYRjYT+UGSg2gjCP7TEbKbXdvtuPV5YJa1XQpKogW6DPZCG47J5Wb1fUurcBtMC+mRQi6YXgzsxE78fQmlmfY4ereCabU882SIoiaxdwTnsHYMfNyoD/2zwnx9FgIzarbOMbVTR8lKT81UDYu+VEM2X0zgbateBoRVXoTdWHqJZUrpD0m2R1sFkas5Oe9zbK/Mwx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXSXr47IIhO03KTt1Q7Zs+31I5RV+fORETzszhKO4Y8=;
 b=OJWPeU0nGmeqTP0jTjmseyjJhzPPfmAHjQX8ReRBtDI7e6w8WIm3v0YUahbPFBFhPWggjLmjlRAuOTVrqFzPgRwaYaxgbQMR+IYR3xOm/trPLdJEQshLYFNCPdykPZjQoFXo0TcrViWJV0gaML3xd2U/Auip61odEGF4/FgWCAErl0dWhtBd9pDX+bCz4MVBlLJ6wNXnJ79QHpk/raXmQRaOnoOt8+gso5pEsxGTqcZZwlTBuZ+u3OLw8ynM4itRl48fYSalsFa2XRXmJL41UxOO89pMjwmQv+wHoYzCRUFjuUGdH0yMrL4fpx/bR3YCAtDXrq5V8aiF5dm4ywEQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXSXr47IIhO03KTt1Q7Zs+31I5RV+fORETzszhKO4Y8=;
 b=HY79i6ZKQa+23uaRE2M2hTXRdY2WOX87HhbVgTecWTfXltioBhQEt1MTw8H+bszpAfv49E2UcusjHGmGlyRjbwv/3pcerTeufKUNgTmqoFuMF/YaFg9w5VZ8ZPu+6xp4VkrMEN7Dsbsze2uC3ftFM6m6L88fwTaW8L5csa//YGwcGhm/5bWkH1uWDupWyht1adc5UNHEdvr6/D5KRIbA08AA/uxk9vMoAunLKPSHWR8myl4dM94UWzmMn4LGGSHbyLRvWpwOeNzc8vWHn864gA9D6MzyOd7Xacp/Pn5jiNDsEnCGYZ2fDiwin+qivKOKtRr9CKze7Kov+5Sxt05owA==
Received: from MW4PR04CA0176.namprd04.prod.outlook.com (2603:10b6:303:85::31)
 by BN9PR18MB4364.namprd18.prod.outlook.com (2603:10b6:408:102::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:05:36 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::66) by MW4PR04CA0176.outlook.office365.com
 (2603:10b6:303:85::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 03:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 03:05:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 1986540BFE10;
 Sun, 23 Aug 2026 20:05:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 6/6] hw/arm: Add Axiado Ax3005 EVB
Date: Sun, 23 Aug 2026 20:05:05 -0700
Message-Id: <20260824030505.1969726-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824030505.1969726-1-kchiu@axiado.com>
References: <20260824030505.1969726-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|BN9PR18MB4364:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce535f28-852f-48ac-f630-08df018c9195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6IjYvCLsUfZHs4YZDktVHQ3ivt0Vor/BW2+WnaKw6/oIyjgGL0TjMpLwwvQMfjXTCwGtXn3fL5drI/Xqurvak0FQxBzaCZ8HyF+hsAM2u2g+IUD8J8vD8VYubboj+77eCpPP0urMQGB2qTzIFQEdKjUNsDjG2Q9vmfkncReb+4gbqWWLLktY779KoMBG6PpgGLIzUzlWfbuDZQhbzymBDtVEWNw8tGsE3R5vb/8MOjxroNBTNhQ/k8GKPKq6Q4mmAoOgA1rAjJtGph3KS7RadKlw4iNwSrun5c19wbPabfYST/Mrl3a/t5k8+3EJtLLq9Kv5OC3hzFZslcMDLl5Q0YCwe9wlcf4/w+uy9dLTl80ro/KZ0Xk58y4eEVW3gDT5xMF2ENK0O41tr+acC0k+M0lYQpSqGAhlXYtvtOQ3hfuUzp8CYhVX6VVugr73Gn6IhJi+K1H1P0Iqld3CTmzwSVaSwpN+WxELB0VDG0W8bQ8UY1xvi060H+IEjDPyfKz1iozFH/8Aj50YebEPkLC+jBVTqB4NrA5GzUqjD57Liv7PE4YDb9NIJUxuEdg3WoSj+TzkwmaoZmNRbp8v7wlI6itiKcR03RK+02XA8jF9ZxAWgVER7bREje3HwO32ZaxWLP8PftPE3lNMJGHqqZ/ScCCd1RdMqp52dg3Rm1I1Hwkcmlnj4HcYqafuNMmvhrUzICfxHM3wudCEUFUDpG4d4Q==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fEUcReGbPphR2GW/WKiTkHxnE0YE57ydz/rdUFV+ePcAB1A7vC8HgsuATmiefwrfSMLIuwzcCMCcNJGrvh/itm6HmIX/pf4NEAM1wkcmTNK1Px6FuRCmcpBGjZd7t6zF/YU/0pKl8TEK2fB/FLxRA8LXfjBS+7Xi5aJ2muk1EyapCjXzulU6A0COw8nU1sEFcjCWQmtQIG/EAbo8AntZtE1jzTB6SRkoA93Z2ENYlg381N/WMyDDhF/GnXcT1VtPGQqgSYT+0bZ4b7AMqbHcwXCl9e5qta4HJE1xOAeeV7rfNzkUz4wNmOeybq8+qxd9f+5rFUbdryUknI9uW6flH6qL/el2T73Rx4IHG98cgYHGgMiZZ6tRZD5eWpdqeYgeAjYT0Jhb7QbAhHeQCWYJmzHd2/bsYAm5YxJ1E2+dU+bpTolFFMOZdfQvYWyEIJ1p
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:05:35.8595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce535f28-852f-48ac-f630-08df018c9195
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4364
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

Add EVK ax3005-evb built with AX3005 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3005-evk.c            | 55 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build             |  3 +-
 include/hw/arm/axiado-boards.h | 10 +++++++
 3 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-evk.c

diff --git a/hw/arm/ax3005-evk.c b/hw/arm/ax3005-evk.c
new file mode 100644
index 0000000000..0b7ad17d24
--- /dev/null
+++ b/hw/arm/ax3005-evk.c
@@ -0,0 +1,55 @@
+/*
+ * Axiado Ax3005 Evaluation Kit Emulation
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/axiado-boards.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+
+static struct arm_boot_info ax3005_binfo = {
+    .loader_start = AX3005_DRAM_BASE,
+    .board_id = -1,
+};
+
+static void ax3005_evb_machine_init(MachineState *machine)
+{
+    Ax3005MachineState *ams = AX3005_MACHINE(machine);
+
+    ams->soc = AX3005_SOC(object_new(TYPE_AX3005_SOC));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
+
+    ax3005_binfo.ram_size = machine->ram_size;
+    arm_load_kernel(&ams->soc->cpu[0], machine, &ax3005_binfo);
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
index 4a632661e1..7a610ecfda 100644
--- a/include/hw/arm/axiado-boards.h
+++ b/include/hw/arm/axiado-boards.h
@@ -11,6 +11,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/arm/ax3000-soc.h"
+#include "hw/arm/ax3005-soc.h"
 
 #define TYPE_AX3000_MACHINE       MACHINE_TYPE_NAME("ax3000")
 OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
@@ -25,4 +26,13 @@ typedef struct Ax3000MachineClass {
     MachineClass parent;
 
 } Ax3000MachineClass;
+
+#define TYPE_AX3005_MACHINE       MACHINE_TYPE_NAME("ax3005-evb")
+OBJECT_DECLARE_SIMPLE_TYPE(Ax3005MachineState, AX3005_MACHINE)
+
+struct Ax3005MachineState {
+    MachineState parent;
+
+    Ax3005SoCState *soc;
+};
 #endif
-- 
2.34.1


