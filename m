Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD2AE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 03:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUzxJ-00058k-ND; Mon, 06 Jan 2025 22:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tUzxG-00057H-Ny
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:30 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tUzxD-0004c0-5S
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:30 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxK6ylmnxnVvheAA--.1302S3;
 Tue, 07 Jan 2025 11:08:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxfcejmnxnn2gXAA--.35275S5;
 Tue, 07 Jan 2025 11:08:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] hw/intc/loongson_ipi: Remove property num_cpu from
 loongson_ipi_common
Date: Tue,  7 Jan 2025 11:08:15 +0800
Message-Id: <20250107030819.90442-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250107030819.90442-1-maobibo@loongson.cn>
References: <20250107030819.90442-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxfcejmnxnn2gXAA--.35275S5
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With mips64 loongson ipi, num_cpu property is used, with loongarch
ipi, num_cpu can be acquired from possible_cpu_arch_ids.

Here remove property num_cpu from loongson_ipi_common, and this piece
of code is put into loongson ipi and loongarch ipi.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c       | 6 ++++++
 hw/intc/loongson_ipi.c        | 6 ++++++
 hw/intc/loongson_ipi_common.c | 6 ------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index e6126e4fbc..9c7636c4d6 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
+#include "hw/qdev-properties.h"
 #include "target/loongarch/cpu.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
@@ -75,6 +76,10 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static const Property loongarch_ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
+};
+
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
@@ -83,6 +88,7 @@ static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 
     device_class_set_parent_realize(dc, loongarch_ipi_realize,
                                     &lic->parent_realize);
+    device_class_set_props(dc, loongarch_ipi_properties);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
 }
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 1ed39b90ea..29e92d48fd 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/loongson_ipi.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "target/mips/cpu.h"
 
@@ -75,6 +76,10 @@ static void loongson_ipi_unrealize(DeviceState *dev)
     k->parent_unrealize(dev);
 }
 
+static const Property loongson_ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
+};
+
 static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -85,6 +90,7 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
                                     &lic->parent_realize);
     device_class_set_parent_unrealize(dc, loongson_ipi_unrealize,
                                       &lic->parent_unrealize);
+    device_class_set_props(dc, loongson_ipi_properties);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = cpu_by_arch_id;
 }
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 5d46679ea1..363cddc54c 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -9,7 +9,6 @@
 #include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "trace.h"
@@ -301,10 +300,6 @@ static const VMStateDescription vmstate_loongson_ipi_common = {
     }
 };
 
-static const Property ipi_common_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
-};
-
 static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -314,7 +309,6 @@ static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
                                     &licc->parent_realize);
     device_class_set_parent_unrealize(dc, loongson_ipi_common_unrealize,
                                       &licc->parent_unrealize);
-    device_class_set_props(dc, ipi_common_properties);
     dc->vmsd = &vmstate_loongson_ipi_common;
 }
 
-- 
2.39.3


