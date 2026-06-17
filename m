Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F240CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZm3q-0002S7-IP; Wed, 17 Jun 2026 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3p-0002Ri-8v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:49 -0400
Received: from mail-northcentralusazon11023123.outbound.protection.outlook.com
 ([40.107.201.123] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZm3m-0005fK-OS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:55:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fN3orESustTriUFAN/olRTWJbXIDAH4shCgzshudXinojiJudWVbV+7+gYugk2KvjOUqx9GPR+685ODWzvbBJNKr4fvG6R6hlU8xcDST3K055y2t6iJB7Gw02krJKTZNC48alPc38UNf2G7dkbGokN2ZPP/41XCIN6lK2gOIGtpiJeW3HwtJFNjnxJX7P7nt5aBSIVNfSl5tBabz7n7jbgNLgeqqpk+tVoHcra5SzuSmEVQUsG+EiAIUtdOBYP7mjg1S3e2yAMYzpAcohtoiV5M3z6Br5ZMHbTtKXGw1dEoHVudfrCLKUM1qj/367Rf5ie+FuUmYIW/UQHUll96U3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0Q0whnWrzlZo97OTFtT1CFlzRp+yuN/yim4A/vk5Xw=;
 b=wPVnV2qKQGuBzJk5bdY5+8GeuHqTYSENURCTCjgvXekLzTNCUcsgcq/r294SFdJCuvfxHcWJi/1t71f2I3kYuNoNDfTYylYJgE9SwCiS0RL1e9sDZFBfEsnFo8m67w7cfsscvWDSb7CmL38qMnjebXFYCaFMvLyWo7S+NV64aYykPgOc+tjU2i4NnTyuyI7ddYrE4YhyHctKylR5U9JKRo7dbY8vU7PnD2GPsdqUpSzyO0VmGZqYbKHHrV6WyS/3jsAMX4Rb+f7rqyGQcny0MCZMFMe0l84/EyxcbUfDOZ5COZuob4Dj0p54MUQX8mBvCbIg045gWN4xJ/x3Q+6ixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0Q0whnWrzlZo97OTFtT1CFlzRp+yuN/yim4A/vk5Xw=;
 b=lTfdAJ8iRRjiqFloVlRc9GKNlYwR8Sd6QhBro1t/ZJ99UCgdGGVR6bCSeUH8ftlkXM6vG3LjJ3LKmfLS3r+p/V8RWi7DhciuAz7PXiCI+SD/4KpLc4IsbNxpXAVi/d01IsbwrDvzEeQVMjysuXJmjXyw6ZWCp/MUMN+vaqJc28aFTWJdRUdvMRrPvSouHb3VcEZInw6wZtJc1AGPc4PeZCRAjFgUrF14ww8FqCidDxJCKxjN1H5cCIKICdS6bv7saSDGGLRF1s+M5k9IEHelpqXmI0P1mc6AMBiY5haocBgRzn6K9LfyWoXH2i66AsNBVd5X5PWi5DH/1Yo5IJybvA==
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by MN0PR18MB5848.namprd18.prod.outlook.com (2603:10b6:208:4c2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:50:39 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8d) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 08:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 08:50:39 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id DDEAB4186B5D;
 Wed, 17 Jun 2026 01:47:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 4/6] hw/arm: Add Axiado EVK SCM3003
