Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CCFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mcC-0007fg-EO; Tue, 30 Apr 2024 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbv-0007Es-MX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbr-0001pT-88
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:27 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57222fc625aso6361680a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480158; x=1715084958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzwfr/wTeB46SuXanUOeFcxVvZg85d/Fb55ijGv7nN4=;
 b=XkW0i1vL2J7FLbpXfazTF2XdHDNNOdaj282PI2K3bfSz2kkddawPZTQSI64GXU6SMq
 tTK4ICh+vYSPjtoY/XZeV/KjEbAh2DoLTfpybGQ5YGKsvRz4KQzBl9vlWEhGgGEeu1XB
 bmZxRcnZWcRbPZg8uaLWxibFeEcS9eRmVOrHeR3RuZZysiP/fpqkGupqew3uPp4kt6Cw
 BERFkXK2xmkotGbviLEfpd0ni6Rnn3i8hG0cKk1OVA6gQjv3WWcJfl33nGGiztgwyGox
 ZTk3dbwYKThMmeJv0n/5xDJwAIgL+jsHuELHjvGsi1l6rWCDy0e1fP4rx8RtVFc7zXmJ
 M26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480158; x=1715084958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzwfr/wTeB46SuXanUOeFcxVvZg85d/Fb55ijGv7nN4=;
 b=AlSWz3EqFFSmf7L5zX+qzDtz26Z9cgty1TAoeOeKNjMUlCKPdUhr5j/rBVHLxHBD+a
 f3w5SL1WthlNsTUBGYtPLnQMkVOA0p7PZvgDYvWYnUkD5Yvw7S8CcFqicTETRdhtybqZ
 grzgAoy83G5hjNVdPxhHGxQkI1cyXASpk1UF1v689czr4wmsedorPW4iLBMk6jX6tc4Q
 TaoN0MHwHvF/58lk1dSQCcOzU+qQRKaG1efwLVi4Rl3MuxmYePpNIFNjreZ3XjjMMb9N
 HyYxBAlrKmUjKm4A+Jz7m+wsxmD+Bw+XYyJStNRnz/m2tGb5ajEohHhwT0TdYAarMPkU
 jTvw==
X-Gm-Message-State: AOJu0Yy7zRwUoGhRaJUCRPiBUfke6Qd7I6dzbUCKcJiv0dKo0FDJutfS
 bfF5V3F5yCHr51V2YbLuM1KWgr2AdIma1l7vPrWWKzRYp3JsN0hPXuPvPKsCr2WMUiX/NlrMOke
 Z
X-Google-Smtp-Source: AGHT+IFYVta8F8IoY4I/NGLdQDhVs3fEFUWZBj6QjpijrLY+ltBBajYSgH3pSjUiTlXLuAw5ypV1PA==
X-Received: by 2002:a50:8e0f:0:b0:571:bed1:3a36 with SMTP id
 15-20020a508e0f000000b00571bed13a36mr11183710edw.38.1714480158255; 
 Tue, 30 Apr 2024 05:29:18 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 ev9-20020a056402540900b005725de35790sm4419784edb.61.2024.04.30.05.29.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:29:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/13] accel/tcg: Move icount fields from CPUState to TCG
 AccelCPUState
