Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE252C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1o2e-0002cY-38; Tue, 30 Apr 2024 10:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1o2L-0002X9-AA
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:50 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1o2H-0002tS-KN
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:49 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso91530231fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714485643; x=1715090443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xJf8wNVMGR0MP4vhP++ZGvQJmrzt6ceEedWUAcLKAGY=;
 b=xnASAZ1PA05FAMPPNF3y9NJgjOmeJBz2pwPFWI39n2Ock9mVKCaDdXBXhLKEuoVLX1
 fvRDJBYS8+ad1FZGQ2DM3rpdmWLgliBYaIz4OAwkDZPxGknBbM/K6yrsTJbvJoWNelzr
 vmfC3+YEEAr7U2kj6PocgKoWouYBc1+xsr37Wj+Sk2tirpMOk6u0nh4Ib7V6ynulW/Y3
 +h6ysRL4Wg2k7mPo2u2DCj1optrQt9qRvYpSnLAgfI0VPbdyX/6/8q4IiC4U6EHcov1g
 K45WZWILQ+1SmyRxCSi5a8fF3F2rJHH4262LmbRCVrghUMyJ67Eqe+YQPRO6hcvV04RA
 Pflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714485643; x=1715090443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJf8wNVMGR0MP4vhP++ZGvQJmrzt6ceEedWUAcLKAGY=;
 b=v+WX7l0rUR/+aUfmcflrOQer9WYufn85y5aRdfjXAEUIFqpoYxiyhkT1QdF7WXoxc4
 D9ZlEN0Y4X4Xky12Md+EoN2NW2UiKo5x0QaDSkARCIVvVrnkOGLPUAesYhQ5JaaAmpW3
 oTgtkQPSAf6IuipJDPq132RxRezbFkNKJzupV42UJv35BUy8SHvZxVpNLwMoRqL+PqCa
 AGMwRcxehAe0xdAymsQH0esIm0pYsGJMdM7jUUDC+QGVAdSQJuGBLl6ZPBJM7YAP4N91
 4HRo043K7nACEHpUEDzWciZz9GLG7/U/4YcjKQ8Sq32uqfgS6DkzpLUoUdPDO4ZANFsb
 jOmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4x5nnw7xgcm4tOKjho7e7FMTNc0y9J0kzj7NP/2HeO1cEglJGz3JaZNdxPtY1/yCcCLEdHE/K5Ck39V5j81G6fnR/bqc=
X-Gm-Message-State: AOJu0YxbXm+cLIlQD/B7qNEQ/IOtShQow0oP7VA5IwNVY0rOFSH4BdjH
 ihMCkWXbbh4vWfzJ6rI9iuxB8bj3QDBLAPovJcNlyFeYpO0GfFX+m8CVnUW2Qdw=
X-Google-Smtp-Source: AGHT+IGc9AvgcOl8gFvb5vRUc0Mh2i1GNb+MomowizfWy8TmYVthvDfNw6tHTEt1iCWx5ypOGzi10w==
X-Received: by 2002:a2e:2a06:0:b0:2e0:c363:f9dc with SMTP id
 q6-20020a2e2a06000000b002e0c363f9dcmr3196323ljq.40.1714485642898; 
 Tue, 30 Apr 2024 07:00:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b0041bfa349cadsm11062705wmo.16.2024.04.30.07.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 07:00:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: Implement FEAT WFxT and enable for '-cpu max'
Date: Tue, 30 Apr 2024 15:00:35 +0100
Message-Id: <20240430140035.3889879-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430140035.3889879-1-peter.maydell@linaro.org>
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

FEAT_WFxT introduces new instructions WFIT and WFET, which are like
the existing WFI and WFE but allow the guest to pass a timeout value
in a register.  The instructions will wait for an interrupt/event as
usual, but will also stop waiting when the value of CNTVCT_EL0 is
greater than or equal to the specified timeout value.

We implement WFIT by setting up a timer to expire at the right
point; when the timer expires it sets the EXITTB interrupt, which
will cause the CPU to leave the halted state. If we come out of
halt for some other reason, we unset the pending timer.

