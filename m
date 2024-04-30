Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2918C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbl-0006r9-Cl; Tue, 30 Apr 2024 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbT-0006ij-ST
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:01 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbR-0001oL-Og
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:59 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51b526f0fc4so7069691e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480135; x=1715084935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/XVft3u1TnXcfWULCA1fWxoECDnyMfyO72+jOrBPL4=;
 b=FLcKm/y5sS1wVYDhI6NyD3FR/EuSIeaT+NKRJL7g7gtZZLtdfsZ8kyIqnodOQ/vVwS
 fq52cMEvDGz/NUUKjlyZhs2qLRrQS2tWpu638FeJeKULZuBfxx00XcactMNrODwK5b9V
 wpm3xYWfMxxvFZ3OMly4h1ttX1PO9uHf+KJoFAoMuxp862CESH0vSsGyeA8SzaQIuTKL
 IZ8vFW79O8LpQ9F6EPnBpoEK2sOJyWBvu/DNkNOipn/i0ruw3BC4F+jDrNhmau9OGUk+
 ntWIL7jyE/5lgffyxQv9kVg6uWyNleadmgmD/KvzPjTjt2sjERzpl096VGGxXp/kU3gB
 F/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480135; x=1715084935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/XVft3u1TnXcfWULCA1fWxoECDnyMfyO72+jOrBPL4=;
 b=FeguuF2EAXDc/bydnlO16FYievyZBQjw9+aD+u9BKoG/qvgSysf2oxqlTXDP5N+StB
 RGx7ggS5XGOsXk8u7UUGgm4MoUSu6Bt6ZXsCcBo3/0xOWmlEzVaDIBBIiSg3HyaVvbds
 x/4NG+IKaBfFBD5qYu4evlQqoODfI90YNKsrOKN8r6LxBmxQXds1v+n3QAatlG2oC7jY
 +hGqyA8CouYhYoNELuY3ZlDoLv65mLD/FdVkLxuYF2r2Q35eieV56Wc1XtvZ4PVpMuOf
 tZsGOC7snyQyD6Sv89mZ74zQOCP4xBm5wVQXvKWmo2cVGHL1D9w5fSfiMR5KQUW2PHi0
 Z1Cg==
X-Gm-Message-State: AOJu0Yz5lh7eaJQaqGFwLoIyzkOodJYdKERFvigLfV0QtiAkELXb/hCq
 oGLgXT+bv2Vy3BTTeXwrHsenQv03wd5LcqLT0pwio/mZe2NrGqoS2gN1cw496OWmB0h5C5+KneD
 L
X-Google-Smtp-Source: AGHT+IGlbPpfglTIHu9qPV598dFthJMmRuG7AWoCKx8JQsZBH7OSUL4m0KLTGtVqOYSdB06y+Eyddg==
X-Received: by 2002:a19:ad0b:0:b0:516:d448:b42a with SMTP id
 t11-20020a19ad0b000000b00516d448b42amr1657561lfc.26.1714480135516; 
 Tue, 30 Apr 2024 05:28:55 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 mc11-20020a170906eb4b00b00a5256d8c956sm14996887ejb.61.2024.04.30.05.28.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/13] accel/tcg: Move @cflags_next_tb from CPUState to TCG
 AccelCPUState
Date: Tue, 30 Apr 2024 14:28:02 +0200
Message-ID: <20240430122808.72025-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

@cflags_next_tb is specific to TCG accelerator, move it to
its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-19-philmd@linaro.org>
---
 accel/tcg/vcpu-state.h    |  2 ++
 include/hw/core/cpu.h     |  1 -
 accel/tcg/cpu-exec.c      | 12 ++++++------
 accel/tcg/tb-maint.c      |  4 ++--
 accel/tcg/tcg-accel-ops.c |  1 +
 accel/tcg/translate-all.c |  2 +-
 accel/tcg/watchpoint.c    |  5 +++--
 hw/core/cpu-common.c      |  1 -
 8 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 3a0ea2d47a..5b09279140 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -13,6 +13,8 @@
  * @plugin_state: per-CPU plugin state
  */
 struct AccelCPUState {
+    uint32_t cflags_next_tb;
+
     sigjmp_buf jmp_env;
 
 #ifdef CONFIG_USER_ONLY
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f1fe43dbea..97a0baf874 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -468,7 +468,6 @@ struct CPUState {
     bool crash_occurred;
     bool exit_request;
     int exclusive_context_count;
-    uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 443b688c01..2edfad78b3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -721,7 +721,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         if (replay_has_exception()
             && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
-            cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
+            cpu->accel->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
         }
 #endif
@@ -784,7 +784,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     if (!icount_enabled()) {
         return false;
     }
-    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
+    if (!(cpu->accel->cflags_next_tb == -1 || cpu->accel->cflags_next_tb & CF_USE_ICOUNT)) {
         return false;
     }
     return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
@@ -798,7 +798,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * skip checking here. Any pending interrupts will get picked up
      * by the next TB we execute under normal cflags.
      */
-    if (cpu->cflags_next_tb != -1 && cpu->cflags_next_tb & CF_NOIRQ) {
+    if (cpu->accel->cflags_next_tb != -1 && cpu->accel->cflags_next_tb & CF_NOIRQ) {
         return false;
     }
 
@@ -948,7 +948,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     if (insns_left > 0 && insns_left < tb->icount)  {
         assert(insns_left <= CF_COUNT_MASK);
         assert(cpu->icount_extra == 0);
-        cpu->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
+        cpu->accel->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
     }
 #endif
 }
@@ -980,11 +980,11 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
              * have CF_INVALID set, -1 is a convenient invalid value that
              * does not require tcg headers for cpu_common_reset.
              */
-            cflags = cpu->cflags_next_tb;
+            cflags = cpu->accel->cflags_next_tb;
             if (cflags == -1) {
                 cflags = curr_cflags(cpu);
             } else {
-                cpu->cflags_next_tb = -1;
+                cpu->accel->cflags_next_tb = -1;
             }
 
             if (check_for_breakpoints(cpu, pc, &cflags)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 19ae6793f3..2d5faca9fd 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1084,7 +1084,7 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
         CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         return true;
     }
     return false;
@@ -1154,7 +1154,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     if (current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        current_cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 56bbad9fcd..d9132a5835 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -89,6 +89,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->neg.can_do_io = true;
+    cpu->accel->cflags_next_tb = -1;
 }
 
 /* mask must never be zero, except for A20 change call */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b67adce20e..3a8199a761 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -631,7 +631,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * operations only (which execute after completion) so we don't
      * double instrument the instruction.
      */
-    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
+    cpu->accel->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = cpu->cc->get_pc(cpu);
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index d3aab11458..0a40bfdc85 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -26,6 +26,7 @@
 #include "sysemu/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/vcpu-state.h"
 
 /*
  * Return true if this watchpoint address matches the specified
@@ -100,7 +101,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                  */
                 if (!cpu->neg.can_do_io) {
                     /* Force execution of one insn next time.  */
-                    cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+                    cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
                     cpu_loop_exit_restore(cpu, ra);
                 }
                 /*
@@ -132,7 +133,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
-                cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+                cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
                 mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ea342213d6..b6631b6245 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -124,7 +124,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu->icount_extra = 0;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
-    cpu->cflags_next_tb = -1;
 
     cpu_exec_reset_hold(cpu);
 }
-- 
2.41.0


