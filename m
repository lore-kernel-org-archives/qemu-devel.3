Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F62C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YbA-0007Uo-I2; Mon, 29 Apr 2024 17:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yb1-0007Gw-5z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yay-0003LK-J4
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55e8so25917175e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426290; x=1715031090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hnf3o4XnFK2bwHRx7vZnChEV3e4FPyGXBQfB4lUUGyk=;
 b=VoTCsT6gy9TroiuqOPYT9hx1xJktA0zfPDstINDygDSZUU19hBOxs8e27+N77yR0Av
 Z9kXoxiN8Y4aLJtC7mD0l9W7DOGaNYVrIZ2XGBKHSA3UEud01NM/Qc97AIt7lkmNPKic
 RScNatR4OoVd92+3iBGus6Y0DGYFfMqlf03BELPUHJI5wzQlBU9py+YIYdyYGzz+tw8y
 ONCl14BdbencIwuK/QqTNRvT3ld39wPZoQF4JQO3pPbTo2BjtbvIfZfhLTbg5AK8eBgo
 2nqYX548+kHx90WkpMmInyarn8U5JJWanyIWcfss2/G86dN7XTbPXjwTvrMl0aiNqRLr
 AMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426290; x=1715031090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hnf3o4XnFK2bwHRx7vZnChEV3e4FPyGXBQfB4lUUGyk=;
 b=tki7bpX9G/GBzH0ry7pH71AHdu3rm1Hh2JS5dohiDtpOfDGD6kHSw9lytxqpIaqQEo
 a1jQLfLxms88IDuHFw80zH66YCvr/kBPP5CdXIrGPyj1TvxN6/O6EJ8Mw7znJ5uzsT4x
 7BJQDAkUUnojt+ARyedFNrO57GEOjX/bRwkNqqG6g10AOM8dxlGib3gyR8iKVN9maGrw
 1osw0Rn9zKdmIUItIoMPCdMcm+t2oVlmr9L7K9oNP0FpzOYWWt9epRteswIfCivEMUMt
 35i1dMDGLQ4zNTCm7k9KgrESEZFi3FlcZanzJaa5wWMFkoiS67nJNPfQY01/wwJznNS9
 UZhQ==
X-Gm-Message-State: AOJu0YzkaAMmLxpW0sBwPGVTfMiBS17ij91Mux3+9aRvoIu0dKMvXgBR
 JrmyV951IyF6a7wxMdcKdvomqeZ0dW/91CGVbgLa8PUeS+TwRuLHIVzrMrcNrCAmes2j0KYC9WP
 0l5Y=
X-Google-Smtp-Source: AGHT+IGsTQ5w+J4lZdE0kS6E7TG0UDgkOvzzx899QQeeeZFYBZJUp7idODr/l6K2+kcAuj8lVgySYw==
X-Received: by 2002:a05:600c:a41:b0:418:fe93:22d0 with SMTP id
 c1-20020a05600c0a4100b00418fe9322d0mr680520wmq.11.1714426289844; 
 Mon, 29 Apr 2024 14:31:29 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c468600b0041563096e15sm47015125wmo.5.2024.04.29.14.31.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/13] accel/tcg: Move @cflags_next_tb from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 23:30:44 +0200
Message-ID: <20240429213050.55177-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
index 46ad16f911..55235d3e5e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -720,7 +720,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         if (replay_has_exception()
             && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
-            cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
+            cpu->accel->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
         }
 #endif
@@ -783,7 +783,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     if (!icount_enabled()) {
         return false;
     }
-    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
+    if (!(cpu->accel->cflags_next_tb == -1 || cpu->accel->cflags_next_tb & CF_USE_ICOUNT)) {
         return false;
     }
     return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
@@ -797,7 +797,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * skip checking here. Any pending interrupts will get picked up
      * by the next TB we execute under normal cflags.
      */
-    if (cpu->cflags_next_tb != -1 && cpu->cflags_next_tb & CF_NOIRQ) {
+    if (cpu->accel->cflags_next_tb != -1 && cpu->accel->cflags_next_tb & CF_NOIRQ) {
         return false;
     }
 
@@ -947,7 +947,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     if (insns_left > 0 && insns_left < tb->icount)  {
         assert(insns_left <= CF_COUNT_MASK);
         assert(cpu->icount_extra == 0);
-        cpu->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
+        cpu->accel->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
     }
 #endif
 }
@@ -979,11 +979,11 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
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
index 0e5ebbe050..073eb75ad0 100644
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


