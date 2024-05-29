Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942AFC27C51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsZ-0000yN-8T; Wed, 29 May 2024 12:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsT-0000vB-5E
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:13 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsE-0003Mp-W1
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:12 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e95a1f9c53so27748571fa.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716998997; x=1717603797;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osjOjWRu9rt+8nh61bUbxnuyPV8jhA5IYjsXZIh5+NY=;
 b=BfBBp3SM3tMrDLefPHxmkXK+TsptfHAmIdS0gFnQ/QAOVyg1frSYDTdlpgoGLGmp1b
 sXYbMzSwBTKNCKdIlOAgX1zmdlKEg0/xWs33Q4Yn+Jj22mILnKAg5iejlm4ZeVbMemlK
 LdQSSsZBte8XxPxF39HTeTqu612G5praZ8tKDbyOqXB0yRjD0znA6Cc3PpElb3p74gTk
 8Dl65VLHPsdcXJzYc1pkQO1k7pnut3Mk6MCo2hOKIXUixHAFZ43EPdIOvrib+CFLd/cd
 IpKzn6NQORj3kXczBqfq/deJ2JjeSf5O/p3NdPRj0GvlkaTzB43hO718E+bDfryxuBmy
 CltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998997; x=1717603797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osjOjWRu9rt+8nh61bUbxnuyPV8jhA5IYjsXZIh5+NY=;
 b=d+FbEpSbKtjLVEvnyoSXXE11RCw+pjPaR5+UpV8A/b/ZVAI5U+3moa0O0QKVVte/s0
 +GmeprGlwDCrzI5/ZFlDIYeHPGu3PhpJhyni5y+fvLv1E0sIKfqErrY9ShZDN6iLxnNg
 iPTpwI4nG90Fr5cdoiF4Rj0nAPaO+8XYSwcq8VVw2XD9CHV2slwvkhqars/kJ+dxwkUK
 saycpyR7A3XcQayXZJYjnaeEVdyBf/LG30qFafzBCLUiFpRV4U5JRkriq4V4qDkj3m9G
 kx1Ud5Ep0s7UnpXvVYfNbH8PGrlNGHqUBSqhWqCVPhCBvoioaVeeqFdRAlSnSTe4xR0R
 WaKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFPxycZl2/r3sCgwmzYLoI/b0RiCCDje2t+B6a00p5kUmbmv0+KNBLm+7F+AQGpUVmlUn9oGsOQ4hJzAojrMIZVn/Up00=
X-Gm-Message-State: AOJu0YxfJfON7MhMNNjhUs1lZFuHDE6pXU5p2t9ewdqD/PeO1sYJASLt
 /A0xaThCmQZsx04IXcVhTsWH3AbbEiVI0dVQ9EYPzzOonbgB9z3sUevV+hJkzw4=
X-Google-Smtp-Source: AGHT+IESivAIuB9YUvE2L2+4fRxB2qtupF0Iz8QieJ8U7scKzHK9F7bj/U+zUdIbwtERSQJ9EhoGNQ==
X-Received: by 2002:a2e:b169:0:b0:2e9:5d26:a56e with SMTP id
 38308e7fff4ca-2e95d26a675mr94727121fa.16.1716998997116; 
 Wed, 29 May 2024 09:09:57 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0740sm15228213f8f.107.2024.05.29.09.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:56 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Subject: [PATCH 4/6] target/riscv: Add support to record CTR entries.
Date: Wed, 29 May 2024 17:09:48 +0100
Message-Id: <20240529160950.132754-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160950.132754-1-rkanwal@rivosinc.com>
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=rkanwal@rivosinc.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds logic to records CTR entries of different types
and adds required hooks in TCG and interrupt/Exception logic to
record events.

This commit also adds support to invoke freeze CTR logic for breakpoint
exceptions and counter overflow interrupts.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h                            |   8 +
 target/riscv/cpu_helper.c                     | 206 ++++++++++++++++++
 target/riscv/helper.h                         |   8 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |   6 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  27 +++
 target/riscv/op_helper.c                      | 112 +++++++++-
 target/riscv/translate.c                      |   9 +
 7 files changed, 370 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3d4d5172b8..a294a5372a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -268,6 +268,10 @@ struct CPUArchState {
     uint32_t sctrstatus;
     uint64_t vsctrctl;
 
+    uint64_t ctr_src[16 << SCTRDEPTH_MAX];
+    uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
+    uint64_t ctr_data[16 << SCTRDEPTH_MAX];
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
@@ -565,6 +569,10 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
+void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask);
+void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
+                         uint64_t type, target_ulong prev_priv, bool prev_virt);
+
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uint32_t exception, uintptr_t pc);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a441a03ef4..e064a7306e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -663,6 +663,10 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
 
     BQL_LOCK_GUARD();
 
