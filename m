Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4D6CF58F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZa1-0007Lc-N7; Fri, 20 Sep 2024 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1srZZq-0006fb-9Q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1srZZm-0003xV-Kh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxC+rFOu1mSO8LAA--.27473S3;
 Fri, 20 Sep 2024 17:05:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn+TDOu1mdmoKAA--.59343S3;
 Fri, 20 Sep 2024 17:05:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 01/10] include: Add loongarch_extioi_common header file
Date: Fri, 20 Sep 2024 17:04:58 +0800
Message-Id: <20240920090507.2692125-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240920090507.2692125-1-maobibo@loongson.cn>
References: <20240920090507.2692125-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TDOu1mdmoKAA--.59343S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add common header file include/hw/intc/loongarch_extioi_common.h, and
move some macro definition from include/hw/intc/loongarch_extioi.h to
the common header file.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongarch_extioi.h        | 50 +------------------
 include/hw/intc/loongarch_extioi_common.h | 58 +++++++++++++++++++++++
 2 files changed, 59 insertions(+), 49 deletions(-)
 create mode 100644 include/hw/intc/loongarch_extioi_common.h

diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 626a37dfa1..b1f87cd246 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -5,58 +5,10 @@
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
 
-#include "hw/sysbus.h"
-#include "hw/loongarch/virt.h"
-
 #ifndef LOONGARCH_EXTIOI_H
 #define LOONGARCH_EXTIOI_H
 
-#define LS3A_INTC_IP               8
-#define EXTIOI_IRQS                (256)
-#define EXTIOI_IRQS_BITMAP_SIZE    (256 / 8)
-/* irq from EXTIOI is routed to no more than 4 cpus */
-#define EXTIOI_CPUS                (4)
-/* map to ipnum per 32 irqs */
-#define EXTIOI_IRQS_IPMAP_SIZE     (256 / 32)
-#define EXTIOI_IRQS_COREMAP_SIZE   256
-#define EXTIOI_IRQS_NODETYPE_COUNT  16
-#define EXTIOI_IRQS_GROUP_COUNT    8
-
-#define APIC_OFFSET                  0x400
-#define APIC_BASE                    (0x1000ULL + APIC_OFFSET)
-
-#define EXTIOI_NODETYPE_START        (0x4a0 - APIC_OFFSET)
-#define EXTIOI_NODETYPE_END          (0x4c0 - APIC_OFFSET)
-#define EXTIOI_IPMAP_START           (0x4c0 - APIC_OFFSET)
-#define EXTIOI_IPMAP_END             (0x4c8 - APIC_OFFSET)
-#define EXTIOI_ENABLE_START          (0x600 - APIC_OFFSET)
-#define EXTIOI_ENABLE_END            (0x620 - APIC_OFFSET)
-#define EXTIOI_BOUNCE_START          (0x680 - APIC_OFFSET)
-#define EXTIOI_BOUNCE_END            (0x6a0 - APIC_OFFSET)
-#define EXTIOI_ISR_START             (0x700 - APIC_OFFSET)
-#define EXTIOI_ISR_END               (0x720 - APIC_OFFSET)
-#define EXTIOI_COREISR_START         (0x800 - APIC_OFFSET)
-#define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
-#define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
-#define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
-#define EXTIOI_SIZE                  0x800
-
-#define EXTIOI_VIRT_BASE             (0x40000000)
-#define EXTIOI_VIRT_SIZE             (0x1000)
-#define EXTIOI_VIRT_FEATURES         (0x0)
-#define  EXTIOI_HAS_VIRT_EXTENSION   (0)
-#define  EXTIOI_HAS_ENABLE_OPTION    (1)
-#define  EXTIOI_HAS_INT_ENCODE       (2)
-#define  EXTIOI_HAS_CPU_ENCODE       (3)
-#define  EXTIOI_VIRT_HAS_FEATURES    (BIT(EXTIOI_HAS_VIRT_EXTENSION)  \
-                                      | BIT(EXTIOI_HAS_ENABLE_OPTION) \
-                                      | BIT(EXTIOI_HAS_CPU_ENCODE))
-#define EXTIOI_VIRT_CONFIG           (0x4)
-#define  EXTIOI_ENABLE               (1)
-#define  EXTIOI_ENABLE_INT_ENCODE    (2)
-#define  EXTIOI_ENABLE_CPU_ENCODE    (3)
-#define EXTIOI_VIRT_COREMAP_START    (0x40)
-#define EXTIOI_VIRT_COREMAP_END      (0x240)
+#include "hw/intc/loongarch_extioi_common.h"
 
 typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
