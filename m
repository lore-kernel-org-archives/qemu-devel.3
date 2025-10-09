Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DE8CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qG6-0006hV-MO; Thu, 09 Oct 2025 09:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v6qFp-0006bp-8C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v6qFU-0006gY-GI
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx6tHIsedoqkkUAA--.43603S3;
 Thu, 09 Oct 2025 20:59:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxG8HCsedoBqnWAA--.42888S6;
 Thu, 09 Oct 2025 20:59:51 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/6] target/loongarch: Move TCG specified functions to tcg_cpu.c
Date: Thu,  9 Oct 2025 20:35:59 +0800
Message-Id: <20251009123601.2380901-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251009123601.2380901-1-gaosong@loongson.cn>
References: <20251009123601.2380901-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxG8HCsedoBqnWAA--.42888S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

New file target/loongarch/tcg/tcg_cpu.c is created, and move TCG
specified functions to here from file target/loongarch/cpu.c

It is only code movement and there is no any function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250929035338.2320419-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c               | 262 +-------------------------
 target/loongarch/internals.h         |   2 +
 target/loongarch/tcg/meson.build     |   1 +
 target/loongarch/tcg/tcg_cpu.c       | 266 +++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_loongarch.h |   1 +
 5 files changed, 272 insertions(+), 260 deletions(-)
 create mode 100644 target/loongarch/tcg/tcg_cpu.c

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 993602fb8c..245c6d3ab9 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -28,11 +28,6 @@
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
 #endif
-#ifdef CONFIG_TCG
-#include "accel/tcg/cpu-ldst.h"
-#include "accel/tcg/cpu-ops.h"
-#include "tcg/tcg.h"
-#endif
 #include "tcg/tcg_loongarch.h"
 
 const char * const regnames[32] = {
@@ -140,18 +135,8 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
-{
-    bool ret = 0;
-
-    ret = (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE) &&
-          !(FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)));
-
-    return ret;
-}
-
 /* Check if there is pending and not masked out interrupt */
-static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
@@ -163,217 +148,8 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 }
 #endif
 
