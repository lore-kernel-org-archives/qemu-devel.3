Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12850CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 03:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ1sn-0000kr-D5; Tue, 11 Nov 2025 22:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1vJ1sl-0000iN-I3
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 22:50:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1vJ1sj-0005TY-I8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 22:50:55 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxVNAaBBRpUEciAA--.8797S3;
 Wed, 12 Nov 2025 11:50:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxysAQBBRp9iMwAQ--.50588S3;
 Wed, 12 Nov 2025 11:50:48 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH V2 1/2] Modify the interrupt trigger type in loongarch virt
 fdt to macro definition
Date: Wed, 12 Nov 2025 11:26:32 +0800
Message-Id: <56832788ca15ee896e4e7bd2a635e65e188d75c2.1762917185.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1762917185.git.lixianglai@loongson.cn>
References: <cover.1762917185.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxysAQBBRp9iMwAQ--.50588S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

In the loongarch virt fdt file, the interrupt trigger type directly
uses magic numbers. Now, refer to the definitions in the linux kernel and
use macro definitions.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>

 hw/loongarch/virt-fdt-build.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 1f0ba01f71..7333019cf7 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -16,6 +16,11 @@
 #include "system/reset.h"
 #include "target/loongarch/cpu.h"
 
+#define FDT_IRQ_TYPE_EDGE_RISING  1
+#define FDT_IRQ_TYPE_EDGE_FALLING 2
+#define FDT_IRQ_TYPE_LEVEL_HIGH   4
+#define FDT_IRQ_TYPE_LEVEL_LOW    8
+
 static void create_fdt(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
@@ -415,7 +420,8 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     if (chosen) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     }
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq,
+                           FDT_IRQ_TYPE_LEVEL_HIGH);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
@@ -435,7 +441,8 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
                             "loongson,ls7a-rtc");
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
+                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
+                           FDT_IRQ_TYPE_LEVEL_HIGH);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
-- 
2.39.1


