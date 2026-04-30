Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFDFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINXq-0007Gy-NK; Thu, 30 Apr 2026 05:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXm-0007GW-Dk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:50 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXk-0005d1-EB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTfGVLNlRXOeWUMjVRfW52iQ0aEV7TaLjIbKdTySPV98n84LGSXPTFzUQhrjJTy2Cv4muCnT9392XgXqiV/fHqkeHyxkHD0Xkh6k5UppSB0DioyAnnH8akAiz9JgcLAiqJBD7AATJp4ROPc2DvyN7m39/QsVQmAnImTJU09LD79V0TzaEtBKkxjE5QvnSFUW75Nqwhlow0pHQfZDwAErInU/RY8LD7c3X8PXf9xHx68woyg9K6dCDnkXRr8Myym5kriYiDotouSTg/xy2dL7cgDqme0Vrg1j2VudhcqVHM8n9L6dnK1fCNxqRH9Kjdbi9fTSZjkGjXDTNdMneY9xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CksYlyAEZEF1qTPwvp3rD20mFpJzoQOIZcb3Xbnr7E=;
 b=InS0C7aCiAB88s+yZuHOLJ37fa0uOIvsF9AzZyVkomr56/B/r69GrobbXOyBYRcW8PO+4GcwkiW/c8tf9mJ9ftkvUGPCQJnaeLOJ5BEf2/z7E3jotVniSB3lFS85T+DvHm/Al8JXfQLWp26+NhpeMQBHecUsKTmgs5nMSzeE+oIfDchjOB6V0Pr2D8XQ03io0w6Sk43p/b/rmfpZMpfWTMXh682az6qJbhwQi+f1sGQcYRHAZuhCBOhNcb7M/AkCP6GdBmqp3JOb7Wqea4Hm+hCtVR/V4DHH9hgfWWFWRT5lrjvgWJaqHGDfrfBtJIjkdHeWmakJhpmNx2uVCUoWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CksYlyAEZEF1qTPwvp3rD20mFpJzoQOIZcb3Xbnr7E=;
 b=bttcOJVvmWjbZziqcbZogHQoRji+pKbHIU3DjJIKxTCGOgdGPUnJyj8A826vIaxCkLa9ombIdut4N0dus5/8qALdO+BQ/NthFe41vCcna8lZcd+PvJ1UKeNPkHQCXnQtk20unuB7W+xZ/l+bXgpW57ZasI8AgDf01lG9BqGv5QJxN9I5Yh+YsmSbGXqsHVZ1lKNIGbxQIN05978BjSWm/7yjqJYRmrUudvsAjRVFGvoJ3BvvAxA8+J13wc1KVV84BIDcvTEFEKYuui2U6E97sVZ9Rebl6wGNJtBYLo4c1VcaZh4VCGvyJPPwkxfm8Yy6InlIpBDe0JN9gozZzh+JDw==
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 SAWPR18MB988333.namprd18.prod.outlook.com (2603:10b6:806:4e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 30 Apr
 2026 09:18:42 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::a0) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18 via
 Frontend Transport; Thu, 30 Apr 2026 09:18:41 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 404D34186B5B;
 Thu, 30 Apr 2026 02:16:49 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 2/4] hw/arm: Add Axiado EVK SCM3003
Date: Thu, 30 Apr 2026 02:18:30 -0700
Message-Id: <20260430091832.1846637-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430091832.1846637-1-kchiu@axiado.com>
References: <20260430091832.1846637-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SAWPR18MB988333:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b53d1427-6838-47c6-656b-08dea69978d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: k4Av5bo55jfX3kQxltArooyfQNoNDJXqDrO9UwNLzw6MTMD5tAPdyyXYQ4bQyXdix/oQXx6qb31noqqN5E49a8h0GT1DPrs9BIl3sDIvpIUspxyZF+jXx92QZ7T7oXjbWaaCaL0v0H1oAuLBt7UNMPDBuD8fvTGJJv67mVf4RAfFN2XWCOkNCd25vD4ZEFxLuC2aQQBmGeqrKVZ961qUhjXqYUWleu6Gsml8DvG/cXoSWAfWIsto4D0aW66LvTqaMQalAM2SCaVd0+z/0doXV/kbHfrIft1iZsD4LTni+GrCmQNxaDrKQ2tNTm6id2gdor/L4zWRxAiZ7L33anDNHvfXELlzInt7HeKxumoeWr05xC8hg8I5MYizxfZYZWa38X2Q7SfEhErGBlUHWxnSVTUolFSkODzitcpidBvFm0OQU+rgO3gGMiSXcSeINbEcaSp1qvqXiwsMk+a7H1Vqc09FcFl6DacHq4jcGqJ9amrpTmE66x+7/FbVyfnvt6XacUXPHTLs6u/FfH2hFWX1bGMY7BZ9fdgz/F08KNI/lQ3EBuHz+ecg53Xm/sf/VioeU2zd8AMoQ8cSVVB25d+j4cS6lBlMjh5BqS1oKt8mv4cRdflnb8tFWspbZEyuuRREg0cJ2/qf1ntF3dfsRp8BwlrgBly2B6z9iEmrpb22wtFZjfxDgOhsSQU+WpH6T2zDcITAdYfc2mhjHg5D86ljQ7kzZ81xEdE2Twyv6Bn0SL0Reu2gz7DZ8DjHweZwTrtw8IxkF66lHF+cqTo+Jr+lkQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNa583o2SNqEbxAifjXCkCWCTDQ/oFx8OXOMsZHO///v6lMp2kolXizu2npa8EkrqZc8id3y+XpQNaMiU+J8z2Gmb2ytegBWSd/kMSc0WbRlKnt4RNZFFKEa3LQgndoQoIQb8cuV5MlOPzLHGvvjXcs7gGkv7aXSQ2j8vvpTq2O9SAtuh6gz6sxrVAG84ruiwRN8GkSVKuZoej52Z9FkCAyxomTJSyR9HB349OI0VYBIoq/J/oZdprHDid0wJqYuKTMZuP7K0bz0+fcdFmGf6hy7+IP/jrtG6kNhoVr/tbq6r0g1RnBNpg+ua5TDgA50DnA4cjR0Hgx+Tl22M9Xhs0SIMrur2kSj7sYNfWv+Xo1p2KfgcsdquGqxrq65y87iKhM8Rm951z+v1UwWpnPIBVDdm/xkCM1fbTjhdcv6tpfbBNN5nVKJyPcN1r+gYJSH
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:18:41.9305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53d1427-6838-47c6-656b-08dea69978d4
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR18MB988333
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
 hw/arm/ax3000-boards.c         | 52 ++++++++++++++++++++++++++++++++++
 hw/arm/ax3000-evk.c            | 27 ++++++++++++++++++
 hw/arm/meson.build             |  3 ++
 include/hw/arm/ax3000-boards.h | 28 ++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 include/hw/arm/ax3000-boards.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4fb23122fd..e569d8ee9e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -699,3 +699,8 @@ config AXIADO_SOC
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
index 0000000000..cadbac8edc
--- /dev/null
+++ b/hw/arm/ax3000-boards.c
@@ -0,0 +1,52 @@
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
+static const char *ax3000_machine_get_default_cpu_type(const MachineState *ms)
+{
+    return ARM_CPU_TYPE_NAME("cortex-a53");
+}
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
+    mc->get_default_cpu_type = ax3000_machine_get_default_cpu_type;
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
index e32f5eb0c7..39db50bcef 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -107,6 +107,9 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
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


