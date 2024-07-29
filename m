Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BEEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZ1-0004RU-JX; Mon, 29 Jul 2024 13:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ0-0004LA-1S
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:38 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUYy-0000Gl-1Q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:37 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-264988283a3so2226728fac.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275615; x=1722880415;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5/LzlqpvA6Qpq2davUTlla9GHONddj7cGNIIGXRrAY=;
 b=ZVxGuylkBgtb5pEinioSx8GK5h1vAGIDmQ3BjYC1qSlv66XD9IyW1gEC1T9sNyOU+t
 z3+9qgZDiAgC5VIyibOW6qKoh/ahX//laeTHPE6U+UDCr5d+i2ztqFwkq9scMjMsjaHX
 heDCrPZbusMQ7TC4R54r/z/1YibG2HrVr1UCNknVfEdw90R6azSOfZzte3IDYiHRnMFA
 vktPCZvyak56++gZmAaRe7GQ2mHLK49oVBTDeKXf1bt7bo8ahVqnIdpHnoaU2h2e8DUj
 36GTXCR+E6sE1dP19mHn7LmPhCbos46tWbPVcpB4whe1ioFsqnyNLcucmJxQHPUt5rTb
 oPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275615; x=1722880415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5/LzlqpvA6Qpq2davUTlla9GHONddj7cGNIIGXRrAY=;
 b=JKIjxQiZcdPaMt47jRLi3E02q/66vei/TmCNPM618iDj+jf7FutPrsrsfeEx0dMbje
 MZoQ2g/vxzSHRHN0wtLGLxy1nJgmaX1IGEYartqbUC5127LuvmlF3zksK9xjvhCPSelW
 AUv2UIZifR9l2OGIsLLMiho4i/buIRYj/XAXwuA/dhD2Wn7s5ttl/G+irNiPNElYVH4X
 tbr7gzi/ms/CWxzn8ZigdUrGVibk/CTXevnlPhIb0qDiGmBjCNTX+rZs1XFW8uIK/yq5
 FxqIB2vwc9uyioo6tJyoEO56XVNvW1fvx3ESIT07v0rNSRuhSyb53sPTzN+tCbms3uv7
 u6+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRDOWkOFXJqBWvr2DTbAa8532ORskqan9IKubu3uYvpx7LkOL5chrfsC2Sr/nbAY+WvRUkuTU5KY9SKP1maFBGBfn1LUo=
X-Gm-Message-State: AOJu0Yxt+nrKbLdHSMtBWGy/4ORB39N6tyctjbw209iww8aZJsEHNtR3
 lRU3J+ef4iTpCNhGb8LvAOuviaIMlKcrzaXLwXLDetWYFSem08jx4Q5X4Goc4Nw=
X-Google-Smtp-Source: AGHT+IH+QgeEy6BsZk/gOD/sp/LPU/vdIv4UDP31JbaiB8OK2v14GWSuZJzYTtMv3UdYz77Rw0NMCw==
X-Received: by 2002:a05:6870:350f:b0:261:1a62:a829 with SMTP id
 586e51a60fabf-267d4f32d20mr9979490fac.46.1722275614669; 
 Mon, 29 Jul 2024 10:53:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 03/24] target/riscv: save and restore elp state on priv
 transitions
Date: Mon, 29 Jul 2024 10:53:05 -0700
Message-ID: <20240729175327.73705-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

elp state is recorded in *status on trap entry (less privilege to higher
privilege) and restored in elp from *status on trap exit (higher to less
privilege).

Additionally this patch introduces a forward cfi helper function to
determine if current privilege has forward cfi is enabled or not based on
*envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
new field `ufcfien` is introduced which is by default set to false and
helper function returns value deposited in `ufcfien` for qemu-user.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c        |  5 ++++
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c  | 18 ++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 82fa85a8d6..e1526c7ab5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,6 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
 
+#ifdef CONFIG_USER_ONLY
+    /* qemu-user for riscv, fcfi is off by default */
+    env->ufcfien = false;
+#endif
+
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ae436a3179..8c7841fc08 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,6 +226,7 @@ struct CPUArchState {
     cfi_elp      elp;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
+    bool ufcfien;
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -530,6 +531,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3..fb4b6066d3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -63,6 +64,35 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool cpu_get_fcfien(CPURISCVState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    return env->ufcfien;
+#else
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfilp) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            return (env->senvcfg & MENVCFG_LPE) ? true : false;
+        }
+        return (env->menvcfg & MENVCFG_LPE) ? true : false;
+    case PRV_S:
+        if (env->virt_enabled) {
+            return (env->henvcfg & HENVCFG_LPE) ? true : false;
+        }
+        return (env->menvcfg & MENVCFG_LPE) ? true : false;
+    case PRV_M:
+        return (env->mseccfg & MSECCFG_MLPE) ? true : false;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -546,6 +576,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
     bool current_virt = env->virt_enabled;
 
+    /*
+     * If zicfilp extension available and henvcfg.LPE = 1,
+     * then apply SPELP mask on mstatus
+     */
+    if (env_archcpu(env)->cfg.ext_zicfilp &&
+        get_field(env->henvcfg, HENVCFG_LPE)) {
+        mstatus_mask |= SSTATUS_SPELP;
+    }
+
     g_assert(riscv_has_ext(env, RVH));
 
     if (current_virt) {
@@ -1754,6 +1793,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected)) {
         /* handle the trap in S-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
 
@@ -1802,6 +1846,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             if (env->virt_enabled) {
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -1833,6 +1882,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M);
     }
 
+    /*
+     * Interrupt/exception/trap delivery is asynchronous event and as per
+     * Zisslpcfi spec CPU should clear up the ELP state. If cfi extension is
+     * available, clear ELP state.
+     */
+
+    if (cpu->cfg.ext_zicfilp) {
+        env->elp = NO_LP_EXPECTED;
+    }
     /*
      * NOTE: it is not necessary to yield load reservations here. It is only
      * necessary for an SC from "another hart" to cause a load reservation
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca..488116cc2e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -313,6 +313,15 @@ target_ulong helper_sret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear spelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_SPELP);
+        env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
+    }
+
     return retpc;
 }
 
@@ -357,6 +366,15 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_cpu_set_virt_enabled(env, prev_virt);
     }
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mpelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_MPELP);
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
+    }
+
     return retpc;
 }
 
-- 
2.44.0


