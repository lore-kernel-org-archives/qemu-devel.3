Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F42C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzzW-0004J2-VM; Thu, 20 Aug 2026 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wwzzV-0004Ie-R6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:21 -0400
Received: from mail-westus3azon11021128.outbound.protection.outlook.com
 ([40.107.208.128] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wwzzU-00038J-8T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ4aiE1/EaJr7mboxFw8Q5L4k3SijU9ERSqWuKr7ioi+n6HgcP3AcnV0hrGScXW9okX6aNKFQnEKCHxaewTnXnHuN6eHyOdyaZjDM4ENKegTAJ2gXJRvB8pAcDhm2Q3y3sSEWJZm5MOTo9Q2s/Y6ggWd+5flU9jBKSipYHGtNDED231IMQO+oMRjmCdtyziPncAnL0mVqfl5sONVFfUDDko+H6Qls1uxLsru3sNocpOEFgRAbM1Z0yGHXavi/XHvgzTMyNLEmfkipEAOsqL6vAETp0Bzu85obUExCao5UXVbbkofVKDg9vXzCYWrO0biE/wt+8+aLrVTl4TNy4lviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXSXr47IIhO03KTt1Q7Zs+31I5RV+fORETzszhKO4Y8=;
 b=CbGY6PaV7fZeavWNERfQG+I3/C4A9oLwUskIYCVmrOrc7JD7NA/klQk8EkY3JsStjwNax9wrL7O1J3yVqDCsNJ8W6XjdNwO8YOmgL5NB+zzk/InzK9bIA5qLn3ocn8qATnE7R8D7u6+Jru+LPQqytotBE0wkfNqVAw8XpP7uYdv5lJTfPt/TKFiqbR6OE/FZishOow4mlzLjIBt77lyy6Ggepx99+QB0qn0pcCcSni7Mmgn9986eJas0F9HLvrKVILdAsEhaGtvAxrbv1YuJ43GEC2oeiK7W4z26JLn1SvE2ntieG6e/TAxTf1xJ9ET7ilzzfVjUO4TGa0JiTRt02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXSXr47IIhO03KTt1Q7Zs+31I5RV+fORETzszhKO4Y8=;
 b=wGdufepnxt5NS6Dn/5iIEaQ1KZYNXebbM8Zp2DBSJesp4hnxYmZCbv+sLXfY1/tz6wDITRjamZA2ngW+eCmoTsqLB3Zcx76bfJyCgmScxKDlMT9gyH/+5u0aN6yqOpGILgEytBVEDH/R2BOm65/F9U2Gq9QI+vZZaBYmpNyxVGZ4fXQEAiSKMHELNv0jAKOUZyZdOg5PzkQrsBioKKhmrxQnr9PeV0GX/G49eGvyA35PRw2uZb4gszsU3ohbhnOJxSd0wlc+ia8DAv+r/4JTpMcrt31O044od9ADKneHerygKZzKsGJW1DvHP75KqcN4k/Fyjd49YtzETwOXX0Caow==
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by SN7PR18MB3917.namprd18.prod.outlook.com (2603:10b6:806:10e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 10:27:02 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::92) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 10:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 10:27:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id AEFE440BFE07;
 Thu, 20 Aug 2026 03:27:01 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 5/5] hw/arm: Add Axiado Ax3005 EVB
Date: Thu, 20 Aug 2026 03:21:32 -0700
Message-Id: <20260820102132.361642-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820102132.361642-1-kchiu@axiado.com>
References: <20260820102132.361642-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SN7PR18MB3917:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 212b216a-9a07-47f2-dc74-08defea592d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: T/1lydlAHY1gVk7O43MHBtxX7TLp6qq1RhMBViSZQEnJfMvImJqbfHzO7Y05X2IV3VkX5h/IW1zy9SakqJUXJL6f4m2XStlc1Ssl93KtmmdqwcLArzucQr3AyF1tYrf/qMFkb93gLYuxUMo8gAMQxjcTN6fhVvJJP2i1+K9rA4+op7Ae7Xm66ok4/10io8F3UU5+peX2tXfvl647kY8s3M3A8KmxYF9meK4CKUpR3RPk04PnPJ7WBV2z3kMdqg5uNknFvs9RTaW0hVxF3umtuOXoFEhNnGtNlWWZhFv83e7GxCQt7XYcXaGXa1nMNAf14FTqjtUS4k58gebDX1YlAoM465sEjqp2ZXYxEFu+hAKNIbhkq0A5rsH4jMarjPbR1jSMv/gzMyyIWYnVEeHMRy8/8O/UBRcrZBpwwtEYehulUywz9+kkMrxGlNTnpNKkLvJvvEIYW6a3z0qX51dJJvmMZBjud1nJwI9T/G03HJCp0d9hO/V1tsiOOTxDQL3tLk3/hUB6U1JvTGFm9uk/WT53GhI7HSgnmduST1GKB6DPfqtar1IgAkgenRVC5rGInBBltC7nRvYnjWIqH+Tq2TaDJhEntqHAFbiTVVawlUXxYUKYR4HcrGpVtyAwKO7p1tvtdXdaCQnN2gBCaz9KP+2j6uIuoZMLq6NHzbPyXdkt1Okmflt0nxK/5xq98aIhN2nwbffTOI5deeYFXObBGw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nTbpOaf1jSaseNfWWfjlctbvOIAwQP2RaQLeX9qbFlKW+v0PyicXdJSW500rIP2tjBWYWBxIAhLvnx5LdJtnOnq5/Y8/meyBE4cATjKb0RtRloQnvjoCthPiFy7XtT59zc+YT8bRtvG/PZ2pSjtp/4qH1HI3enOce3wsdQG6FKXoAWC3dA4LrkAAJVybKjlhWnuV8IFGoh73cCtDM2B7CtVwtFNz97PCEedL7g3f6FF0UknU3Ug841XL5M3V4nPm3MFRknz/0KO8lKBKHUw7M2qsjTqHimAJbQKtBc9V81kRG6Yn0H6uVnyigHmKzh2ve9G3i04rfRA96SBij6oHefgkbIpdHbyUW+9sxC0qBE0nn3QqZRnJeUcFH29Fafuh6f38ls3FhXTG39k4kk6UwSwDrL25I208ZUaER5w47VJI76Q1KDihoAsff1ICp1Py
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:27:01.9292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 212b216a-9a07-47f2-dc74-08defea592d5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3917
Received-SPF: pass client-ip=40.107.208.128; envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


