Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ybv-0000Ks-9J; Mon, 29 Apr 2024 17:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbV-00083E-Gt
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:32:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbT-0003Rd-Fq
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:32:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41c7ac71996so6467355e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426321; x=1715031121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2SW+/jg7KyBmqHR72nO3ki7+1M5U4SybhOT6/FbSqI=;
 b=wLJKqUHqRIjURHzdX5/Juuywnaoqh9xtaZy8Hvt6cQGyW4S+fXpyKOlbR6A5lJCbd4
 DSvp/ATBVEyJ6csp2wH0yhO02Fcd1EYdHmO++1x6yAF9GHzoVp4e6e/+Id3FPYEJaEJX
 0A9anjprktUVVig4xKYcoJVCAh8FeyejQ5aRZKfQwRhQRBuxnTySm4jcR87J6Xe7NqR3
 kw+AqGgDY1iYIrWhJmGZg9dO7MM/N4uEgI6uODiiyiFq760lvea0SOksimWvpVkBOcv1
 2GJYLUCBH96ntOgsbC4LSPGQQzq3G29FX/hu9fWdFYX9CNmt33TJ7FKZGh8VrSGCZ4DZ
 FKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426321; x=1715031121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2SW+/jg7KyBmqHR72nO3ki7+1M5U4SybhOT6/FbSqI=;
 b=OGsnCG/LiUtg8vLOFXfzf5M5s6FEqs2JJeLRFm0ii+3kEhBvFoSRZ/47v8/i7/H+Gc
 fnJrmveqNeLR7dorTodx/qf8yxIK3cvcbbDC9tcAlgVXBnzSRr56zcVFpj47P30kA4SD
 kQlv+4SUgMuRH0TXHU7vxpYsftbck9f4fZJA/nxIzXGjDG1mlV2ojUWWy8T+trQJ6vbc
 IlxL+AxfEGx+//GaZyy0YgaYBwhJSuKOH+AfwwniiCy5xT4MeyASLFvmymloAeTUT1Jz
 v6qkFGqQ2IpyBJbsA/araokwomPTo25lgD4cPYYy6Ty7bsdrDU9OyubYUaHM8TWQUcqW
 K4UQ==
X-Gm-Message-State: AOJu0YwyrX2PhP+BZ4sKhAi3blUiGqAmV9VhYDzieiqMU3zr9JFukrKA
 Hk4gCXdsKZzvZ3v5k1ySCTgE2/+1+MJYHYEuHRIZzLZrfq3sW2uAUlGI55uVwt7qdoU/3yycuV9
 qx54=
X-Google-Smtp-Source: AGHT+IFQgSlCSS0IpCSB/SPTvzirChnBXnGahzno3vQ4eP7ea7AVbRd1fC2h0+Ji+pRVzhUvnoFmQw==
X-Received: by 2002:a05:600c:3d0c:b0:41c:7bd:5a84 with SMTP id
 bh12-20020a05600c3d0c00b0041c07bd5a84mr3851793wmb.17.1714426321615; 
 Mon, 29 Apr 2024 14:32:01 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 n2-20020adfe342000000b00343eac2acc4sm30470654wrj.111.2024.04.29.14.32.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:32:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/13] accel/tcg: Move icount fields from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 23:30:50 +0200
Message-ID: <20240429213050.55177-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
index 6c12bd17df..7fff5413e9 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -12,6 +12,7 @@
 /**
  * AccelCPUState: vCPU fields specific to TCG accelerator
  * @cflags: Pre-computed cflags for this cpu.
+ * @icount_extra: Instructions until next timer event.
  * @plugin_state: per-CPU plugin state
  */
 struct AccelCPUState {
@@ -24,6 +25,9 @@ struct AccelCPUState {
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
index 14e96aae85..c0c28befd3 100644
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
index 1f618f6c2e..7c21542e52 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -74,7 +74,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
         return;
     }
 
-    cpu_icount = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
+    cpu_icount = cpu->accel->icount_extra + cpu->neg.icount_decr.u16.low;
     sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
@@ -125,7 +125,7 @@ static void init_delay_params(SyncClocks *sc, CPUState *cpu)
     sc->realtime_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
     sc->diff_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sc->realtime_clock;
     sc->last_cpu_icount
-        = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
+        = cpu->accel->icount_extra + cpu->neg.icount_decr.u16.low;
     if (sc->diff_clk < max_delay) {
         max_delay = sc->diff_clk;
     }
@@ -718,7 +718,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
         if (replay_has_exception()
-            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
+            && cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->accel->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
@@ -789,7 +789,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     if (!(cpu->accel->cflags_next_tb == -1 || cpu->accel->cflags_next_tb & CF_USE_ICOUNT)) {
         return false;
     }
-    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+    return cpu->neg.icount_decr.u16.low + cpu->accel->icount_extra == 0;
 #endif
 }
 
@@ -941,9 +941,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
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
@@ -952,7 +952,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
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
index 073eb75ad0..c8e6f63943 100644
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