+    if (MIP_LCOFIP & value & mask) {
+        riscv_ctr_freeze(env, MCTRCTL_LCOFIFRZ);
+    }
+
     env->mip = (env->mip & ~mask) | (value & mask);
 
     riscv_cpu_interrupt(env);
@@ -691,6 +695,197 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
     }
 }
 
+void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask)
+{
+    assert((freeze_mask & (~(MCTRCTL_BPFRZ | MCTRCTL_LCOFIFRZ))) == 0);
+
+    if (env->mctrctl & freeze_mask) {
+        env->sctrstatus |= SCTRSTATUS_FROZEN;
+    }
+}
+
+static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
+{
+    switch (priv) {
+    case PRV_M:
+        return MCTRCTL_M_ENABLE;
+    case PRV_S:
+        if (virt) {
+            return VSCTRCTL_VS_ENABLE;
+        }
+        return MCTRCTL_S_ENABLE;
+    case PRV_U:
+        if (virt) {
+            return VSCTRCTL_VU_ENABLE;
+        }
+        return MCTRCTL_U_ENABLE;
+    }
+
+    g_assert_not_reached();
+}
+
+static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long priv,
+                                      bool virt)
+{
+    switch (priv) {
+    case PRV_M:
+        return env->mctrctl;
+    case PRV_S:
+    case PRV_U:
+        if (virt) {
+            return env->vsctrctl;
+        }
+        return env->mctrctl;
+    }
+
+    g_assert_not_reached();
+}
+
+/*
+ * Special cases for traps and trap returns:
+ *
+ * 1- Traps, and trap returns, between enabled modes are recorded as normal.
+ * 2- Traps from an inhibited mode to an enabled mode, and trap returns from an
+ * enabled mode back to an inhibited mode, are partially recorded.  In such
+ * cases, the PC from the inhibited mode (source PC for traps, and target PC
+ * for trap returns) is 0.
+ *
+ * 3- Trap returns from an inhibited mode to an enabled mode are not recorded.
+ * Traps from an enabled mode to an inhibited mode, known as external traps,
+ * receive special handling.
+ * By default external traps are not recorded, but a handshake mechanism exists
+ * to allow partial recording.  Software running in the target mode of the trap
+ * can opt-in to allowing CTR to record traps into that mode even when the mode
+ * is inhibited.  The MTE, STE, and VSTE bits allow M-mode, S-mode, and VS-mode,
+ * respectively, to opt-in. When an External Trap occurs, and xTE=1, such that
+ * x is the target privilege mode of the trap, will CTR record the trap. In such
+ * cases, the target PC is 0.
+ */
+/*
+ * CTR arrays are implemented as circular buffers and new entry is stored at
+ * sctrstatus.WRPTR, but they are presented to software as moving circular
+ * buffers. Which means, software get's the illusion that whenever a new entry
+ * is added the whole buffer is moved by one place and the new entry is added at
+ * the start keeping new entry at idx 0 and older ones follow.
+ *
+ * Depth = 16.
+ *
+ * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+ * WRPTR                                   W
+ * entry   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8
+ *
+ * When a new entry is added:
+ * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+ * WRPTR                                       W
+ * entry   8   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9
+ *
+ * entry here denotes the logical entry number that software can access
+ * using ctrsource, ctrtarget and ctrdata registers. So xiselect 0x200
+ * will return entry 0 i-e buffer[8] and 0x201 will return entry 1 i-e
+ * buffer[7]. Here is how we convert entry to buffer idx.
+ *
+ *    entry = isel - CTR_ENTRIES_FIRST;
+ *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
+ */
+void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
+                         uint64_t type, target_ulong src_priv, bool src_virt)
+{
+    bool tgt_virt = env->virt_enabled;
+    uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
+    uint64_t tgt_mask = riscv_ctr_priv_to_mask(env->priv, tgt_virt);
+    uint64_t src_ctrl = riscv_ctr_get_control(env, src_priv, src_virt);
+    uint64_t tgt_ctrl = riscv_ctr_get_control(env, env->priv, tgt_virt);
+    uint64_t depth, head;
+    bool ext_trap = false;
+
+    if (env->sctrstatus & SCTRSTATUS_FROZEN) {
+        return;
+    }
+
+    /*
+     * With RAS Emul enabled, only allow Indirect, drirect calls, Function
+     * returns and Co-routine swap types.
+     */
+    if (env->mctrctl & MCTRCTL_RASEMU &&
+        type != CTRDATA_TYPE_INDIRECT_CALL &&
+        type != CTRDATA_TYPE_DIRECT_CALL &&
+        type != CTRDATA_TYPE_RETURN &&
+        type != CTRDATA_TYPE_CO_ROUTINE_SWAP) {
+        return;
+    }
+
+    if (type == CTRDATA_TYPE_EXCEPTION || type == CTRDATA_TYPE_INTERRUPT) {
+        /* Case 2 for traps. */
+        if (!(src_ctrl & src_mask) && (tgt_ctrl & tgt_mask)) {
+            src = 0;
+        } else if ((src_ctrl & src_mask) && !(tgt_ctrl & tgt_mask)) {
+            /* Check if target priv-mode has allowed external trap recording. */
+            if ((env->priv == PRV_M && !(tgt_ctrl & MCTRCTL_MTE)) ||
+                (env->priv == PRV_S && !(tgt_ctrl & MCTRCTL_STE))) {
+                return;
+            }
+
+            ext_trap = true;
+            dst = 0;
+        } else if (!(src_ctrl & src_mask) && !(tgt_ctrl & tgt_mask)) {
+            return;
+        }
+    } else if (type == CTRDATA_TYPE_EXCEP_INT_RET) {
+        /*
+         * Case 3 for trap returns.  Trap returns from inhibited mode are not
+         * recorded.
+         */
+        if (!(src_ctrl & src_mask)) {
+            return;
+        }
+
+        /* Case 2 for trap returns. */
+        if (!(tgt_ctrl & tgt_mask)) {
+            dst = 0;
+        }
+    } else if (!(tgt_ctrl & tgt_mask)) {
+        return;
+    }
+
+    /* Ignore filters in case of RASEMU mode or External trap. */
+    if (!(tgt_ctrl & MCTRCTL_RASEMU) && !ext_trap) {
+        /*
+         * Check if the specific type is inhibited. Not taken branch filter is
+         * an enable bit and needs to be checked separatly.
+         */
+        bool check = tgt_ctrl & BIT_ULL(type + MCTRCTL_INH_START);
+        if ((type == CTRDATA_TYPE_NONTAKEN_BRANCH && !check) ||
+            (type != CTRDATA_TYPE_NONTAKEN_BRANCH && check)) {
+            return;
+        }
+    }
+
+    head = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+
+    depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    if (tgt_ctrl & MCTRCTL_RASEMU && type == CTRDATA_TYPE_RETURN) {
+        head = (head - 1) & (depth - 1);
+
+        env->ctr_src[head] &= ~CTRSOURCE_VALID;
+        env->sctrstatus =
+            set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
+        return;
+    }
+
+    /* In case of Co-routine SWAP we overwrite latest entry. */
+    if (tgt_ctrl & MCTRCTL_RASEMU && type == CTRDATA_TYPE_CO_ROUTINE_SWAP) {
+        head = (head - 1) & (depth - 1);
+    }
+
+    env->ctr_src[head] = src | CTRSOURCE_VALID;
+    env->ctr_dst[head] = dst & ~CTRTARGET_MISP;
+    env->ctr_data[head] = set_field(0, CTRDATA_TYPE_MASK, type);
+
+    head = (head + 1) & (depth - 1);
+
+    env->sctrstatus = set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
+}
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
@@ -1669,10 +1864,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    const bool prev_virt = env->virt_enabled;
+    const target_ulong prev_priv = env->priv;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
+    target_ulong src;
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
@@ -1729,6 +1927,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 tval = cs->watchpoint_hit->hitaddr;
                 cs->watchpoint_hit = NULL;
             }
