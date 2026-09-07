Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131C1C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3PGH-0000eJ-Av; Sun, 06 Sep 2026 22:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3PGF-0000dc-LO
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:39:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3PGD-0007vP-4r
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:39:07 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxYdHBI55q_EoJAA--.27085S3;
 Mon, 07 Sep 2026 10:38:57 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxpMy8I55qtj0cAA--.33287S3;
 Mon, 07 Sep 2026 10:38:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/loongarch: Rename function name constant_timer
 with timer
Date: Mon,  7 Sep 2026 10:40:10 +0800
Message-ID: <20260907024012.2992255-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907024012.2992255-1-maobibo@loongson.cn>
References: <20260907024012.2992255-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMy8I55qtj0cAA--.33287S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur4fGw1UArW5XrWxXF1fGrX_yoW7JF4xpr
 Wxury7Kr48trZ8Wa4kt3s8WF1DXr42ga42v3WftrWIkFs7Xrn7W3W8trsFgF45Aa48Wry2
 qFn5Z3WUXF47ZwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
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

There is only one timer type on LoongArch, its frequency is fixed at
100MHZ. Here rename function name constant_timer_xxx with timer_xxx for
simplity.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                | 2 +-
 target/loongarch/internals.h          | 9 ++++-----
 target/loongarch/tcg/constant_timer.c | 9 ++++-----
 target/loongarch/tcg/csr_helper.c     | 4 ++--
 target/loongarch/tcg/op_helper.c      | 2 +-
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 84a130956d..cba227fd1b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -762,7 +762,7 @@ static void loongarch_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
 #ifdef CONFIG_TCG
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
-                  &loongarch_constant_timer_cb, cpu);
+                  &cpu_loongarch_timer_cb, cpu);
 #endif
 #endif
 }
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 0b670f9466..8c5f095782 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -34,11 +34,10 @@ extern const VMStateDescription vmstate_loongarch_cpu;
 void loongarch_cpu_update_irq(LoongArchCPU *cpu, uint64_t old);
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
 
-void loongarch_constant_timer_cb(void *opaque);
-uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
-uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
-void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
-                                               uint64_t value);
+void cpu_loongarch_timer_cb(void *opaque);
+uint64_t cpu_loongarch_get_timer_counter(LoongArchCPU *cpu);
+uint64_t cpu_loongarch_get_timer_ticks(LoongArchCPU *cpu);
+void cpu_loongarch_set_timer_config(LoongArchCPU *cpu, uint64_t value);
 bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
index b91ad1de69..a25312b9ab 100644
--- a/target/loongarch/tcg/constant_timer.c
+++ b/target/loongarch/tcg/constant_timer.c
@@ -15,12 +15,12 @@
 #define CONSTANT_TIMER_TICK_MASK    0xfffffffffffcUL
 #define CONSTANT_TIMER_ENABLE       0x1UL
 
-uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu)
+uint64_t cpu_loongarch_get_timer_counter(LoongArchCPU *cpu)
 {
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
 }
 
-uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
+uint64_t cpu_loongarch_get_timer_ticks(LoongArchCPU *cpu)
 {
     CPULoongArchState *env = &cpu->env;
     CPUSysState *sys = env_sys(env);
@@ -36,8 +36,7 @@ uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
     return sys->CSR_TVAL;
 }
 
-void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
-                                               uint64_t value)
+void cpu_loongarch_set_timer_config(LoongArchCPU *cpu, uint64_t value)
 {
     CPULoongArchState *env = &cpu->env;
     CPUSysState *sys = env_sys(env);
@@ -55,7 +54,7 @@ void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
     }
 }
 
-void loongarch_constant_timer_cb(void *opaque)
+void cpu_loongarch_timer_cb(void *opaque)
 {
     LoongArchCPU *cpu  = opaque;
     CPULoongArchState *env = &cpu->env;
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 155482efc6..b1a0b005e9 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -74,7 +74,7 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
 {
     LoongArchCPU *cpu = env_archcpu(env);
 
-    return cpu_loongarch_get_constant_timer_ticks(cpu);
+    return cpu_loongarch_get_timer_ticks(cpu);
 }
 
 target_ulong helper_csrrd_msgir(CPULoongArchState *env)
@@ -139,7 +139,7 @@ target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_TCFG;
 
-    cpu_loongarch_store_constant_timer_config(cpu, val);
+    cpu_loongarch_set_timer_config(cpu, val);
 
     return old_v;
 }
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f41f0cb1e6..c090d5b12e 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -81,7 +81,7 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
         do_raise_exception(env, EXCCODE_IPE, GETPC());
     }
 
-    return cpu_loongarch_get_constant_timer_counter(cpu);
+    return cpu_loongarch_get_timer_counter(cpu);
 #endif
 }
 
-- 
2.54.0