We implement WFET as a nop, which is architecturally permitted and
matches the way we currently make WFE a nop.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  |  1 +
 target/arm/cpu-features.h      |  5 ++++
 target/arm/cpu.h               |  3 ++
 target/arm/helper.h            |  1 +
 target/arm/internals.h         |  8 +++++
 target/arm/tcg/a64.decode      |  4 +++
 target/arm/cpu.c               | 38 ++++++++++++++++++++++++
 target/arm/helper.c            |  4 +--
 target/arm/machine.c           | 20 +++++++++++++
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/op_helper.c     | 54 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 41 ++++++++++++++++++++++++++
 12 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a9ae7ede9fc..d283c985d14 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -108,6 +108,7 @@ the following architecture extensions:
 - FEAT_UAO (Unprivileged Access Override control)
 - FEAT_VHE (Virtualization Host Extensions)
 - FEAT_VMID16 (16-bit VMID)
+- FEAT_WFxT (WFE and WFI instructions with timeout)
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
 - SVE (The Scalable Vector Extension)
 - SVE2 (The Scalable Vector Extension v2)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b300d0446d8..c59ca104fe1 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -571,6 +571,11 @@ static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
 }
 
+static inline bool isar_feature_aa64_wfxt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, WFXT) >= 2;
+}
+
 static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 97997dbd087..e8e6024fe30 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -868,6 +868,9 @@ struct ArchCPU {
      * pmu_op_finish() - it does not need other handling during migration
      */
     QEMUTimer *pmu_timer;
+    /* Timer used for WFxT timeouts */
+    QEMUTimer *wfxt_timer;
+
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2b027333053..a85de78c8fc 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -53,6 +53,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
+DEF_HELPER_2(wfit, void, env, i64)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b53f5e8ff2a..bd32883890d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1760,4 +1760,12 @@ bool check_watchpoint_in_range(int i, target_ulong addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr);
 int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type);
 int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type);
+
+/* Return the current value of the system counter in ticks */
+uint64_t gt_get_countervalue(CPUARMState *env);
+/*
+ * Return the currently applicable offset between the system counter
+ * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
+ */
+uint64_t gt_virt_cnt_offset(CPUARMState *env);
 #endif
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0e7656fd158..7aea5cba5ea 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -183,6 +183,10 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
   NOP           1101 0101 0000 0011 0010 ---- --- 11111
 }
 
+# System instructions with register argument
+WFET            1101 0101 0000 0011 0001 0000 000 rd:5
+WFIT            1101 0101 0000 0011 0001 0000 001 rd:5
+
 # Barriers
 
 CLREX           1101 0101 0000 0011 0011 ---- 010 11111
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a152def2413..006092a6b12 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1132,6 +1132,33 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
     return arm_cpu_data_is_big_endian(env);
 }
 
+static bool arm_cpu_exec_halt(CPUState *cs)
+{
+    bool leave_halt = cpu_has_work(cs);
+
+    if (leave_halt) {
+        /* We're about to come out of WFI/WFE: disable the WFxT timer */
+        ARMCPU *cpu = ARM_CPU(cs);
+        if (cpu->wfxt_timer) {
+            timer_del(cpu->wfxt_timer);
+        }
+    }
+    return leave_halt;
+}
+
+static void arm_wfxt_timer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+
+    /*
+     * We expect the CPU to be halted; this will cause arm_cpu_is_work()
+     * to return true (so we will come out of halt even with no other
+     * pending interrupt), and the TCG accelerator's cpu_exec_interrupt()
+     * function auto-clears the CPU_INTERRUPT_EXITTB flag for us.
+     */
+    cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
+}
 #endif
 
 static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
@@ -1874,6 +1901,9 @@ static void arm_cpu_finalizefn(Object *obj)
     if (cpu->pmu_timer) {
         timer_free(cpu->pmu_timer);
     }
+    if (cpu->wfxt_timer) {
+        timer_free(cpu->wfxt_timer);
+    }
 #endif
 }
 
