Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CF3C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8M6-0005MH-Kk; Wed, 26 Aug 2026 03:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8M5-0005Lf-F7; Wed, 26 Aug 2026 03:47:29 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8M3-0001bz-QE; Wed, 26 Aug 2026 03:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7v92IfCMyIVXfD2v2j+uN/clvL4bRmCfz5UAWYcs062jpGCLdNPyxzrTht8h7Bdmizz9fyo1Yk8+osizgYl9Vq337rrPV9kVtXk6rtvsDvaD2FS6HQ8p94gFnp+yaJVG7ALGDAnBffI1TZDwwPBF6QnUJrgNX6GVS3BrJ5gquo1Rw+kNp0zs6S/qOefe3TaP6gMorCYfVmtdQMq2yaxock1Di99C/88euLOWDWsUPUWzb1r6TInpl9Yp3GXH4yCOl9liNqU9hTyTtRZjvBLu2omNL1jTUJf8AS1cSby5xc8vBDl8r/KOyjmHmoJNNSyDtut06ZgwTH9ySrPaAuYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+TLOzPjhN+21L8QWL/LzbmR8jL5lmpWRJ8hflq+BG8=;
 b=xDrBhObC2IO3VkKpPW4VR560yhsfNhMwdlpCOdduuTqMyg2RSpv8zA28YarjLC6Zw8HEXMA0ax0ac1nHonqAadWuwyS6gl/KaF5jWmLySKhITWgPz+onvICbcMjKhOnLjuS2+9ntQoSdX5qJkuZ5ijpfJjv4sCEtzFEFzoN8m72ku3eHKvvCLgIY1eQMisaSe/rc/nhs/4mbwTzsT31CkaSW3MEXR54qLWGqnR0/+lDHU3/abO2vKs88azcP9M5azByEEsB+ysugNCAeWsc2tj0Crb+21w2lGtUCkLhnDbNcyrmd2X3WlUF8tON1Z4WDdkaoU7g47wSvJNxPhG+eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+TLOzPjhN+21L8QWL/LzbmR8jL5lmpWRJ8hflq+BG8=;
 b=QCQXG6/HSaL40d/ztaW9mYLL+F9FxFR0jeiNn6xbTFgft8a+DoHVeqkk1YZDuLoOk24ZVo22T0scBOGrT/CYLnB14G2BPeyql9acL/gxr8vDObASb/0UPy0DbFFKWDGGY1w6As8WuOqmVrRjw7eG9G9FcQAkQ3YHcT4ZEQ772eJKITMLnBYCO9gwwg+zrulSrx/lco2YqtQiz8uaDawwFM58p56/VYE1Hgu420/RdguynEAgf9kILr/z04uQqpWUx6ODaKkmZPhyJA+bWSgi2v9kwHW4Coc0G1G3fK9KqarfcbXdoeqrmoXCNiIilOnm5Jon0pgBa2D4J2t1JyoBLA==
Received: from CY5PR18CA0036.namprd18.prod.outlook.com (2603:10b6:930:13::21)
 by MN2PR18MB3688.namprd18.prod.outlook.com (2603:10b6:208:260::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 07:47:21 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::97) by CY5PR18CA0036.outlook.office365.com
 (2603:10b6:930:13::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 07:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:47:20 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A5AC54186B51;
 Wed, 26 Aug 2026 00:47:19 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 8/8] hw/arm: Add Axiado Ax3005 EVB
Date: Wed, 26 Aug 2026 00:46:34 -0700
Message-Id: <20260826074635.2850931-9-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN2PR18MB3688:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7b656b6b-4864-4f51-e6ca-08df03464213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rL+07Xp2sL9LCBCIBd9AmeTTke69LgjBhZVbwNU/xDaTfCyiAmVfYveJzMT38Qad4Y8li/D/qcxfEd8dfZViJkIkh8r6Tc0KkF3NH8T+Qvs9HqEZzVqR6WsVdKLVBuvD4wpqYgpNQaFwi2JbqwqfMWNpQdarHo73YarAcyec9bLqgVC7GRDKfU4+F3tPXllivlTbNuYrTgt2jtUuZSjVESr2DRJw05PpgUUSz5Dfizh+WuCbRMOZXxUzZ5F5FKjFBq0u6VrjgyCPxzpf09qpUpIsLsrkEp4ZpyINEm6wdfGZiDZX6M90a3WVEC2sQlkwj2QfjiTW9/6ujP11HR4gq3A8PIQhq3G3WW0bBGjhH1Xe+ELsGuwcPQ7mbcyTmRIx9GrGVqtaPAvRqxdQcn2Ljzsv0huJQmEYY+W3IYaQVWo+o7MCFeWOhk16/mBfCZ9fOfhLRCQ6+BlO1+05kw5SY8XHxQqW4orAfujqAx+tPL/bHWYnMqcL3410AdWHnsYmmINLWGQgnJUXqKQBn/nGgiI4kJblqCwlc+vxRmI7AgkVn6V4BOPFSR4rMQK/8uRTxjN5DELkoxdvGBS7MONMH1odCUpEUXT1uMQspfjcQ1x5yhVmgaOG0fiFmHh3cEthccDRHx6yi0SVi3HsCk9o6QKVl1K6URaN6LaO00q6Q2R1DK0kDPS5kf9x7cPpmXN67zhYL1wGf/nAk+A0Dr0xRQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xAPVRUNKAh9vxsu3/UT95s6iB6ag+u8YY51gRQX/z7v4MEZ2+DHRXf6QpF2x4M9QqODWb+ZUnfqgwLPiqqnTktKFshOwU6lrHlNZ0ZJjag3rX8hgjwm62pDEa31bHrV8/I5GqOLBlZl1ahixjMmhwrrTlcHOVBPW26WiLjhv/zZwmEOS2DBvb8ehb6QxQ3LGGoNJMjCjis9+oD3nRg0SXVt/tOBYaCailJG0sxvlAjclrYZz0uRcnmN7aI4voasIrdBwF20fGFqtbizJZ8CqNbOTdxaaK6lnSh6TUYIXFjT5pwvpvmSB/fU5CHKp/+rfKZIpN1tJdcy0lk/FRv7DeVciKfXz66G3Wb4NpI7U66jFkkXlVCUUxNcNlAmFUz09jIOKZG0IXNvnnh+zQBX76z5pMpLPDFYJBBRWnkx8PO8HFn1sBz0togHytXf8EM/e
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:47:20.0161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b656b6b-4864-4f51-e6ca-08df03464213
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3688
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

Add EVK ax3005-evb built with AX3005 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3005-evk.c            | 64 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build             |  3 +-
 include/hw/arm/axiado-boards.h | 10 ++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/ax3005-evk.c

diff --git a/hw/arm/ax3005-evk.c b/hw/arm/ax3005-evk.c
new file mode 100644
index 0000000000..b4a38f1b89
--- /dev/null
+++ b/hw/arm/ax3005-evk.c
@@ -0,0 +1,64 @@
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
+#include "qemu/cutils.h"
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
+    if (machine->ram_size != AX3005_DRAM_SIZE) {
+        g_autofree char *size_str = size_to_str(AX3005_DRAM_SIZE);
+
+        error_report("Invalid RAM size, should be %s", size_str);
+        exit(1);
+    }
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
+    mc->default_ram_size = AX3005_DRAM_SIZE;
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


