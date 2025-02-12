Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56BBC0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3F7-0000eX-9v; Tue, 11 Feb 2025 22:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ti3F3-0000dt-ET
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:49 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ti3F0-00017L-38
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:49 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxmnGZEqxne8hyAA--.3251S3;
 Wed, 12 Feb 2025 11:16:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPseSEqxnkg0NAA--.51828S7;
 Wed, 12 Feb 2025 11:16:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 5/6] hw/loongarch/virt: Remove unused ipistate
Date: Wed, 12 Feb 2025 11:16:32 +0800
Message-Id: <20250212031633.3548108-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250212031633.3548108-1-maobibo@loongson.cn>
References: <20250212031633.3548108-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPseSEqxnkg0NAA--.51828S7
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

Field ipistate in LoongArch CPU object is not used any more,
remove it here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 5 -----
 target/loongarch/cpu.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index db48217228..da98b21c58 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -324,8 +324,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     DeviceState *pch_pic, *pch_msi, *cpudev;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
-    LoongArchCPU *lacpu;
-    CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
 
@@ -386,12 +384,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
         cpudev = DEVICE(cpu_state);
-        lacpu = LOONGARCH_CPU(cpu_state);
-        env = &(lacpu->env);
 
         /* connect ipi irq to cpu irq */
         qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
-        env->ipistate = ipi;
     }
 
     /* Create EXTIOI device */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8eee49a984..f2a23b7a43 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -385,8 +385,6 @@ typedef struct CPUArchState {
     bool load_elf;
     uint64_t elf_address;
     uint32_t mp_state;
-    /* Store ipistate to access from this struct */
-    DeviceState *ipistate;
 
     struct loongarch_boot_info *boot_info;
 #endif
-- 
2.43.5