new file mode 100644
index 0000000000..09e2b760f3
--- /dev/null
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch 3A5000 ext interrupt controller definitions
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef LOONGARCH_EXTIOI_COMMON_H
+#define LOONGARCH_EXTIOI_COMMON_H
+
+#include "hw/sysbus.h"
+#include "hw/loongarch/virt.h"
+
+#define LS3A_INTC_IP                 8
+#define EXTIOI_IRQS                  (256)
+#define EXTIOI_IRQS_BITMAP_SIZE      (256 / 8)
+/* irq from EXTIOI is routed to no more than 4 cpus */
+#define EXTIOI_CPUS                  (4)
+/* map to ipnum per 32 irqs */
+#define EXTIOI_IRQS_IPMAP_SIZE       (256 / 32)
+#define EXTIOI_IRQS_COREMAP_SIZE     256
+#define EXTIOI_IRQS_NODETYPE_COUNT   16
+#define EXTIOI_IRQS_GROUP_COUNT      8
+
+#define APIC_OFFSET                  0x400
+#define APIC_BASE                    (0x1000ULL + APIC_OFFSET)
+#define EXTIOI_NODETYPE_START        (0x4a0 - APIC_OFFSET)
+#define EXTIOI_NODETYPE_END          (0x4c0 - APIC_OFFSET)
+#define EXTIOI_IPMAP_START           (0x4c0 - APIC_OFFSET)
+#define EXTIOI_IPMAP_END             (0x4c8 - APIC_OFFSET)
+#define EXTIOI_ENABLE_START          (0x600 - APIC_OFFSET)
+#define EXTIOI_ENABLE_END            (0x620 - APIC_OFFSET)
+#define EXTIOI_BOUNCE_START          (0x680 - APIC_OFFSET)
+#define EXTIOI_BOUNCE_END            (0x6a0 - APIC_OFFSET)
+#define EXTIOI_ISR_START             (0x700 - APIC_OFFSET)
+#define EXTIOI_ISR_END               (0x720 - APIC_OFFSET)
+#define EXTIOI_COREISR_START         (0x800 - APIC_OFFSET)
+#define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
+#define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
+#define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
+#define EXTIOI_SIZE                  0x800
+
+#define EXTIOI_VIRT_BASE             (0x40000000)
+#define EXTIOI_VIRT_SIZE             (0x1000)
+#define EXTIOI_VIRT_FEATURES         (0x0)
+#define  EXTIOI_HAS_VIRT_EXTENSION   (0)
+#define  EXTIOI_HAS_ENABLE_OPTION    (1)
+#define  EXTIOI_HAS_INT_ENCODE       (2)
+#define  EXTIOI_HAS_CPU_ENCODE       (3)
+#define  EXTIOI_VIRT_HAS_FEATURES    (BIT(EXTIOI_HAS_VIRT_EXTENSION)  \
+                                      | BIT(EXTIOI_HAS_ENABLE_OPTION) \
+                                      | BIT(EXTIOI_HAS_CPU_ENCODE))
+#define EXTIOI_VIRT_CONFIG           (0x4)
+#define  EXTIOI_ENABLE               (1)
+#define  EXTIOI_ENABLE_INT_ENCODE    (2)
+#define  EXTIOI_ENABLE_CPU_ENCODE    (3)
+#define EXTIOI_VIRT_COREMAP_START    (0x40)
+#define EXTIOI_VIRT_COREMAP_END      (0x240)
+#endif /* LOONGARCH_EXTIOI_H */
-- 
2.39.3