Date: Wed, 17 Jun 2026 01:50:25 -0700
Message-Id: <20260617085030.2586072-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617085030.2586072-1-kchiu@axiado.com>
References: <20260617085030.2586072-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN0PR18MB5848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9689273a-1d0d-47c2-9d71-08decc4d8189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2qnwJ5egAIaANp01tx1Oqg6LoFItOPbziFdrFYJk4nd7RkS4iC0EMw12qZMJ7DNdkn3621Z3gveGcxIJEq3Xr1/LNi0qCr3OWGamQ8qVbtLM9kZRrcXCKCh0dW4JgsuCGTiCL3K+ZBXRXLZrIxDm7Clh8ZqpCriY8rHhgVvdd7clorkGtm965rvFYG+Fm7cRO/CM/0eooSBp5+TS6kkVl657YntPf/WfS9f27AeXJY7/iwqes2t8H/BBIiutWi6n7/NKpVGpbCGzt0oFM0x13JB3EO7n8nWNTLBzVEQT0iW5ptBTumhBhWziMcpAxON8vZ6A/sr684PFPKoDQEpJ4mhPVIj0i1rwQSXYb7NUl4ONCXZx0dL0Ziiy3aFcujMhZYVkhzt+CJCBXbgJ7DAQHa7HgJjsVLFba6P9FXfG9ThAYrcs6r4ZhqqKm6D55E4xKGq6E1MSC1EAz0YJqDOrOHwQXGVcdXbbdzf+9VTC5IDZP7QOD9xy6iQvSi9rfOLgIkxQ7Oe/9Fe4vdVk8rjpcIzXrZtMO4F+zGzenCqqGOTjkYKt5R6ddmz9p61i9cVd8MN+Z4AcuXXCUptq99tELjdaAM0PCJvcpmdLPc+anu10i0KD4rmFtCUiUSpvWqZ8QugE1UNeeCUpbLVkW4exVUKjftRQg2K9ph1Vk1vjLrJRO9c6J5qJ2ts1/PxWmAmb4vvEM7Xi33qhAtnYGw0DIPSXxnQOEX2bis8AbzCGWsw=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pHgSs5xeiyNlf/9H2/UKMU1VyTx4/J7zB7Tejj8evNy8aR7Q4uEMQYvTlij5egft32XOVwhPcOR/ZyRADmPubX7zHVSaG71f+RfmM/jGjAS+zRBXFgKeSAzl/CvUN602z0yg484gAWNXzOv60WCUfnTnofXMzb8gZ+3QNuWpdJhwjEiIefJolqQTT4X2HJgDdZ2smvIXHLoJi7HXD8AoxqqIYdsBoquNAjno0gUfCrFEU5Yu503imWdMiJtKUQGRD+lSPaREVJDvnjL5tnmE5GFGtraWUNMt4UqGsazFPP62TgHrUMR10Hn1A8u6cUkkEmy0WvkQwYcSYBNTi+9olU3pY1L3U/HFzRU+WZAxz5bbG7orRwZzcB4jztUE2B+gjqAXS/BuY19C517FzxeIzh4d+6Qu4I4ZmArDEmo9AlTmdXXQ5Uue7Aiv33D0mqfS
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:50:39.0560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9689273a-1d0d-47c2-9d71-08decc4d8189
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5848
Received-SPF: pass client-ip=40.107.201.123; envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
 hw/arm/Kconfig                 |  5 ++++
 hw/arm/ax3000-boards.c         | 47 ++++++++++++++++++++++++++++++++++
 hw/arm/ax3000-evk.c            | 27 +++++++++++++++++++
 hw/arm/meson.build             |  3 +++
 include/hw/arm/ax3000-boards.h | 28 ++++++++++++++++++++
 5 files changed, 110 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 include/hw/arm/ax3000-boards.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 957341951a3..5240b57079a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -725,3 +725,8 @@ config AXIADO_SOC
     select CADENCE # UART
     select AXIADO_SDHCI
     select UNIMP
+
+config AXIADO_EVK
+    bool
+    default y
+    select AXIADO_SOC
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
new file mode 100644
index 00000000000..ad3dd963656
--- /dev/null
+++ b/hw/arm/ax3000-boards.c
@@ -0,0 +1,47 @@
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
+#include "hw/arm/machines-qom.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+
+static void ax3000_machine_init(MachineState *machine)
+{
+    Ax3000MachineState *ams = AX3000_MACHINE(machine);
+
+    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
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
index 111ab2ba010..feef999f36a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -110,6 +110,9 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
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


