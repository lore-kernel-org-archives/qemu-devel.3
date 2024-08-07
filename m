Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08C0C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDA-0003KL-I7; Tue, 06 Aug 2024 20:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCn-0002YV-5C
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCl-00017z-1e
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:04 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so11856625ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989221; x=1723594021;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svo4LPG7r850nEYgZiVRG+jHhd5cukzMD7ExuHKhohU=;
 b=Wgpvq1xz7qAZ+af1ovAzY5X0c5l4zrQ2Byroqh6J2FdWVtvSeO3urqWEb4mZnC7oq3
 jP6mvzftc0av5b3x3GwtjI/nwi/CnHD6bINvA82aNK9CRou/5OHqHzeWPb+DzaEfl2wO
 uwo8KcDvygfQwZaLQonDac5Ja/FF+PGU+0NMRrZo1YdMOt1ZDd7qj13ynN7YcQl9q6sV
 yMDYzocqnKZRbbFsJDDYKftsn1NWz7PJHlV/0xSHG6ZAU0My2k83WevrZFLHGFoJ6tPp
 tY2gmwn2aUK6ILTWOf3xNTMdJ7Vxydi/QBJ0GA+LySVgKkZm6OnJXBPmnghYhBNy4GXq
 SiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989221; x=1723594021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svo4LPG7r850nEYgZiVRG+jHhd5cukzMD7ExuHKhohU=;
 b=HKAmibgtjaOAB/RFBk+oqcnjdhW5XcmE6qcaO+u8g5tDnY4+yNi21POao8bHe/HJH+
 cGhSwhVqZUvz3qfnMG3/hp9b7+cXGortwhqNLZDLJq642X8K5IsXWNNCvJzpoYVMxNEr
 k9XWV+wlZ3xtquPp1L6xS9GP9rB6/bqE4jrjV61ccGWLCwKkFS7W2ic74RqZ2JVOt2e7
 Ts7wop9AchZoE+hJBbUVyuJlcbBBBEImqcW/Ag1uHPTY1C/bN3/FwIOgWc7mnXdSD4e4
 u6K6mK/VJwMIXAIlr/n1zj/pZWb+QZjg760ujM2Iz0YmerD/d/TLWSPb6DTqY06cpohi
 Y/gg==
X-Gm-Message-State: AOJu0Yxvu0YEXcCIAA7kpjBbydNcCR41Eo/2VXI3L135o+zCozfyAekg
 B5ixHUBPDgPTFH/exGMBNm6aUPGsaseuOljxs2/6yKMguTZBaYo67jOtfWeJHoy+MkRh/HHvJPf
 w
X-Google-Smtp-Source: AGHT+IF03lP5QJ41skWd759etF1SIbqvcnJHu7CDz4o1hqof9i+UAPVNcU/dGlfRbtE5Ix3cIesANQ==
X-Received: by 2002:a17:903:32ce:b0:1fb:8cab:ccc9 with SMTP id
 d9443c01a7336-1ff573cca00mr160609285ad.45.1722989221321; 
 Tue, 06 Aug 2024 17:07:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:01 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 04/20] target/riscv: save and restore elp state on priv
 transitions
Date: Tue,  6 Aug 2024 17:06:35 -0700
Message-ID: <20240807000652.1417776-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x629.google.com
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
index 6709622dd3..8c69c55576 100644
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
+            return env->senvcfg & MENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_M:
+        return env->mseccfg & MSECCFG_MLPE;
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