+            riscv_ctr_freeze(env, MCTRCTL_BPFRZ);
             break;
         default:
             break;
@@ -1807,6 +2006,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->pc = (env->stvec >> 2 << 2) +
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S, virt);
+
+        src = env->sepc;
     } else {
         /* handle the trap in M-mode */
         if (riscv_has_ext(env, RVH)) {
@@ -1838,8 +2039,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->pc = (env->mtvec >> 2 << 2) +
                   ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M, virt);
+        src = env->mepc;
     }
 
+    riscv_ctr_add_entry(env, src, env->pc,
+                        async ? CTRDATA_TYPE_INTERRUPT : CTRDATA_TYPE_EXCEPTION,
+                        prev_priv, prev_virt);
+
     /*
      * NOTE: it is not necessary to yield load reservations here. It is only
      * necessary for an SC from "another hart" to cause a load reservation
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..0a9a545d87 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -129,12 +129,16 @@ DEF_HELPER_2(csrr_i128, tl, env, int)
 DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
 DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_1(sret, tl, env)
-DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_2(sret, tl, env, tl)
+DEF_HELPER_2(mret, tl, env, tl)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
+DEF_HELPER_4(ctr_branch, void, env, tl, tl, tl)
+DEF_HELPER_4(ctr_jal, void, env, tl, tl, tl)
+DEF_HELPER_5(ctr_jalr, void, env, tl, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
 #endif
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 4eccdddeaa..339d659151 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -78,9 +78,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        TCGv src = tcg_constant_tl(ctx->base.pc_next);
         decode_save_opc(ctx);
         translator_io_start(&ctx->base);
-        gen_helper_sret(cpu_pc, tcg_env);
+        gen_helper_sret(cpu_pc, tcg_env, src);
         exit_tb(ctx); /* no chaining */
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
@@ -95,9 +96,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
     decode_save_opc(ctx);
     translator_io_start(&ctx->base);