Date: Tue, 30 Apr 2024 14:28:06 +0200
Message-ID: <20240430122808.72025-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Both @icount_budget and @icount_extra fields are specific
to TCG accelerator, move them to its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-25-philmd@linaro.org>
---
 accel/tcg/vcpu-state.h           |  4 ++++
 include/hw/core/cpu.h            |  3 ---
 accel/tcg/cpu-exec.c             | 14 +++++++-------
 accel/tcg/icount-common.c        |  7 ++++---
 accel/tcg/tcg-accel-ops-icount.c | 14 +++++++-------
 accel/tcg/tcg-accel-ops.c        |  1 +
 hw/core/cpu-common.c             |  1 -
 7 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 008fe847b4..716a0119c4 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -11,6 +11,7 @@
 /**
  * AccelCPUState: vCPU fields specific to TCG accelerator
  * @cflags: Pre-computed cflags for this cpu.
+ * @icount_extra: Instructions until next timer event.
  * @plugin_state: per-CPU plugin state
  */
 struct AccelCPUState {
@@ -22,6 +23,9 @@ struct AccelCPUState {
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
 #else
+    int64_t icount_budget;
+    int64_t icount_extra;
+
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
 #endif /* !CONFIG_USER_ONLY */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e546e67f4d..f06bb1e93a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -409,7 +409,6 @@ struct qemu_work_item;
  * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
- * @icount_extra: Instructions until next timer event.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
  * @num_ases: number of CPUAddressSpaces in @cpu_ases
@@ -470,8 +469,6 @@ struct CPUState {
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
-    int64_t icount_budget;
-    int64_t icount_extra;
     uint64_t random_seed;
 
     QemuMutex work_mutex;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 49b4b57a56..a491278082 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -75,7 +75,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
         return;
     }
 
-    cpu_icount = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
+    cpu_icount = cpu->accel->icount_extra + cpu->neg.icount_decr.u16.low;
     sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
@@ -126,7 +126,7 @@ static void init_delay_params(SyncClocks *sc, CPUState *cpu)
     sc->realtime_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
     sc->diff_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sc->realtime_clock;
     sc->last_cpu_icount
-        = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
+        = cpu->accel->icount_extra + cpu->neg.icount_decr.u16.low;
     if (sc->diff_clk < max_delay) {
         max_delay = sc->diff_clk;
     }
@@ -719,7 +719,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
         if (replay_has_exception()
-            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
+            && cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->accel->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
@@ -790,7 +790,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     if (!(cpu->accel->cflags_next_tb == -1 || cpu->accel->cflags_next_tb & CF_USE_ICOUNT)) {
         return false;
     }
-    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+    return cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra == 0;
 #endif
 }
 
@@ -942,9 +942,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
-    int32_t insns_left = MIN(0xffff, cpu->icount_budget);
+    int32_t insns_left = MIN(0xffff, cpu->accel->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
-    cpu->icount_extra = cpu->icount_budget - insns_left;
+    cpu->accel->icount_extra = cpu->accel->icount_budget - insns_left;
 
     /*
      * If the next tb has more instructions than we have left to
@@ -953,7 +953,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
      */
     if (insns_left > 0 && insns_left < tb->icount)  {
         assert(insns_left <= CF_COUNT_MASK);
-        assert(cpu->icount_extra == 0);
+        assert(cpu->accel->icount_extra == 0);
         cpu->accel->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
     }
 #endif
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 8d3d3a7e9d..ff503f8e96 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -38,6 +38,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
+#include "accel/tcg/vcpu-state.h"
 
 /*
  * ICOUNT: Instruction Counter
@@ -71,8 +72,8 @@ static void icount_enable_adaptive(void)
  */
 static int64_t icount_get_executed(CPUState *cpu)
 {
-    return (cpu->icount_budget -
-            (cpu->neg.icount_decr.u16.low + cpu->icount_extra));
+    return (cpu->accel->icount_budget -
+            (cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra));
 }
 
 /*
@@ -83,7 +84,7 @@ static int64_t icount_get_executed(CPUState *cpu)
 static void icount_update_locked(CPUState *cpu)
 {
     int64_t executed = icount_get_executed(cpu);
-    cpu->icount_budget -= executed;
+    cpu->accel->icount_budget -= executed;
 
     qatomic_set_i64(&timers_state.qemu_icount,
                     timers_state.qemu_icount + executed);
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 9e1ae66f65..75073ec23f 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -112,16 +112,16 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget)
      * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
      */
     g_assert(cpu->neg.icount_decr.u16.low == 0);
-    g_assert(cpu->icount_extra == 0);
+    g_assert(cpu->accel->icount_extra == 0);
 
     replay_mutex_lock();
 
-    cpu->icount_budget = MIN(icount_get_limit(), cpu_budget);
-    insns_left = MIN(0xffff, cpu->icount_budget);
+    cpu->accel->icount_budget = MIN(icount_get_limit(), cpu_budget);
+    insns_left = MIN(0xffff, cpu->accel->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
-    cpu->icount_extra = cpu->icount_budget - insns_left;
+    cpu->accel->icount_extra = cpu->accel->icount_budget - insns_left;
 
-    if (cpu->icount_budget == 0) {
+    if (cpu->accel->icount_budget == 0) {
         /*
          * We're called without the BQL, so must take it while
          * we're calling timer handlers.
@@ -139,8 +139,8 @@ void icount_process_data(CPUState *cpu)
 
     /* Reset the counters */
     cpu->neg.icount_decr.u16.low = 0;
-    cpu->icount_extra = 0;
-    cpu->icount_budget = 0;
+    cpu->accel->icount_extra = 0;
+    cpu->accel->icount_budget = 0;
 
     replay_account_executed_instructions();
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index d9132a5835..3b28cab0b5 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -89,6 +89,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->neg.can_do_io = true;
+    cpu->accel->icount_extra = 0;
     cpu->accel->cflags_next_tb = -1;
 }
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index b6631b6245..e03d31876f 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -121,7 +121,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu->interrupt_request = 0;
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
-    cpu->icount_extra = 0;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
 
-- 
2.41.0


