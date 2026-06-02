Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF633C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhX-0005hO-GF; Tue, 02 Jun 2026 02:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhR-0005fg-IP
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:05 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhO-0004bt-At
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyEE4AWP/lUPjgfXce0l9lK6DQAK0WSu9l25HJT7KCkPcCNZTgWl+AHC0U7OShZxrj/uw1cFRofiJZQs2c6a32+ktaNdFvWytUhNpX97it2guwBycopu1IIkfJcmfWy8YwdtM8WIOz6sRdV1nmShCRdQ/rEWmJ+EoYSDMrrnl7M3n0z0zIFEiBnHeihvc1Ec56iolhgHfqKTaPD1KwlVsSC7cxHRivq+Fcv9ZJbkGLHuEgRZyingA+jusSxzpTRU0YRjNBU4zYVD7Gj7vrPTeMR8V2or12CI0+dYp+HYtxM+ljdf331jXZFvNSFFH3bBRVfJz7SHOg/nngrcpjPyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX0EPeMPqRpvn7bbq9ArpShILkpLrhyBVR8hikhMdf8=;
 b=csXSU/nGgbcvraLqgAABTe0Ee9biawf2au7PZzlGMWs7KMbOUCEB8XxWn+dAzN1yqscGheAs6R2KOV/ykQFFuxB2lQdhobzTgsn3upRnmQfcxXiLpdiKayWNQf7WximSdwJmwDJqMSl5ZH2ynzmQ76OK0XN4Aevi5tPVcbFmmB/F3gEM12vyT/uIv6t4KaUb3/xJB0uytlYpF27kDj9oHb/WFdTlr7HI3pElSBr1tLLJZpxBUZK/qEUX+kEHTbUKMxkNf5X3BeZesUu1TW78uep1Gv17xhoKctyUap2c9K5wA2qsgJaIPJrF6k6sTGY4+JZgVgBG8Z7gwKwxbuG8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX0EPeMPqRpvn7bbq9ArpShILkpLrhyBVR8hikhMdf8=;
 b=PYG2OFrJxut7uwyxhCkc0P5zCIHsFDpw+fvHtzwlciccHx1ISK9WQyuTgV7phj2ZR2eQwzQqCBk2XnT32MhkkencQdUkXFJrAYDxnemSzv0x7H29nFBq0xw1bPuBEKZO2eV96xREH1mfs5o65x5LiPD2JGMd9BPU4KGvNew2IkRtsg6bqt0aX/XbbT+1SJ+WsQQpc4RBuNPXtGGLu/rmLsoEm01oCcP5L4Noe/7J9VmgDBn79ghpAfNaR562CsxAbm0GZ8CGLNqbcLpzJwLkv7MOkqSU4v6x0bVhNO2PwSCY1PeCrD7GRlScTzwSn9lH/vkQX3GpO4w27Ou9poJ2uQ==
Received: from MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32)
 by CO6PR18MB3987.namprd18.prod.outlook.com (2603:10b6:5:34e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 06:33:57 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::66) by MN2PR06CA0027.outlook.office365.com
 (2603:10b6:208:23d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 06:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:56 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 9A51E4186B5D;
 Mon,  1 Jun 2026 23:31:31 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 4/6] hw/arm: Add Axiado EVK SCM3003
Date: Mon,  1 Jun 2026 23:33:48 -0700
Message-Id: <20260602063350.3623723-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602063350.3623723-1-kchiu@axiado.com>
References: <20260602063350.3623723-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CO6PR18MB3987:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2cf339d8-6c31-480c-e804-08dec070ec43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|34020700016|82310400026|1800799024|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kz6r7TsqihqxQYltZMQTy0ghs3hExkEBUBXEksh/9hZm/gwkfVhpMEoXOQvEZgUZCv/d8z6hoPQ3yl1UcJWmx0hh9cI4TJV7rnlpJaQTOLGRuFxKKSobQLgsKcyxx2TAjp+fMMv+0FQCZvVilqG5/OUxjUiWJAsrUcfr8imsCbhk/zC3+wQGxLcsUTJIRMrzEKVy63pdN0W8igQWyuFjURkByvXZpm8i2P5gk8v1PpRn6b5Fk5RWy/3Kg+1c2e8a/2PejvxkFcd3jBw4k1Ikf39L+VoFfu/zNzaDzdsWM1nXDvVtch4thKEmK/fPZmWtGlAwfnBR1H1kUPBmI/zze8xcpTTti6oqBdCu5qRyVGPIZEF/fKs7lPg9YrnQmcaa9XwAS36gC9BW62iDxW60VxXnGYAfN4Cv0FtFhiwCnDp10sL0g8tPPkQ8WgfGZAsXdXNmZCJAwmWVyh8fHbvC/oSemIBbEti+wISnjvb8S0gD0+JyYdvrb+aqiWtAlG5e+9EnpFER7Ba3sSkdl5s9NlainLLBvdVfGZOjfZPgAuusQ3Ynfw1RqQsbtkTHPQoVsf1UjfAnYaHf2YRZRZARC+KGFxIjNWkce+snXofwR7I0+9THgljCsLldEdDgW+7qjCVZy+UJWFu8cwy2bPXMYhTNnkRNMlFgJ+sBxmupk1s7RF9qmZi/VIEFksYNZ14rxQUSj6ir53ugiy5J/jFasZ38uy5kb25v71AwdA3r/cY=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(34020700016)(82310400026)(1800799024)(376014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y8IabIAehZN80OFWbldU+jgOgyX+q3DZCquNI2B9P8aYruA4rmcdmyqanYAhO3JA+UMMNrGGCPGhquUwNId2Nmhs+F2ThHk/uNLLoYCeIZxkHzsE87sl0m8VIRIWiNxsmhGXSfRQP48vSphkofENLNBtlv5lj4hUa8oroVYaIRNRp2CEmTPAj2KpPmpZ4o/yF+k1LsUvkx2pHwqXr46nrmq+0rgu4uqxS/3eh106j7lkRZUTOuZWqWWLfq18Rc0JZ3ZzuD1BNXw4SkPKQ9xmQkEiEU168dpEVxPwe4cyoO3XS++auMB4UctKSuiAlDy3uoJSnpOFgU0SiAMcxN6ZdSAc/C6S7yqRsb1r27/O/zhiXcV0XR93MX/eceMmi8tWvc5uOEcLbX+FosHvBWjnPUCd3SjzN0d0jfAcpQJRd9sOmAT0Qv3aN4GDY/jIh8X/
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:56.4197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf339d8-6c31-480c-e804-08dec070ec43
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3987
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
index 5b9cf25dd31..175e6c7985b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -724,3 +724,8 @@ config AXIADO_SOC
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
index 772ae5211dc..61358dd4c8f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -105,6 +105,9 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
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


