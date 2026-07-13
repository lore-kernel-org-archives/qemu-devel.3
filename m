Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28353C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjB8C-0003v6-4P; Mon, 13 Jul 2026 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjB89-0003uT-Lo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:31:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjB86-0001XQ-Ph
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:31:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWb6xoVgS2ZHj1ibzEBUPMu85UBXHdz7Wla0kZwUQ/aG2JAyKzDwfYJZlifubf+fNb4KHcNSVjmPllEDx46HNqxGnnx7f21AMFLOrypKd/oJKprw1QczFGtqfZxbanuJxEgMEkOxt27lpeGX5cNhXx0ZWhTymzDkfEibtYM1LTWQozDIZuL+2CY9Vq64kwBdGHIGuThixbIDhegyKAUh9uP7Jd/YPSfhax9NijYbdTyfCzokh7ch5ma+inICtfkbm2gODTnCAzlOPv8rofKSgJRsg5LaeVhwfH+AJMm/laAZoSgqM2qXOFdFzIxUNVGLVxO2yc4ATNo4bY/2xfHj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAqwSo78GuiQT+2UFgtQyuOChkoelUNYwzQ5G4wlqzQ=;
 b=Wv6wuWunKXQHFhXzn21reWWQJvTy9gA7HAmwaOO21kgEIxDSMxC2Yh25bwNWMWkULTN93icvDzlPraT3jxRn56Xn1y7tngU188EX0AWWJq7ZkZAqrcwRCIO8yOE5PztH/aonlTnDjO2RJcAgcmGnv+3dWwtaDbh3EuAXsfGpsqnRNWX4YUAq5N85bxUsjAOjSuY3rcy9qbW0qPpOOj3Q692/GfYJGY/Ap/r48xaeh1zW1witb1tIS1erojYevbNRuJYtGcuVn+WEeCh1UOO3UXbyeSxQlV7R9DtPBFe07qSLXjipVHw/FOmKiwjsrkBF/3XWa86X0NkgtMG4vEO1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAqwSo78GuiQT+2UFgtQyuOChkoelUNYwzQ5G4wlqzQ=;
 b=hWTZj5gWk2CCa9s5Lxjk7CCvsm5Dzy7JO2YL76lbY4O5JlyBoqdiZ2zlLRlHuEaMeTjfF/YG8qJ2cpXs/fgnO6L+LSoezdCz/h9XwIVh/CpwRocko7Cb/ljgzLNZyoSlB8DBoCX20qoDp9qSibEGLerCxET5N61BixIK8iFNAVpT48YOdjpzGGSdsijsqTr2Mf06KI1VuzVr19qmb5biLjaH0Nk6s1A15jSu5N3VRpLIY40VuBWS4nO5zo1RVlkn+IIsPaz5p/69w611Dksjl2oRlOfJHsXODkBtHSQRnQ3lGmnjXEQ52ZQPbLQ23ApfVGSdiyqiR5Yvb0FTkb/7+Q==
Received: from BN9PR03CA0730.namprd03.prod.outlook.com (2603:10b6:408:110::15)
 by PH7PR18MB5646.namprd18.prod.outlook.com (2603:10b6:510:2ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 07:31:01 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::aa) by BN9PR03CA0730.outlook.office365.com
 (2603:10b6:408:110::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:31:00 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D8D8840BFE10;
 Mon, 13 Jul 2026 00:30:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 6/8] hw/arm: Add Axiado EVK SCM3003
Date: Mon, 13 Jul 2026 00:30:31 -0700
Message-Id: <20260713073033.3883619-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR18MB5646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03d36de9-bfc3-4bc6-0faa-08dee0b0b04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZU51sflZ2cil9UCHz9iSCINpEDTIw/sD065flmGEeuAgBEplNuunWaheOGWdNWPNoUOmZrjNSGYICnUcpCB4jZv9+X4sNqIOWQZn+6Q8ph99VwRYkVOEAtYVmhVec6fYrENgaz7Uy2NMj7YneuZQM3tshgWX+VMUrWzD1FnZTeix7hvch2FKy7ulj/OYLT2+hcTvp8t+oTXjHTnn+9QBWqftMfCEU37+ldeEiKyW+z+83aRsILid++xqVQd7lylIxDMkAaSt30aDBY6QFmbMGIBDEVCoAW0xCjfV4VA/9HF0r6+R9OUT22yvlgPhAikZ4FloLOhNf5auFmv4KYLOK4cnaCZQWyThuqqFzyxyU7g/ywTW96vPXZL6fozIsKnQZnStO1ap8eqU60yAX9bYbNDf4r88mA7MRZ6y7bDiBGwx7GrZ0FplQ4LNrb9nHvV6XgsKiqfy/j8ollGgLw8MCT7PcYNrSdwoCVHZwn5w78lzY+DcSkQnR7K6c4DLWZixz5IziqZVYQkXbQFmyHmF8V/J/0Qk66KQ7ybJ+4ds/6J8jMiFE29jIYVvStdvMPEvGGnncyCJ+BN5KD8o9WXeVxtwt9oMTU1BuhqCs0eQQTohlCAZbnYNuArgZ3Vzkg4VZt4ccsxRK3R+yNztnzCGJBOOMLfksUH6SaK2YcFIAFNOhZKhwytmARpZckOoBFvbJ96ZXCdYmqeg3cyXerUjBw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IXSIVm7VkDmsea7y2EplvAnbx1eSPGfgGjFZ3NCK9vFPOfoWv+pT1oIYcKeNPdMtMbfUG+o+WDTyHs8ST/8NR4xehU/d1YEtGdG1LL16EQcnNjFmpVasY4ZLmBn9sf4Auj0UJ27QCUQdvYgaBIBGUJkPxPOWWnunzENmwAeQGDUG7A8cKbn0SychZ7HhdeLarJ6AZ64Rj1fVCnkvjhtrmO6Q8bXtADAiDPLbe7FBrXrQsvrLGOimMk3nFPPxqzqhum71keENGKGp3UiRhr+7KevVZijGhJZEOpggRFCs2EkpZlM2b1ET3o+hWRK/I5oRkrVK7tji8chDZhcOq7mUxKQD7P+mJwCVQ14rQMz1J9bRx4fULg97tIslqQzW07USYWf2SUP8RKFLQp8D+LIF1XHBWgxzLslxzSv7Z+LJ7iD8eB/7Jz0KjfCdcJCAd4hJ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:31:00.8297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d36de9-bfc3-4bc6-0faa-08dee0b0b04e
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5646
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
index 411ea90bfe..6ca172d750 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -732,3 +732,8 @@ config AXIADO_SOC
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
index 0000000000..4b8deec15c
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
index 0000000000..a170848871
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
index 0254b82df1..8ee5307a91 100644
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
index 0000000000..4a632661e1
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


