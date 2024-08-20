Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54CEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKq-0002o6-DD; Mon, 19 Aug 2024 20:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKj-0002MR-SW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKT-0001Dc-L5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20230059241so13042885ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112107; x=1724716907;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKb9Jz70toaKOOuMQxcHbp4pO9J/t6pOWc577kuJQCg=;
 b=KFVssq2QbkZ5rgh+kJYymIUxKMRKwu8VPFAdtZJVP/O+JepbBUMnIiIj7oXIYIFZqH
 ADPGiX/ZHX2g24uk3EmBCC5L84JLsWYlcxBz9PC0hLm8t3/g0Wp7JrGuXXaHB9yVDjp4
 8uGIRLuxTb/j5WzP42KOO2QAaQbZ/fdazRJo53OFkFF/4Jdh4s0K2fep/au0QF4A6FCh
 rL2dP0FJrfUQNhud/2bXe2wPNWdhj57u0iVySDTeBC/REwdCC1nlJOnLMNDUsykUjK2e
 hmAoOPqVbgUL+qO6LRx3PlPBtWcYDqMcJsxqespw223Qy1oIsuySewx0T8QllwgVpWpl
 NYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112107; x=1724716907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKb9Jz70toaKOOuMQxcHbp4pO9J/t6pOWc577kuJQCg=;
 b=RByo4Zsst5ItX8EdQ6VHEJhKBI7h7XjBTWSeWLy8oy/7Ue+CuGfJdhHC8WUTE89XZY
 T7Bseo6IBG8e5iv5NZ55ytL/bIK0QblaRf4XXOA9Y2zMZqRFT6t7kOn0QIxoT8imUGdr
 8tkIC7FAfHse/Tl5rU8NZL5C0MKARcvaV1g42oX0c9JUOF2cM4wy7oklLblahz9nYhDQ
 u69OK3x/5zH4hpzsS5JeUMK4Z3L9Zx+UBWXp/L3AkK3j79RjJUszkTGOh2ceBiWdNdCI
 tpOVMXkSOJaTLuipT+XThcjGBUFoC5UTrs/RXhrg+yV/bBEodpBVD8yxSAv4saST/LiT
 k2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWjgo2e0LaRo6F+j8Tzzjvg/6Ho8WI3rztNVN8kH2k0msPhBuqgZcNKttUwOUOOaRjQwClBsvlqy97z7c6DpPWXJUHpLg=
X-Gm-Message-State: AOJu0YxDffwcqQET7e/jAWFelSSAUBGFZFphwujcLeukanEi3gOpsVVX
 A+6FsKkGzHRHyh7aWJRHSl23bv4HEHDPOcHeqGRqW9ntJ4AZLW+ZN7izj6xp555BzxEdDNXOF+x
 G
X-Google-Smtp-Source: AGHT+IG1dFouqwPps9mtCUPD4tR6tk2VTBIQWgKSGC4Aaes1c22P74uSFrKDMC/mLiVvuOutabzmpQ==
X-Received: by 2002:a17:902:ec8c:b0:202:311c:1a59 with SMTP id
 d9443c01a7336-202311c2088mr63225425ad.27.1724112106526; 
 Mon, 19 Aug 2024 17:01:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v5 09/15] target/riscv: introduce ssp and enabling controls
 for zicfiss
Date: Mon, 19 Aug 2024 17:01:23 -0700
Message-ID: <20240820000129.3522346-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

zicfiss introduces a new state ssp ("shadow stack register") in cpu.
ssp is expressed as a new unprivileged csr (CSR_SSP=0x11) and holds
virtual address for shadow stack as programmed by software.

Shadow stack (for each mode) is enabled via bit3 in *envcfg CSRs.
Shadow stack can be enabled for a mode only if it's higher privileged
mode had it enabled for itself. M mode doesn't need enabling control,
it's always available if extension is available on cpu.

This patch also implements helper bcfi function which determines if bcfi
is enabled at current privilege or not. qemu-user also gets field
`ubcfien` indicating whether qemu user has shadow stack enabled or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c        |  5 ++++
 target/riscv/cpu.h        |  4 +++
 target/riscv/cpu_bits.h   |  6 +++++
 target/riscv/cpu_helper.c | 25 +++++++++++++++++++
 target/riscv/csr.c        | 52 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 10a2a32345..76f1edd15a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -998,6 +998,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* on reset elp is clear */
     env->elp = false;
 