-    gen_helper_mret(cpu_pc, tcg_env);
+    gen_helper_mret(cpu_pc, tcg_env, src);
     exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ad40d3e87f..7f95362b66 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -55,6 +55,11 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     TCGLabel *misaligned = NULL;
     TCGv target_pc = tcg_temp_new();
     TCGv succ_pc = dest_gpr(ctx, a->rd);
+#ifndef CONFIG_USER_ONLY
+    TCGv rd = tcg_constant_tl(a->rd);
+    TCGv rs1 = tcg_constant_tl(a->rs1);
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
+#endif
 
     tcg_gen_addi_tl(target_pc, get_gpr(ctx, a->rs1, EXT_NONE), a->imm);
     tcg_gen_andi_tl(target_pc, target_pc, (target_ulong)-2);
@@ -75,6 +80,9 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_set_gpr(ctx, a->rd, succ_pc);
 
     tcg_gen_mov_tl(cpu_pc, target_pc);
+#ifndef CONFIG_USER_ONLY
+    gen_helper_ctr_jalr(tcg_env, src, cpu_pc, rd, rs1);
+#endif
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
@@ -164,6 +172,11 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_SIGN);
     target_ulong orig_pc_save = ctx->pc_save;
+#ifndef CONFIG_USER_ONLY
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
+    TCGv taken;
+    TCGv dest;
+#endif
 
     if (get_xl(ctx) == MXL_RV128) {
         TCGv src1h = get_gprh(ctx, a->rs1);
@@ -176,6 +189,14 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     } else {
         tcg_gen_brcond_tl(cond, src1, src2, l);
     }
+
+#ifndef CONFIG_USER_ONLY
+    dest = tcg_constant_tl(ctx->base.pc_next + ctx->cur_insn_len);
+    taken = tcg_constant_tl(0);
+
+    gen_helper_ctr_branch(tcg_env, src, dest, taken);
+#endif
+
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
@@ -188,6 +209,12 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
         gen_pc_plus_diff(target_pc, ctx, a->imm);
         gen_exception_inst_addr_mis(ctx, target_pc);
     } else {
+#ifndef CONFIG_USER_ONLY
+        dest = tcg_constant_tl(ctx->base.pc_next + a->imm);
+        taken = tcg_constant_tl(1);
+
+        gen_helper_ctr_branch(tcg_env, src, dest, taken);
+#endif
         gen_goto_tb(ctx, 0, a->imm);
     }
     ctx->pc_save = -1;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 25a5263573..c8053d9c2f 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -259,10 +259,12 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
 
 #ifndef CONFIG_USER_ONLY
 
-target_ulong helper_sret(CPURISCVState *env)
+target_ulong helper_sret(CPURISCVState *env, target_ulong curr_pc)
 {
     uint64_t mstatus;
     target_ulong prev_priv, prev_virt = env->virt_enabled;
+    const target_ulong src_priv = env->priv;
+    const bool src_virt = env->virt_enabled;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -309,11 +311,17 @@ target_ulong helper_sret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    riscv_ctr_add_entry(env, curr_pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
+                        src_priv, src_virt);
+
     return retpc;
 }
 
