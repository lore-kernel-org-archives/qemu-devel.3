Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F5AC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygeL-00050W-SH; Mon, 24 Aug 2026 22:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeK-0004z9-Dx; Mon, 24 Aug 2026 22:12:28 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeI-0005rj-Q0; Mon, 24 Aug 2026 22:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpYrVRwZqetlXWILrXJyEYQtmVT2Ne1fM7RJREnYB7LdDtsc0VnKt0KuXo4nqO/gUnyprixhgkJ3ZAn8dVmSLCT5xBt00S27Pp5CYMdHs/gTON69ntqqEVSRSZP78JFoBXgn0uVXoHEjaagq3qZqCdjkrZK3tpGKQp6+tfezpsXRKYLf4SwApKL1Y/aLZ213//OQXlYSrI35yFUW7kgGZ4st0daeSThYKItK3eI7UBwvxHMiEHmiwRuvOII6OlqapsvWCEcFcoHVAaAXcTDMOgrdMwjMf7Lm8qfsu7O2mJJi8cCOukScN3oYNvopE5syQhfaHvZLd6I///ELVzqAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXSXr47IIhO03KTt1Q7Zs+31I5RV+fORETzszhKO4Y8=;
 b=BYA3fPlnSCn6r1iyjW4Dh8aFNfRJHLkOaU8Mq3iYRPBcj40j+4vrudH47dSACy/O7e9CpyG3ZkZaVeuuoOi9V8xjBDmF+N3+5ASVCPoDsZjLm7P839eK5aKCRrHlUAIU3uxrXdaA8xwDUdpCs2653FSibcSyHRo2WhGEh+R5Mt8uRVuGWcgJcAo65sXG8MfDeMO1h2uEJ7FVeRqqViDyrtj3VT6dtNxzdL/NAHn9ANJPiVu+R1nkboEJ/oiiK5eHYWn9RHmUtmzy4jbD1bTSSiz4KrfJ/pahU/UZyrnJ7MSkUUvKyE5y+bOXnZkK9+Q4e6PLHr1oZmVo7AfugxS9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXSXr47IIhO03KTt1Q7Zs+31I5RV+fORETzszhKO4Y8=;
 b=TC2mIwoKXUBU7c0Iag0mutmPRPJgSzBHoZvMtoZlqXQjaaqvqS5902ZtPZz4+SqHFzPNMR3D7YQs3B8vn6eUucEF9P0ROXOPpi+94Wo96akZtvRhnsiFicLYR+pZCFIw4eCmGbZCaXT79+gHgzQkth1L8ssOolCwDGMCdDsK2JkWrTRlBUHShPR0TJKw6FnJrYspPocX+6o8ex4f1KbeMa3mHE1Cp/36yGWH2BzAGuyFaUu7epkWeEXwdKrSMQXfL04sjTJm9oF2A4tJDknTCMdlRuHSAvUbvuJ2Ai5/j1tmHREE7y/lyPqlb/5JdG9UrJOR5j1ArZcvKAOzC1ww4g==
Received: from CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27)
 by DM3PPF733AD0540.namprd18.prod.outlook.com (2603:10b6:f:fc00::6ae)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:12:20 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::51) by CH0PR03CA0112.outlook.office365.com
 (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 02:12:18 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 0E42240BFE0D;
 Mon, 24 Aug 2026 19:12:17 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 163wangjack@gmail.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 5/5] hw/arm: Add Axiado Ax3005 EVB
Date: Mon, 24 Aug 2026 19:11:55 -0700
Message-Id: <20260825021155.2475879-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825021155.2475879-1-kchiu@axiado.com>
References: <20260825021155.2475879-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM3PPF733AD0540:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c45ec08a-a5f1-4e8f-eae5-08df024e4b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nnlpiTgtwdk+jSvQIzscOT+3mJoBj3K09trCJYl5yHAlTq8Mnc3mmLN4VA9iPyn9Hs5x5uZ4NqzQiRJz1a6Sv2Dy69nBqJyMicp5CWsE4Z5b5wWF+Xx+XqjjGeJckr8k4ggZdFUVhz2HMiesRCUIQPiip0So6YdP2A3w52RjyPoRudiEvWmhsJwdbuipMjGmvJw28m6O47tOV7te/5grx0y2S8laFDhYZJEGZ7T2Toyi+8t9IJIoVD0MU4iByOrbn0tUdXykY8A0zdDHTQeCO9E73P2az2fg9omL+84bfzhXE1e5OzglzXMW3ArXq+o0m5Pl4yz5vO7NsgMFs8BSQyKT/2c8KhnXcVmVJ+wU3uqVII+mP+osGjAj+sEkhJVOg7VJKGQZzci/r8DERtb6hc8lhdAL95240k2PNectPC082fjpNUxY7JZshxp2XaU/u6ECc3UzyF2D3+Av2F25pxFDr4aohlVznWw4vjSVoRCg92OORYjddN/veWMvyLu9G4oxgq7BK0Py3KwqUFNirfvZxIfKtcszJrh0k1+MB/FeVZuUAWnYgbFYE6xf8dYLPkdtkx30QEdEt4i4G1uqOF0GunU2xGEDQbG+ofdmqmtG61Hj1BtRMpjyUJBlBgOzXmmjqoeINmEkA5HHDogM6hqgKCmx0dIsuJ23akdUlsz4M9UlmCdgAqdc0dDeSPFNjG+dLmU3CBvW1LnDjTOktQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UPYO3gAtNbUJ5nkNTR3XkyC0Nx6zmZi/0GHx9xtLIMn5V6qdPtcuHJ0abkl38vTPAG9XlRVamdpG+t/Il7SV8Ue/8YUhi8GOkvIwS3zMfvvScqAPmhkFg3U/HMkbBQ00mf0oL/g0LnRzYrHHvn+a8WVZ3OuRJBPO4aBRvw9rw6MK4hE204wSvpPfI6KedsZPNTgKC+0FH2tgeLwYK3yIgRI0coWxSrLU3CHFRqhperuMaZ6llqC0kCgNjetL8Dp+6XckSkTNepkE8WRKdyf8VEpO1b6gdluFFYhc8SmA2XYq05t+vvp8OHDAobAnckXqzfQzsCdVnMZVeY4OVjAUb4XWZA85CNdMsKwNc4dgvMooaVEygYCdAZjEOXhbn3PTs5nfpmUZYXmqPiQVsIl1HYC8wDEP0wRtTXJm8zpgTaJBoTBp55K78dwp0qxWEKvi
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:12:18.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45ec08a-a5f1-4e8f-eae5-08df024e4b0c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF733AD0540
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