+    /* on reset ssp is set to 0 */
+    env->ssp = 0;
+
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
      * extension is enabled.
@@ -1026,6 +1029,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #ifdef CONFIG_USER_ONLY
     /* qemu-user for riscv, fcfi is off by default */
     env->ufcfien = false;
+    /* qemu-user for riscv, bcfi is off by default */
+    env->ubcfien = false;
 #endif
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index edf540339a..5a57099d59 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,11 +224,14 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* shadow stack register for zicfiss extension */
+    target_ulong ssp;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
     bool ufcfien;
+    bool ubcfien;
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -534,6 +537,7 @@ bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
+bool cpu_get_bcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 900769ce60..48ce24dc32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -34,6 +34,9 @@
 
 /* Control and Status Registers */
 
+/* zicfiss user ssp csr */
+#define CSR_SSP             0x011
+
 /* User Trap Setup */
 #define CSR_USTATUS         0x000
 #define CSR_UIE             0x004
@@ -754,6 +757,7 @@ typedef enum RISCVException {
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_LPE                        BIT(2) /* zicfilp */
+#define MENVCFG_SSE                        BIT(3) /* zicfiss */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -768,12 +772,14 @@ typedef enum RISCVException {
 
 #define SENVCFG_FIOM                       MENVCFG_FIOM
 #define SENVCFG_LPE                        MENVCFG_LPE
+#define SENVCFG_SSE                        MENVCFG_SSE
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
+#define HENVCFG_SSE                        MENVCFG_SSE
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3a56bea8b9..96571177ef 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -92,6 +92,31 @@ bool cpu_get_fcfien(CPURISCVState *env)
 #endif
 }
 
+bool cpu_get_bcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return false;
+    }
+#ifdef CONFIG_USER_ONLY
+    return env->ubcfien;
+#else
+    switch (env->priv) {
+    case PRV_U:
+        return env->senvcfg & SENVCFG_SSE;
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_SSE;
+        }
+        return env->menvcfg & MENVCFG_SSE;
+    case PRV_M: /* M-mode shadow stack is always on if hart implements */
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5a969a377..ec04b2b32b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -185,6 +185,25 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException cfi_ss(CPURISCVState *env, int csrno)
+{
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /* if bcfi not active for current env, access to csr is illegal */
+    if (!cpu_get_bcfien(env)) {
+#if !defined(CONFIG_USER_ONLY)
+        if (env->debugger) {
+            return RISCV_EXCP_NONE;
+        }
+#endif
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
@@ -596,6 +615,19 @@ static RISCVException seed(CPURISCVState *env, int csrno)
 #endif
 }
 
+/* zicfiss CSR_SSP read and write */
+static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->ssp;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->ssp = val;
+    return RISCV_EXCP_NONE;
+}
+
 /* User Floating-Point CSRs */
 static RISCVException read_fflags(CPURISCVState *env, int csrno,
                                   target_ulong *val)
@@ -2111,6 +2143,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
         }
+
+        if (env_archcpu(env)->cfg.ext_zicfiss) {
+            mask |= MENVCFG_SSE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2167,6 +2203,13 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_LPE;
     }
 
+    /* Higher mode SSE must be ON for next-less mode SSE to be ON */
+    if (env_archcpu(env)->cfg.ext_zicfiss &&
+        get_field(env->menvcfg, MENVCFG_SSE) &&
+        (env->virt_enabled ? get_field(env->henvcfg, HENVCFG_SSE) : true)) {
+        mask |= SENVCFG_SSE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2208,6 +2251,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= HENVCFG_LPE;
         }
+
+        /* H can light up SSE for VS only if HS had it from menvcfg */
+        if (env_archcpu(env)->cfg.ext_zicfiss &&
+            get_field(env->menvcfg, MENVCFG_SSE)) {
+            mask |= HENVCFG_SSE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -4663,6 +4712,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Zcmt Extension */
     [CSR_JVT] = {"jvt", zcmt, read_jvt, write_jvt},
 
+    /* zicfiss Extension, shadow stack register */
+    [CSR_SSP]  = { "ssp", cfi_ss, read_ssp, write_ssp },
+
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
     [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter,
-- 
2.44.0