-target_ulong helper_mret(CPURISCVState *env)
+target_ulong helper_mret(CPURISCVState *env, target_ulong curr_pc)
 {
+    const target_ulong src_priv = env->priv;
+    const bool src_virt = env->virt_enabled;
+
     if (!(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -350,9 +358,109 @@ target_ulong helper_mret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    riscv_ctr_add_entry(env, curr_pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
+                        src_priv, src_virt);
+
     return retpc;
 }
 
+/*
+ * Indirect calls
+ * – jalr x1, rs where rs != x5;
+ * – jalr x5, rs where rs != x1;
+ * – c.jalr rs1 where rs1 != x5;
+ *
+ * Indirect jumps
+ * – jalr x0, rs where rs != x1 and rs != x5;
+ * – c.jr rs1 where rs1 != x1 and rs1 != x5.
+ *
+ * Returns
+ * – jalr rd, rs where (rs == x1 or rs == x5) and rd != x1 and rd != x5;
+ * – c.jr rs1 where rs1 == x1 or rs1 == x5.
+ *
+ * Co-routine swap
+ * – jalr x1, x5;
+ * – jalr x5, x1;
+ * – c.jalr x5.
+ *
+ * Other indirect jumps
+ * – jalr rd, rs where rs != x1, rs != x5, rd != x0, rd != x1 and rd != x5.
+ */
+void helper_ctr_jalr(CPURISCVState *env, target_ulong src, target_ulong dest,
+                     target_ulong rd, target_ulong rs1)
+{
+    target_ulong curr_priv = env->priv;
+    bool curr_virt = env->virt_enabled;
+
+    if ((rd == 1 && rs1 != 5) || (rd == 5 && rs1 != 1)) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_INDIRECT_CALL,
+                            curr_priv, curr_virt);
+    } else if (rd == 0 && rs1 != 1 && rs1 != 5) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_INDIRECT_JUMP,
+                            curr_priv, curr_virt);
+    } else if ((rs1 == 1 || rs1 == 5) && (rd != 1 && rd != 5)) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_RETURN,
+                            curr_priv, curr_virt);
+    } else if ((rs1 == 1 && rd == 5) || (rs1 == 5 && rd == 1)) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_CO_ROUTINE_SWAP,
+                            curr_priv, curr_virt);
+    } else {
+        riscv_ctr_add_entry(env, src, dest,
+                            CTRDATA_TYPE_OTHER_INDIRECT_JUMP, curr_priv,
+                            curr_virt);
+    }
+}
+
+/*
+ * Direct calls
+ * – jal x1;
+ * – jal x5;
+ * – c.jal.
+ *
+ * Direct jumps
+ * – jal x0;
+ * – c.j;
+ *
+ * Other direct jumps
+ * – jal rd where rd != x1 and rd != x5 and rd != x0;
+ */
+void helper_ctr_jal(CPURISCVState *env, target_ulong src, target_ulong dest,
+                    target_ulong rd)
+{
+    target_ulong priv = env->priv;
+    bool virt = env->virt_enabled;
+
+    /*
+     * If rd is x1 or x5 link registers, treat this as direct call otherwise
+     * its a direct jump.
+     */
+    if (rd == 1 || rd == 5) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_DIRECT_CALL, priv,
+                            virt);
+    } else if (rd == 0) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_DIRECT_JUMP, priv,
+                            virt);
+    } else {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_OTHER_DIRECT_JUMP,
+                            priv, virt);
+    }
+}
+
+void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ulong dest,
+                       target_ulong branch_taken)
+{
+    target_ulong curr_priv = env->priv;
+    bool curr_virt = env->virt_enabled;
+
+    if (branch_taken) {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_TAKEN_BRANCH,
+                            curr_priv, curr_virt);
+    } else {
+        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_NONTAKEN_BRANCH,
+                            curr_priv, curr_virt);
+    }
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 15e7123a68..8b0492991d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -561,6 +561,11 @@ static void gen_set_fpr_d(DisasContext *ctx, int reg_num, TCGv_i64 t)
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
+#ifndef CONFIG_USER_ONLY
+    TCGv dest = tcg_constant_tl(ctx->base.pc_next + imm);
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
+    TCGv tcg_rd = tcg_constant_tl((target_ulong)rd);
+#endif
 
     /* check misaligned: */
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
@@ -572,6 +577,10 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
         }
     }
 
+#ifndef CONFIG_USER_ONLY
+    gen_helper_ctr_jal(tcg_env, src, dest, tcg_rd);
+#endif
+
     gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
     gen_set_gpr(ctx, rd, succ_pc);
 
-- 
2.34.1