-#ifdef CONFIG_TCG
-#ifndef CONFIG_USER_ONLY
-static void loongarch_cpu_do_interrupt(CPUState *cs)
-{
-    CPULoongArchState *env = cpu_env(cs);
-    bool update_badinstr = 1;
-    int cause = -1;
-    bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
-    uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
-
-    if (cs->exception_index != EXCCODE_INT) {
-        qemu_log_mask(CPU_LOG_INT,
-                     "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                     " TLBRERA " TARGET_FMT_lx " exception: %d (%s)\n",
-                     __func__, env->pc, env->CSR_ERA, env->CSR_TLBRERA,
-                     cs->exception_index,
-                     loongarch_exception_name(cs->exception_index));
-    }
-
-    switch (cs->exception_index) {
-    case EXCCODE_DBP:
-        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DCL, 1);
-        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, ECODE, 0xC);
-        goto set_DERA;
-    set_DERA:
-        env->CSR_DERA = env->pc;
-        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
-        set_pc(env, env->CSR_EENTRY + 0x480);
-        break;
-    case EXCCODE_INT:
-        if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
-            env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
-            goto set_DERA;
-        }
-        QEMU_FALLTHROUGH;
-    case EXCCODE_PIF:
-    case EXCCODE_ADEF:
-        cause = cs->exception_index;
-        update_badinstr = 0;
-        break;
-    case EXCCODE_SYS:
-    case EXCCODE_BRK:
-    case EXCCODE_INE:
-    case EXCCODE_IPE:
-    case EXCCODE_FPD:
-    case EXCCODE_FPE:
-    case EXCCODE_SXD:
-    case EXCCODE_ASXD:
-        env->CSR_BADV = env->pc;
-        QEMU_FALLTHROUGH;
-    case EXCCODE_BCE:
-    case EXCCODE_ADEM:
-    case EXCCODE_PIL:
-    case EXCCODE_PIS:
-    case EXCCODE_PME:
-    case EXCCODE_PNR:
-    case EXCCODE_PNX:
-    case EXCCODE_PPI:
-        cause = cs->exception_index;
-        break;
-    default:
-        qemu_log("Error: exception(%d) has not been supported\n",
-                 cs->exception_index);
-        abort();
-    }
-
-    if (update_badinstr) {
-        env->CSR_BADI = cpu_ldl_code(env, env->pc);
-    }
-
-    /* Save PLV and IE */
-    if (tlbfill) {
-        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
-                                       FIELD_EX64(env->CSR_CRMD,
-                                       CSR_CRMD, PLV));
-        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
-                                       FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
-        /* set the DA mode */
-        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
-        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
-        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
-                                      PC, (env->pc >> 2));
-    } else {
-        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
-                                    EXCODE_MCODE(cause));
-        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
-                                    EXCODE_SUBCODE(cause));
-        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
-                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
-        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
-                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
-        env->CSR_ERA = env->pc;
-    }
-
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
-
-    if (vec_size) {
-        vec_size = (1 << vec_size) * 4;
-    }
-
-    if  (cs->exception_index == EXCCODE_INT) {
-        /* Interrupt */
-        uint32_t vector = 0;
-        uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
-        pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
-
-        /* Find the highest-priority interrupt. */
-        vector = 31 - clz32(pending);
-        set_pc(env, env->CSR_EENTRY + \
-               (EXCCODE_EXTERNAL_INT + vector) * vec_size);
-        qemu_log_mask(CPU_LOG_INT,
-                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                      " cause %d\n" "    A " TARGET_FMT_lx " D "
-                      TARGET_FMT_lx " vector = %d ExC " TARGET_FMT_lx "ExS"
-                      TARGET_FMT_lx "\n",
-                      __func__, env->pc, env->CSR_ERA,
-                      cause, env->CSR_BADV, env->CSR_DERA, vector,
-                      env->CSR_ECFG, env->CSR_ESTAT);
-    } else {
-        if (tlbfill) {
-            set_pc(env, env->CSR_TLBRENTRY);
-        } else {
-            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
-        }
-        qemu_log_mask(CPU_LOG_INT,
-                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                      " cause %d%s\n, ESTAT " TARGET_FMT_lx
-                      " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
-                      "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
-                      " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->pc,
-                      tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
-                      cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
-                      env->CSR_ECFG,
-                      tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
-                      env->CSR_BADI, env->gpr[11], cs->cpu_index,
-                      env->CSR_ASID);
-    }
-    cs->exception_index = -1;
-}
-
-static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-                                                vaddr addr, unsigned size,
-                                                MMUAccessType access_type,
-                                                int mmu_idx, MemTxAttrs attrs,
-                                                MemTxResult response,
-                                                uintptr_t retaddr)
-{
-    CPULoongArchState *env = cpu_env(cs);
-
-    if (access_type == MMU_INST_FETCH) {
-        do_raise_exception(env, EXCCODE_ADEF, retaddr);
-    } else {
-        do_raise_exception(env, EXCCODE_ADEM, retaddr);
-    }
-}
-
-static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-{
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
-        CPULoongArchState *env = cpu_env(cs);
-
-        if (cpu_loongarch_hw_interrupts_enabled(env) &&
-            cpu_loongarch_hw_interrupts_pending(env)) {
-            /* Raise it */
-            cs->exception_index = EXCCODE_INT;
-            loongarch_cpu_do_interrupt(cs);
-            return true;
-        }
-    }
-    return false;
-}
-
-static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
-                                    vaddr result, vaddr base)
-{
-    return is_va32(cpu_env(cs)) ? (uint32_t)result : result;
-}
-#endif
-
-static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
-{
-    CPULoongArchState *env = cpu_env(cs);
-    uint32_t flags;
-
-    flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-    flags |= is_va32(env) * HW_FLAGS_VA32;
-
-    return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
-}
-
-static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
-                                              const TranslationBlock *tb)
-{
-    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
-    set_pc(cpu_env(cs), tb->pc);
-}
-
-static void loongarch_restore_state_to_opc(CPUState *cs,
-                                           const TranslationBlock *tb,
-                                           const uint64_t *data)
-{
-    set_pc(cpu_env(cs), data[0]);
-}
-#endif /* CONFIG_TCG */
-
 #ifndef CONFIG_USER_ONLY
