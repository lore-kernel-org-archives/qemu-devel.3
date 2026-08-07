Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52848C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsEY2-0001YM-V6; Fri, 07 Aug 2026 02:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wsEXy-0001XO-T1
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:59:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wsEXt-0008Av-Dw
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:59:13 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxVeg3gnVqtDgLAA--.12733S3;
 Fri, 07 Aug 2026 14:59:03 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAxjgc2gnVqX8gmAA--.7931S4;
 Fri, 07 Aug 2026 14:59:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/loongarch/virt: Add bootargs and initrd to device-tree
Date: Fri,  7 Aug 2026 15:00:29 +0800
Message-ID: <20260807070029.1171348-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807070029.1171348-1-maobibo@loongson.cn>
References: <20260807070029.1171348-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxjgc2gnVqX8gmAA--.7931S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tryruF17uFW8CF4kWF1xZwc_yoW8AF1UpF
 4xC3Z8Wry8W3yfArsxX345u3WrXr1kC342qanrWr1FyFn8tw1rWF45C3y8AF4DGas5tFsY
 kFs8Ar98uFy2vrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjpB-UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Add bootarg and initrd information in fdt tree.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-fdt-build.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 6c06b36fca..c6f5d022c5 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -25,6 +25,7 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
     uint8_t rng_seed[32];
+    int ret;
 
     ms->fdt = create_device_tree(&lvms->fdt_size);
     if (!ms->fdt) {
@@ -39,6 +40,32 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
     qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
+    if (ms->kernel_cmdline && *ms->kernel_cmdline) {
+        ret = qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs",
+                                      ms->kernel_cmdline);
+        if (ret < 0) {
+            error_report("set /chosen/bootargs failed");
+            exit(1);
+        }
+    }
+
+    if (lvms->bootinfo.initrd_addr) {
+        ret = qemu_fdt_setprop_cell(ms->fdt, "/chosen", "linux,initrd-start",
+                                    lvms->bootinfo.initrd_addr);
+        if (ret < 0) {
+            error_report("set /chosen/linux,initrd-start failed");
+            exit(1);
+        }
+
+        ret = qemu_fdt_setprop_cell(ms->fdt, "/chosen", "linux,initrd-end",
+                                    lvms->bootinfo.initrd_addr +
+                                    lvms->bootinfo.initrd_size);
+        if (ret < 0) {
+            error_report("set /chosen/linux,initrd-end failed");
+            exit(1);
+        }
+    }
+
     /* Pass seed to RNG */
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
-- 
2.54.0


