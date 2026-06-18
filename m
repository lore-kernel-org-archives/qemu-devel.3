Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63099CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9kQ-0005eS-4y; Thu, 18 Jun 2026 06:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kO-0005d1-5n
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:20 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kF-0006E2-Fr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTx75tx1KzMPQRKYSDtMPJTUt4My3xROjzNg67D/MIWg9OBPlrv9tohHPWw3+wSfM1/HaLnkJavGqtLg7sD6nLv65QMrqwmI10k5crK3t50bvqsm9TkoL20rBUiQn3Zd6LF0P6nru+Ewc+HnOmt+SNGAsBKeBvoNBNTgALHFOJV3fR4JYpF8tnFuKjnO4Dbbfwg8AdEgNQ+SxGeRq/c8CgJQ6gZycqjewdA3gT+W/R62B4JCJ1vBFaRBGtmrN009cjC5c52LpUXkJzXhcBxPk9MKQ5vUbYRzDzQ+v3llGYt7kLStfBi3gacVmkEY8nYzSBFExtpLlaBW+PKNLrsfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkOi+MDmh5iOv/pWZ+xq/SWKxk3SGBL9J6szWThaLRw=;
 b=PbPaHGoKSDDdoXBVfekb5+EJFoVpEzCFhsGhoWHTSPMCPZYfYwiZWq4WniI4tjfu9gCglXo79gzgFy47JHLWcIrLndRZPA/5JvGrf1WGqbaZLk585IGvYA7tsKxZUWZdrjmPkqHH4gN8xMqi/2JlEK5TwNY+1HgmLME6wljE1CYGWTLbidbn6uu0Hg/BWLm76Jm90HU+2tLBrPSN27eNvUkqLw1n31gFkV1KS9D5hu2d1snLLi087WiO+qIyWMYVbboBlXsneI42TXm5zaTAveRMnhob82HG0n+C984hdYOt0feTIj6ssXHp/+18MwHYjSsMNQ1xJ1UVTScPyoUHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkOi+MDmh5iOv/pWZ+xq/SWKxk3SGBL9J6szWThaLRw=;
 b=sfBIUu8J85f7MyIUC8g/sQ1mIgeFSyi7+nx9+DLO6pUGoB2cz1at4DYDz5FZm+GNHGp+lsU8OWkOf8/71chG/eJLdLHt9Q7M9zbczxc+4Bp2Rrs93JaDFTT7kKzpiah9+Lww9kNAXyTiw78i/MLhMMTon7yTxUueLXUwMs4gTrQrm3I/RzXYkJg2K1fQS5Rp1WESrxBtvGTP4yFIJq2uYaVXqpV4b4YCN7Ot+51rjYd8rAJdEg8ONZtTfhslGlKirmgyNWRoEx1jisaNadHBU1ixF4NGpxrjT/LCGn/Gv4z5iYv/yBSGGTZZNRglk7CeEZ9fnt5JQP9l7qQsxptxxg==
Received: from BN9PR03CA0458.namprd03.prod.outlook.com (2603:10b6:408:139::13)
 by LV0PR18MB927505.namprd18.prod.outlook.com (2603:10b6:408:344::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:13:05 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::14) by BN9PR03CA0458.outlook.office365.com
 (2603:10b6:408:139::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 10:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.0
 via Frontend Transport; Thu, 18 Jun 2026 10:13:05 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 727DA40BFE12;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 6/8] hw/arm: Add Axiado EVK SCM3003
Date: Thu, 18 Jun 2026 03:12:47 -0700
Message-Id: <20260618101249.2926976-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV0PR18MB927505:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 98d5d8a5-9ee3-4c69-e8ec-08decd22300c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: yVyS+UJBopXwJfTBRgptco70m3nHauhyYlQxckqx9j9ju1wPvVs9rt87n3w/5w9CYkDLRoZDpYLNMov9RQrz4nV0c6xMbyfOACzfulm25mINbXHqhn/lVcqb4A4dapgEzPm7sgwQtTHr2+cY/XhM/ObLnNCnfn8BBO8kOSW0Lhj2OHGZILjgeylrjXadey5alCWUFhhY6k0tjFI/hQEs3P7M1FxOFoepsZOKN0r5XZz/1OS5V8siEWAH2K20Pd+G9vWEuQcsyOycua04AG0H5CYwBRUFsmEc6fEzqsJvdX+LLvsW6xuf3at0q9H60hvhF5rv6PD3pqm4IYxqfu5Z5mIoZQT5fISEY7Pt8EHjecET7csoM3kCq1abOBGpdjoBM0RwmnMhqOAMwLqyHI9fkr6x9dqy1d1Sx811+9ynQMbM2ZrXQkq7j1BhqWB0OgfKGyJU/NRzR/+9J+zFXrFWnt+n9i1WWt8At9aO13wR6aGKNwOtb2KVnvyNUg2WIvaPD00cFQH4N564g4A9rSGugHmxdmMj9vIBf7Gv9hhgxihe8Q03wPrscgPCcOkwwFD5IjMrPOr/HSzV+GQuPqOUUPFWNyVzIfvWc6JEWVCSb1chdRve6/IPOVeTTW5D3ONI5fFED3fV/MXja62yuVK3hBXbMO0ZNh6Pmd+bATQ/jTLzV64BBUO4kjyop6xTSpRWWaH1X8WiuZb+DuRR1kQX+bYohKRFbx6Z15+5LAs0kWE=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: suWxEqfUgkFLDsMZx6PGbyP9nnzwMoPT60DntK0DxFufkT3FDVmgNwq7QWOk22LSrg0XMuCMpKJrj+Y0fDMU9QzRR2NGM5XCGVY7VFao6GtkqD3NQQ6nMgFaA0PhOGCcnNsDnQUw3LuqKCgggpC/TJiJ1GeZcPHDZK1jTN804KdiVB5rd6qypTVnTJaI8Q3Z1pYFf1jrcOdbByzdILcEYnt8Zpvh6SgjGYAbJ4iImYl9vvu8ZughaGIYB5VC38WGIb0Yllw+yikiC+aHEBllJKMmoSR5I510Pc2JWnxQAT19RQCzj03KVEo8ShXHuFpPI4DjIYzwCwIJGIhlWpLXdElRvZtlHrvQFAat6oVk0noL401N53xg0oszNPX6qYIAUvj8NRRuoTnGT6OGkdO3oCWjqGB0D74l524mcHUEJdcTxA990DsmEQrgN4jBA324
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:05.0086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d5d8a5-9ee3-4c69-e8ec-08decd22300c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR18MB927505
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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
index 13c0b44a180..7fc6fae9673 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -726,3 +726,8 @@ config AXIADO_SOC
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