-static bool loongarch_cpu_has_work(CPUState *cs)
+bool loongarch_cpu_has_work(CPUState *cs)
 {
     bool has_work = false;
 
@@ -386,16 +162,6 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    CPULoongArchState *env = cpu_env(cs);
-
-    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    }
-    return MMU_DA_IDX;
-}
-
 static void loongarch_la464_init_csr(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
@@ -911,30 +677,6 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#ifdef CONFIG_TCG
-static const TCGCPUOps loongarch_tcg_ops = {
-    .guest_default_memory_order = 0,
-    .mttcg_supported = true,
-
-    .initialize = loongarch_translate_init,
-    .translate_code = loongarch_translate_code,
-    .get_tb_cpu_state = loongarch_get_tb_cpu_state,
-    .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
-    .restore_state_to_opc = loongarch_restore_state_to_opc,
-    .mmu_index = loongarch_cpu_mmu_index,
-
-#ifndef CONFIG_USER_ONLY
-    .tlb_fill = loongarch_cpu_tlb_fill,
-    .pointer_wrap = loongarch_pointer_wrap,
-    .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
-    .cpu_exec_halt = loongarch_cpu_has_work,
-    .cpu_exec_reset = cpu_reset,
-    .do_interrupt = loongarch_cpu_do_interrupt,
-    .do_transaction_failed = loongarch_cpu_do_transaction_failed,
-#endif
-};
-#endif /* CONFIG_TCG */
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index e50d109767..e994f5a3d3 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -41,6 +41,8 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
+bool loongarch_cpu_has_work(CPUState *cs);
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
index bdf34f9673..b7adfe46f1 100644
--- a/target/loongarch/tcg/meson.build
+++ b/target/loongarch/tcg/meson.build
@@ -7,6 +7,7 @@ loongarch_ss.add([zlib, gen])
 loongarch_ss.add(files(
   'fpu_helper.c',
   'op_helper.c',
+  'tcg_cpu.c',
   'translate.c',
   'vec_helper.c',
 ))
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
new file mode 100644
index 0000000000..c7f49838e3
--- /dev/null
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch CPU parameters for QEMU.
+ *
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ops.h"
+#include "exec/translation-block.h"
+#include "exec/target_page.h"
+#include "tcg_loongarch.h"
+#include "internals.h"
+
+#ifndef CONFIG_USER_ONLY
+static void loongarch_cpu_do_interrupt(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    bool update_badinstr = 1;
+    int cause = -1;
+    bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
+    uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
+
+    if (cs->exception_index != EXCCODE_INT) {
+        qemu_log_mask(CPU_LOG_INT,
+                     "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
+                     " TLBRERA " TARGET_FMT_lx " exception: %d (%s)\n",
+                     __func__, env->pc, env->CSR_ERA, env->CSR_TLBRERA,
+                     cs->exception_index,
+                     loongarch_exception_name(cs->exception_index));
+    }
+
+    switch (cs->exception_index) {
+    case EXCCODE_DBP:
+        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DCL, 1);
+        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, ECODE, 0xC);
+        goto set_DERA;
+    set_DERA:
+        env->CSR_DERA = env->pc;
+        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
+        set_pc(env, env->CSR_EENTRY + 0x480);
+        break;
+    case EXCCODE_INT:
+        if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
+            env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
+            goto set_DERA;
+        }
+        QEMU_FALLTHROUGH;
+    case EXCCODE_PIF:
+    case EXCCODE_ADEF:
+        cause = cs->exception_index;
+        update_badinstr = 0;
+        break;
+    case EXCCODE_SYS:
+    case EXCCODE_BRK:
+    case EXCCODE_INE:
+    case EXCCODE_IPE:
+    case EXCCODE_FPD:
+    case EXCCODE_FPE:
+    case EXCCODE_SXD:
+    case EXCCODE_ASXD:
+        env->CSR_BADV = env->pc;
+        QEMU_FALLTHROUGH;
+    case EXCCODE_BCE:
+    case EXCCODE_ADEM:
+    case EXCCODE_PIL:
+    case EXCCODE_PIS:
+    case EXCCODE_PME:
+    case EXCCODE_PNR:
+    case EXCCODE_PNX:
+    case EXCCODE_PPI:
+        cause = cs->exception_index;
+        break;
+    default:
+        qemu_log("Error: exception(%d) has not been supported\n",
+                 cs->exception_index);
+        abort();
+    }
+
+    if (update_badinstr) {
+        env->CSR_BADI = cpu_ldl_code(env, env->pc);
+    }
+
+    /* Save PLV and IE */
+    if (tlbfill) {
+        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
+                                       FIELD_EX64(env->CSR_CRMD,
+                                       CSR_CRMD, PLV));
+        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
+                                       FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
+        /* set the DA mode */
+        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
+        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
+        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
+                                      PC, (env->pc >> 2));
+    } else {
+        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
+                                    EXCODE_MCODE(cause));
+        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
+                                    EXCODE_SUBCODE(cause));
+        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
+                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
+        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
+                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
+        env->CSR_ERA = env->pc;
+    }
+
+    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
+    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
+
+    if (vec_size) {
+        vec_size = (1 << vec_size) * 4;
+    }
+
+    if  (cs->exception_index == EXCCODE_INT) {
+        /* Interrupt */
+        uint32_t vector = 0;
+        uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
+        pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
+
+        /* Find the highest-priority interrupt. */
+        vector = 31 - clz32(pending);
+        set_pc(env, env->CSR_EENTRY + \
+               (EXCCODE_EXTERNAL_INT + vector) * vec_size);
+        qemu_log_mask(CPU_LOG_INT,
+                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
+                      " cause %d\n" "    A " TARGET_FMT_lx " D "
+                      TARGET_FMT_lx " vector = %d ExC " TARGET_FMT_lx "ExS"
+                      TARGET_FMT_lx "\n",
+                      __func__, env->pc, env->CSR_ERA,
+                      cause, env->CSR_BADV, env->CSR_DERA, vector,
+                      env->CSR_ECFG, env->CSR_ESTAT);
+    } else {
+        if (tlbfill) {
+            set_pc(env, env->CSR_TLBRENTRY);
+        } else {
+            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
+        }
+        qemu_log_mask(CPU_LOG_INT,
+                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
+                      " cause %d%s\n, ESTAT " TARGET_FMT_lx
+                      " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
+                      "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
+                      " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->pc,
+                      tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
+                      cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
+                      env->CSR_ECFG,
+                      tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
+                      env->CSR_BADI, env->gpr[11], cs->cpu_index,
+                      env->CSR_ASID);
+    }
+    cs->exception_index = -1;
+}
+
+static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                                vaddr addr, unsigned size,
+                                                MMUAccessType access_type,
+                                                int mmu_idx, MemTxAttrs attrs,
+                                                MemTxResult response,
+                                                uintptr_t retaddr)
+{
+    CPULoongArchState *env = cpu_env(cs);
+
+    if (access_type == MMU_INST_FETCH) {
+        do_raise_exception(env, EXCCODE_ADEF, retaddr);
+    } else {
+        do_raise_exception(env, EXCCODE_ADEM, retaddr);
+    }
+}
+
+static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
+{
+    bool ret = 0;
+
+    ret = (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE) &&
+          !(FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)));
+
+    return ret;
+}
+
+static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        CPULoongArchState *env = cpu_env(cs);
+
+        if (cpu_loongarch_hw_interrupts_enabled(env) &&
+            cpu_loongarch_hw_interrupts_pending(env)) {
+            /* Raise it */
+            cs->exception_index = EXCCODE_INT;
+            loongarch_cpu_do_interrupt(cs);
+            return true;
+        }
+    }
+    return false;
+}
+
+static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
+                                    vaddr result, vaddr base)
+{
+    return is_va32(cpu_env(cs)) ? (uint32_t)result : result;
+}
+#endif
+
+static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    uint32_t flags;
+
+    flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    flags |= is_va32(env) * HW_FLAGS_VA32;
+
+    return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
+}
+
+static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
+                                              const TranslationBlock *tb)
+{
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
+    set_pc(cpu_env(cs), tb->pc);
+}
+
+static void loongarch_restore_state_to_opc(CPUState *cs,
+                                           const TranslationBlock *tb,
+                                           const uint64_t *data)
+{
+    set_pc(cpu_env(cs), data[0]);
+}
+
+static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPULoongArchState *env = cpu_env(cs);
+
+    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
+        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    }
+    return MMU_DA_IDX;
+}
+
+const TCGCPUOps loongarch_tcg_ops = {
+    .guest_default_memory_order = 0,
+    .mttcg_supported = true,
+
+    .initialize = loongarch_translate_init,
+    .translate_code = loongarch_translate_code,
+    .get_tb_cpu_state = loongarch_get_tb_cpu_state,
+    .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
+    .restore_state_to_opc = loongarch_restore_state_to_opc,
+    .mmu_index = loongarch_cpu_mmu_index,
+
+#ifndef CONFIG_USER_ONLY
+    .tlb_fill = loongarch_cpu_tlb_fill,
+    .pointer_wrap = loongarch_pointer_wrap,
+    .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
+    .cpu_exec_halt = loongarch_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
+    .do_interrupt = loongarch_cpu_do_interrupt,
+    .do_transaction_failed = loongarch_cpu_do_transaction_failed,
+#endif
+};
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 47702893e3..7fb627f2d6 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -9,6 +9,7 @@
 #include "cpu.h"
 #include "cpu-mmu.h"
 
+extern const TCGCPUOps loongarch_tcg_ops;
 void loongarch_csr_translate_init(void);
 
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.47.0