@@ -2357,6 +2387,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
+        cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                       arm_wfxt_timer_cb, cpu);
+    }
+#endif
+
     if (tcg_enabled()) {
         /*
          * Don't report some architectural features in the ID registers
@@ -2611,6 +2648,7 @@ static const TCGCPUOps arm_tcg_ops = {
 #else
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
+    .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b224826fbb..f7bb2d6ba8a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2658,7 +2658,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     }
 }
 
-static uint64_t gt_get_countervalue(CPUARMState *env)
+uint64_t gt_get_countervalue(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
 
@@ -2793,7 +2793,7 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env) - gt_phys_cnt_offset(env);
 }
 
-static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+uint64_t gt_virt_cnt_offset(CPUARMState *env)
 {
     uint64_t hcr;
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b2b39b24755..0a722ca7e75 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -242,6 +242,25 @@ static const VMStateDescription vmstate_irq_line_state = {
     }
 };
 
+static bool wfxt_timer_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    /* We'll only have the timer object if FEAT_WFxT is implemented */
+    return cpu->wfxt_timer;
+}
+
+static const VMStateDescription vmstate_wfxt_timer = {
+    .name = "cpu/wfxt-timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = wfxt_timer_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(wfxt_timer, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool m_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -957,6 +976,7 @@ const VMStateDescription vmstate_arm_cpu = {
 #endif
         &vmstate_serror,
         &vmstate_irq_line_state,
+        &vmstate_wfxt_timer,
         NULL
     }
 };
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 62c4663512b..47ea51d3aa5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1150,6 +1150,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = cpu->isar.id_aa64isar2;
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     cpu->isar.id_aa64isar2 = t;
 
     t = cpu->isar.id_aa64pfr0;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c199b69fbff..c083e5cfb87 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -409,6 +409,60 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
+void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * WFI in the user-mode emulator is technically permitted but not
+     * something any real-world code would do. AArch64 Linux kernels
+     * trap it via SCTRL_EL1.nTWI and make it an (expensive) NOP;
+     * AArch32 kernels don't trap it so it will delay a bit.
+     * For QEMU, make it NOP here, because trying to raise EXCP_HLT
+     * would trigger an abort.
+     */
+    return;
+#else
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    int target_el = check_wfx_trap(env, false);
+    /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
+    uint64_t cntval = gt_get_countervalue(env);
+    uint64_t offset = gt_virt_cnt_offset(env);
+    uint64_t cntvct = cntval - offset;
+    uint64_t nexttick;
+
+    if (cpu_has_work(cs) || cntvct >= timeout) {
+        /*
+         * Don't bother to go into our "low power state" if
+         * we would just wake up immediately.
+         */
+        return;
+    }
+
+    if (target_el) {
+        env->pc -= 4;
+        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, false),
+                        target_el);
+    }
+
+    if (uadd64_overflow(timeout, offset, &nexttick)) {
+        nexttick = UINT64_MAX;
+    }
+    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+        /*
+         * If the timeout is too long for the signed 64-bit range
+         * of a QEMUTimer, let it expire early.
+         */
+        timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
+    } else {
+        timer_mod(cpu->wfxt_timer, nexttick);
+    }
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
+#endif
+}
+
 void HELPER(wfe)(CPUARMState *env)
 {
     /* This is a hint instruction that is semantically different
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 976094a5c80..591be43279c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1690,6 +1690,47 @@ static bool trans_WFE(DisasContext *s, arg_WFI *a)
     return true;
 }
 
+static bool trans_WFIT(DisasContext *s, arg_WFIT *a)
+{
+    if (!dc_isar_feature(aa64_wfxt, s)) {
+        return false;
+    }
+
+    /*
+     * Because we need to pass the register value to the helper,
+     * it's easier to emit the code now, unlike trans_WFI which
+     * defers it to aarch64_tr_tb_stop(). That means we need to
+     * check ss_active so that single-stepping a WFIT doesn't halt.
+     */
+    if (s->ss_active) {
+        /* Act like a NOP under architectural singlestep */
+        return true;
+    }
+
+    gen_a64_update_pc(s, 4);
+    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
+    /* Go back to the main loop to check for interrupts */
+    s->base.is_jmp = DISAS_EXIT;
+    return true;
+}
+
+static bool trans_WFET(DisasContext *s, arg_WFET *a)
+{
+    if (!dc_isar_feature(aa64_wfxt, s)) {
+        return false;
+    }
+
+    /*
+     * We rely here on our WFE implementation being a NOP, so we
+     * don't need to do anything different to handle the WFET timeout
+     * from what trans_WFE does.
+     */
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        s->base.is_jmp = DISAS_WFE;
+    }
+    return true;
+}
+
 static bool trans_XPACLRI(DisasContext *s, arg_XPACLRI *a)
 {
     if (s->pauth_active) {
-- 
2.34.1


