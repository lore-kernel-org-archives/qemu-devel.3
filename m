Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A40C41513
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhE-0005Ru-II; Sat, 11 May 2024 06:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhB-0005Qw-9h; Sat, 11 May 2024 06:11:13 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jh4-00029g-NP; Sat, 11 May 2024 06:11:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59a609dd3fso493496566b.0; 
 Sat, 11 May 2024 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422265; x=1716027065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13IqUkrTdnG3QfUVHYTAXzXsHnIMfV9aXHxifSAJZyw=;
 b=krBHqpGix2bOkeFKOom48p3QM8no2W9PLBCav7mF+LfBxHJys9ci0fMcyI83bHzla+
 qWQtVu2+KEJxLpGFKsn/JwohLwBa2MAeLIyOLsrHDPS1IBFuS9h8rD9ifqvXOCvhh17F
 L0ZEVL6e8EYCQDYd0wRPOkHgR6fpzIgsHanjRBXLsHVJs15H3530p7UQ7lWjMDUvaiFP
 Phmj3H0M9u8zyDrGH3wOZhGZykEh3jEvtYsyCBQGv/O9lRiAk+I/4Iog/R3zSAjs1fpC
 7svBexUtMtrPdGPqmTtqgIqPATKQWBuYFDfkXS3Tie0mCzTJ6+Kr8g9I1IJ9A63mxlZE
 9LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422265; x=1716027065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13IqUkrTdnG3QfUVHYTAXzXsHnIMfV9aXHxifSAJZyw=;
 b=ktoBn37WdS5cltnMzV9INo31B0EuI5TxB5LULBYSIPzZxdFeUpotjG9XJnT5kwlERR
 RGeFDNSnDaC3++tdzLoAuXb8jmnErGXQ6QHXHo65m27WNr2MazN47uwGU5zmYuMIKCWh
 sLau4PucKZDAuSyglHT5Y7m3FSm0xGWe5ENCcxxtG8wXnu+sBMJLyHRzckPhcD4iG9UG
 j4A8bTMsUs7d8m5lZjxdMyEPvMhdkHGyVdoUoeqJKxmoK7PNwFzYk7tfqmhQ8JfAmEI/
 OEmnVpWoAXWcVblJVZ0luHrc2rBc8L0Cv69Zr//RzadHE4S6na3FcB5rf1NshccCGKeI
 KZ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQrcSdXqG4yTxUxmSc1bSEFMBpnyU8B3zStnEi61j0v1lijkt+MlUIXq5EJ6Z+5kouOmuTTCW5Ak8jFuu4uv19xpmeBkAqw/0fr+g8HDgSXpMuyEKegTGky0VWGQ==
X-Gm-Message-State: AOJu0YyKesHpcR8DKIQIQi3DQzqP7sVhfg3vQI4c/RAw/9o6BbjdPLvi
 smREXgZMPR0EBsb981UO0sf5kwzJiBRc/cgDbkYV44XsI1hBwC2R
X-Google-Smtp-Source: AGHT+IH90KeoP53DKUyoTyXOGtaMNvaFFeIx/Xsy5gkk8MDNQGKDdPZP2GAc6U7/zse63BwHcYgiMQ==
X-Received: by 2002:a17:906:b7c4:b0:a59:bb24:a61 with SMTP id
 a640c23a62f3a-a5a2d292a23mr421152366b.30.1715422264665; 
 Sat, 11 May 2024 03:11:04 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:03 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 1/6] target/riscv: Remove obsolete pointer masking
 extension code.
Date: Sat, 11 May 2024 13:10:48 +0300
Message-Id: <20240511101053.1875596-2-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
References: <20240511101053.1875596-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Zjpm v0.8 is almost frozen and it's much simplier compared to the existing one:
The newer version doesn't allow to specify custom mask or base for masking.
Instead it allows only certain options for masking top bits.

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c           |  13 +-
 target/riscv/cpu.h           |  30 +---
 target/riscv/cpu_bits.h      |  87 ----------
 target/riscv/cpu_helper.c    |  52 ------
 target/riscv/csr.c           | 326 -----------------------------------
 target/riscv/machine.c       |  14 +-
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  27 +--
 target/riscv/vector_helper.c |   2 +-
 9 files changed, 13 insertions(+), 543 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a74f0eb29c..1e350e9bd8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -42,7 +42,7 @@
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
-                              RVC, RVS, RVU, RVH, RVJ, RVG, RVB, 0};
+                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
 
 /*
  * From vector_helper.c
@@ -795,13 +795,6 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             CSR_MSCRATCH,
             CSR_SSCRATCH,
             CSR_SATP,
-            CSR_MMTE,
-            CSR_UPMBASE,
-            CSR_UPMMASK,
-            CSR_SPMBASE,
-            CSR_SPMMASK,
-            CSR_MPMBASE,
-            CSR_MPMMASK,
         };
 
         for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
@@ -981,8 +974,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         }
         i++;
     }
-    /* mmte is supposed to have pm.current hardwired to 1 */
-    env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
 
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
@@ -1004,7 +995,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     pmp_unlock_entries(env);
 #endif
     env->xl = riscv_cpu_mxl(env);
-    riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
@@ -1395,7 +1385,6 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVS, "s", "Supervisor-level instructions"),
     MISA_EXT_INFO(RVU, "u", "User-level instructions"),
     MISA_EXT_INFO(RVH, "h", "Hypervisor"),
-    MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
     MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e0dd1828b5..232521bb87 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -66,7 +66,6 @@ typedef struct CPUArchState CPURISCVState;
 #define RVS RV('S')
 #define RVU RV('U')
 #define RVH RV('H')
-#define RVJ RV('J')
 #define RVG RV('G')
 #define RVB RV('B')
 
@@ -393,17 +392,6 @@ struct CPUArchState {
     /* True if in debugger mode.  */
     bool debugger;
 
-    /*
-     * CSRs for PointerMasking extension
-     */
-    target_ulong mmte;
-    target_ulong mpmmask;
-    target_ulong mpmbase;
-    target_ulong spmmask;
-    target_ulong spmbase;
-    target_ulong upmmask;
-    target_ulong upmbase;
-
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
@@ -412,9 +400,6 @@ struct CPUArchState {
     target_ulong senvcfg;
     uint64_t henvcfg;
 #endif
-    target_ulong cur_pmmask;
-    target_ulong cur_pmbase;
-
     /* Fields from here on are preserved across CPU reset. */
     QEMUTimer *stimer; /* Internal timer for S-mode interrupt */
     QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
@@ -563,16 +548,14 @@ FIELD(TB_FLAGS, VSTART_EQ_ZERO, 15, 1)
 /* The combination of MXL/SXL/UXL that applies to the current cpu mode. */
 FIELD(TB_FLAGS, XL, 16, 2)
 /* If PointerMasking should be applied */
-FIELD(TB_FLAGS, PM_MASK_ENABLED, 18, 1)
-FIELD(TB_FLAGS, PM_BASE_ENABLED, 19, 1)
-FIELD(TB_FLAGS, VTA, 20, 1)
-FIELD(TB_FLAGS, VMA, 21, 1)
+FIELD(TB_FLAGS, VTA, 18, 1)
+FIELD(TB_FLAGS, VMA, 19, 1)
 /* Native debug itrigger */
-FIELD(TB_FLAGS, ITRIGGER, 22, 1)
+FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 /* Virtual mode enabled */
-FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
-FIELD(TB_FLAGS, PRIV, 24, 2)
-FIELD(TB_FLAGS, AXL, 26, 2)
+FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
+FIELD(TB_FLAGS, PRIV, 22, 2)
+FIELD(TB_FLAGS, AXL, 24, 2)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -705,7 +688,6 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
-void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 74318a925c..da16ba236a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -484,37 +484,6 @@
 #define CSR_MHPMCOUNTER30H  0xb9e
 #define CSR_MHPMCOUNTER31H  0xb9f
 
-/*
- * User PointerMasking registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_UMTE            0x4c0
-#define CSR_UPMMASK         0x4c1
-#define CSR_UPMBASE         0x4c2
-
-/*
- * Machine PointerMasking registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_MMTE            0x3c0
-#define CSR_MPMMASK         0x3c1
-#define CSR_MPMBASE         0x3c2
-
-/*
- * Supervisor PointerMaster registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_SMTE            0x1c0
-#define CSR_SPMMASK         0x1c1
-#define CSR_SPMBASE         0x1c2
-
-/*
- * Hypervisor PointerMaster registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_VSMTE           0x2c0
-#define CSR_VSPMMASK        0x2c1
-#define CSR_VSPMBASE        0x2c2
 #define CSR_SCOUNTOVF       0xda0
 
 /* Crypto Extension */
@@ -734,11 +703,6 @@ typedef enum RISCVException {
 #define VS_MODE_INTERRUPTS ((uint64_t)(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP))
 #define HS_MODE_INTERRUPTS ((uint64_t)(MIP_SGEIP | VS_MODE_INTERRUPTS))
 
-/* General PointerMasking CSR bits */
-#define PM_ENABLE       0x00000001ULL
-#define PM_CURRENT      0x00000002ULL
-#define PM_INSN         0x00000004ULL
-
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_CBIE                       (3UL << 4)
@@ -771,57 +735,6 @@ typedef enum RISCVException {
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
 
-/* Offsets for every pair of control bits per each priv level */
-#define XS_OFFSET    0ULL
-#define U_OFFSET     2ULL
-#define S_OFFSET     5ULL
-#define M_OFFSET     8ULL
-
-#define PM_XS_BITS   (EXT_STATUS_MASK << XS_OFFSET)
-#define U_PM_ENABLE  (PM_ENABLE  << U_OFFSET)
-#define U_PM_CURRENT (PM_CURRENT << U_OFFSET)
-#define U_PM_INSN    (PM_INSN    << U_OFFSET)
-#define S_PM_ENABLE  (PM_ENABLE  << S_OFFSET)
-#define S_PM_CURRENT (PM_CURRENT << S_OFFSET)
-#define S_PM_INSN    (PM_INSN    << S_OFFSET)
-#define M_PM_ENABLE  (PM_ENABLE  << M_OFFSET)
-#define M_PM_CURRENT (PM_CURRENT << M_OFFSET)
-#define M_PM_INSN    (PM_INSN    << M_OFFSET)
-
-/* mmte CSR bits */
-#define MMTE_PM_XS_BITS     PM_XS_BITS
-#define MMTE_U_PM_ENABLE    U_PM_ENABLE
-#define MMTE_U_PM_CURRENT   U_PM_CURRENT
-#define MMTE_U_PM_INSN      U_PM_INSN
-#define MMTE_S_PM_ENABLE    S_PM_ENABLE
-#define MMTE_S_PM_CURRENT   S_PM_CURRENT
-#define MMTE_S_PM_INSN      S_PM_INSN
-#define MMTE_M_PM_ENABLE    M_PM_ENABLE
-#define MMTE_M_PM_CURRENT   M_PM_CURRENT
-#define MMTE_M_PM_INSN      M_PM_INSN
-#define MMTE_MASK    (MMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | MMTE_U_PM_INSN | \
-                      MMTE_S_PM_ENABLE | MMTE_S_PM_CURRENT | MMTE_S_PM_INSN | \
-                      MMTE_M_PM_ENABLE | MMTE_M_PM_CURRENT | MMTE_M_PM_INSN | \
-                      MMTE_PM_XS_BITS)
-
-/* (v)smte CSR bits */
-#define SMTE_PM_XS_BITS     PM_XS_BITS
-#define SMTE_U_PM_ENABLE    U_PM_ENABLE
-#define SMTE_U_PM_CURRENT   U_PM_CURRENT
-#define SMTE_U_PM_INSN      U_PM_INSN
-#define SMTE_S_PM_ENABLE    S_PM_ENABLE
-#define SMTE_S_PM_CURRENT   S_PM_CURRENT
-#define SMTE_S_PM_INSN      S_PM_INSN
-#define SMTE_MASK    (SMTE_U_PM_ENABLE | SMTE_U_PM_CURRENT | SMTE_U_PM_INSN | \
-                      SMTE_S_PM_ENABLE | SMTE_S_PM_CURRENT | SMTE_S_PM_INSN | \
-                      SMTE_PM_XS_BITS)
-
-/* umte CSR bits */
-#define UMTE_U_PM_ENABLE    U_PM_ENABLE
-#define UMTE_U_PM_CURRENT   U_PM_CURRENT
-#define UMTE_U_PM_INSN      U_PM_INSN
-#define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_INSN)
-
 /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
 #define ISELECT_IPRIO0                     0x30
 #define ISELECT_IPRIO15                    0x3f
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2097a26ca0..bf58350669 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -138,61 +138,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
-    if (env->cur_pmmask != 0) {
-        flags = FIELD_DP32(flags, TB_FLAGS, PM_MASK_ENABLED, 1);
-    }
-    if (env->cur_pmbase != 0) {
-        flags = FIELD_DP32(flags, TB_FLAGS, PM_BASE_ENABLED, 1);
-    }
 
     *pflags = flags;
 }
 
-void riscv_cpu_update_mask(CPURISCVState *env)
-{
-    target_ulong mask = 0, base = 0;
-    RISCVMXL xl = env->xl;
-    /*
-     * TODO: Current RVJ spec does not specify
-     * how the extension interacts with XLEN.
-     */
-#ifndef CONFIG_USER_ONLY
-    int mode = cpu_address_mode(env);
-    xl = cpu_get_xl(env, mode);
-    if (riscv_has_ext(env, RVJ)) {
-        switch (mode) {
-        case PRV_M:
-            if (env->mmte & M_PM_ENABLE) {
-                mask = env->mpmmask;
-                base = env->mpmbase;
-            }
-            break;
-        case PRV_S:
-            if (env->mmte & S_PM_ENABLE) {
-                mask = env->spmmask;
-                base = env->spmbase;
-            }
-            break;
-        case PRV_U:
-            if (env->mmte & U_PM_ENABLE) {
-                mask = env->upmmask;
-                base = env->upmbase;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-#endif
-    if (xl == MXL_RV32) {
-        env->cur_pmmask = mask & UINT32_MAX;
-        env->cur_pmbase = base & UINT32_MAX;
-    } else {
-        env->cur_pmmask = mask;
-        env->cur_pmbase = base;
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 
 /*
@@ -724,7 +673,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
     env->xl = cpu_recompute_xl(env);
-    riscv_cpu_update_mask(env);
 
     /*
      * Clear the load reservation - otherwise a reservation placed in one
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6b460ee0e8..4b2c932564 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -486,16 +486,6 @@ static RISCVException hgatp(CPURISCVState *env, int csrno)
     return hmode(env, csrno);
 }
 
-/* Checks if PointerMasking registers could be accessed */
-static RISCVException pointer_masking(CPURISCVState *env, int csrno)
-{
-    /* Check if j-ext is present */
-    if (riscv_has_ext(env, RVJ)) {
-        return RISCV_EXCP_NONE;
-    }
-    return RISCV_EXCP_ILLEGAL_INST;
-}
-
 static RISCVException aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
@@ -1404,7 +1394,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         env->xl = cpu_recompute_xl(env);
     }
 
-    riscv_cpu_update_mask(env);
     return RISCV_EXCP_NONE;
 }
 
@@ -3971,302 +3960,6 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-/*
- * Functions to access Pointer Masking feature registers
- * We have to check if current priv lvl could modify
- * csr in given mode
- */
-static bool check_pm_current_disabled(CPURISCVState *env, int csrno)
-{
-    int csr_priv = get_field(csrno, 0x300);
-    int pm_current;
-
-    if (env->debugger) {
-        return false;
-    }
-    /*
-     * If priv lvls differ that means we're accessing csr from higher priv lvl,
-     * so allow the access
-     */
-    if (env->priv != csr_priv) {
-        return false;
-    }
-    switch (env->priv) {
-    case PRV_M:
-        pm_current = get_field(env->mmte, M_PM_CURRENT);
-        break;
-    case PRV_S:
-        pm_current = get_field(env->mmte, S_PM_CURRENT);
-        break;
-    case PRV_U:
-        pm_current = get_field(env->mmte, U_PM_CURRENT);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    /* It's same priv lvl, so we allow to modify csr only if pm.current==1 */
-    return !pm_current;
-}
-
-static RISCVException read_mmte(CPURISCVState *env, int csrno,
-                                target_ulong *val)
-{
-    *val = env->mmte & MMTE_MASK;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_mmte(CPURISCVState *env, int csrno,
-                                 target_ulong val)
-{
-    uint64_t mstatus;
-    target_ulong wpri_val = val & MMTE_MASK;
-
-    if (val != wpri_val) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s" TARGET_FMT_lx " %s"
-                      TARGET_FMT_lx "\n", "MMTE: WPRI violation written 0x",
-                      val, "vs expected 0x", wpri_val);
-    }
-    /* for machine mode pm.current is hardwired to 1 */
-    wpri_val |= MMTE_M_PM_CURRENT;
-
-    /* hardwiring pm.instruction bit to 0, since it's not supported yet */
-    wpri_val &= ~(MMTE_M_PM_INSN | MMTE_S_PM_INSN | MMTE_U_PM_INSN);
-    env->mmte = wpri_val | EXT_STATUS_DIRTY;
-    riscv_cpu_update_mask(env);
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_smte(CPURISCVState *env, int csrno,
-                                target_ulong *val)
-{
-    *val = env->mmte & SMTE_MASK;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_smte(CPURISCVState *env, int csrno,
-                                 target_ulong val)
-{
-    target_ulong wpri_val = val & SMTE_MASK;
-
-    if (val != wpri_val) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s" TARGET_FMT_lx " %s"
-                      TARGET_FMT_lx "\n", "SMTE: WPRI violation written 0x",
-                      val, "vs expected 0x", wpri_val);
-    }
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-
-    wpri_val |= (env->mmte & ~SMTE_MASK);
-    write_mmte(env, csrno, wpri_val);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_umte(CPURISCVState *env, int csrno,
-                                target_ulong *val)
-{
-    *val = env->mmte & UMTE_MASK;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_umte(CPURISCVState *env, int csrno,
-                                 target_ulong val)
-{
-    target_ulong wpri_val = val & UMTE_MASK;
-
-    if (val != wpri_val) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s" TARGET_FMT_lx " %s"
-                      TARGET_FMT_lx "\n", "UMTE: WPRI violation written 0x",
-                      val, "vs expected 0x", wpri_val);
-    }
-
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-
-    wpri_val |= (env->mmte & ~UMTE_MASK);
-    write_mmte(env, csrno, wpri_val);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_mpmmask(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->mpmmask;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_mpmmask(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    env->mpmmask = val;
-    if ((cpu_address_mode(env) == PRV_M) && (env->mmte & M_PM_ENABLE)) {
-        env->cur_pmmask = val;
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_spmmask(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->spmmask;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_spmmask(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->spmmask = val;
-    if ((cpu_address_mode(env) == PRV_S) && (env->mmte & S_PM_ENABLE)) {
-        env->cur_pmmask = val;
-        if (cpu_get_xl(env, PRV_S) == MXL_RV32) {
-            env->cur_pmmask &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_upmmask(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->upmmask;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_upmmask(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->upmmask = val;
-    if ((cpu_address_mode(env) == PRV_U) && (env->mmte & U_PM_ENABLE)) {
-        env->cur_pmmask = val;
-        if (cpu_get_xl(env, PRV_U) == MXL_RV32) {
-            env->cur_pmmask &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_mpmbase(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->mpmbase;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_mpmbase(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    env->mpmbase = val;
-    if ((cpu_address_mode(env) == PRV_M) && (env->mmte & M_PM_ENABLE)) {
-        env->cur_pmbase = val;
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_spmbase(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->spmbase;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_spmbase(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->spmbase = val;
-    if ((cpu_address_mode(env) == PRV_S) && (env->mmte & S_PM_ENABLE)) {
-        env->cur_pmbase = val;
-        if (cpu_get_xl(env, PRV_S) == MXL_RV32) {
-            env->cur_pmbase &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_upmbase(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->upmbase;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_upmbase(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->upmbase = val;
-    if ((cpu_address_mode(env) == PRV_U) && (env->mmte & U_PM_ENABLE)) {
-        env->cur_pmbase = val;
-        if (cpu_get_xl(env, PRV_U) == MXL_RV32) {
-            env->cur_pmbase &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
 #endif
 
 /* Crypto Extension */
@@ -4925,25 +4618,6 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
 
-    /* User Pointer Masking */
-    [CSR_UMTE]    =    { "umte",    pointer_masking, read_umte,  write_umte },
-    [CSR_UPMMASK] =    { "upmmask", pointer_masking, read_upmmask,
-                         write_upmmask                                      },
-    [CSR_UPMBASE] =    { "upmbase", pointer_masking, read_upmbase,
-                         write_upmbase                                      },
-    /* Machine Pointer Masking */
-    [CSR_MMTE]    =    { "mmte",    pointer_masking, read_mmte,  write_mmte },
-    [CSR_MPMMASK] =    { "mpmmask", pointer_masking, read_mpmmask,
-                         write_mpmmask                                      },
-    [CSR_MPMBASE] =    { "mpmbase", pointer_masking, read_mpmbase,
-                         write_mpmbase                                      },
-    /* Supervisor Pointer Masking */
-    [CSR_SMTE]    =    { "smte",    pointer_masking, read_smte,  write_smte },
-    [CSR_SPMMASK] =    { "spmmask", pointer_masking, read_spmmask,
-                         write_spmmask                                      },
-    [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase,
-                         write_spmbase                                      },
-
     /* Performance Counters */
     [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
     [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 76f2150f78..64ab66e332 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -152,10 +152,7 @@ static const VMStateDescription vmstate_vector = {
 
 static bool pointermasking_needed(void *opaque)
 {
-    RISCVCPU *cpu = opaque;
-    CPURISCVState *env = &cpu->env;
-
-    return riscv_has_ext(env, RVJ);
+    return false;
 }
 
 static const VMStateDescription vmstate_pointermasking = {
@@ -164,14 +161,6 @@ static const VMStateDescription vmstate_pointermasking = {
     .minimum_version_id = 1,
     .needed = pointermasking_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.mmte, RISCVCPU),
-        VMSTATE_UINTTL(env.mpmmask, RISCVCPU),
-        VMSTATE_UINTTL(env.mpmbase, RISCVCPU),
-        VMSTATE_UINTTL(env.spmmask, RISCVCPU),
-        VMSTATE_UINTTL(env.spmbase, RISCVCPU),
-        VMSTATE_UINTTL(env.upmmask, RISCVCPU),
-        VMSTATE_UINTTL(env.upmbase, RISCVCPU),
-
         VMSTATE_END_OF_LIST()
     }
 };
@@ -266,7 +255,6 @@ static int riscv_cpu_post_load(void *opaque, int version_id)
     CPURISCVState *env = &cpu->env;
 
     env->xl = cpu_recompute_xl(env);
-    riscv_cpu_update_mask(env);
     return 0;
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4ebebebe09..f64316ef17 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -998,7 +998,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVS, true),
     MISA_CFG(RVU, true),
     MISA_CFG(RVH, true),
-    MISA_CFG(RVJ, false),
     MISA_CFG(RVV, false),
     MISA_CFG(RVG, false),
     MISA_CFG(RVB, false),
@@ -1285,8 +1284,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     CPURISCVState *env = &cpu->env;
     const RISCVCPUMultiExtConfig *prop;
 
-    /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
+    /* Enable RVG and RVV that are disabled by default */
+    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ff09ebdb6..e5b339b1fa 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -42,9 +42,6 @@ static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
-/* globals for PM CSRs */
-static TCGv pm_mask;
-static TCGv pm_base;
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -106,9 +103,6 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
-    /* PointerMasking extension */
-    bool pm_mask_enabled;
-    bool pm_base_enabled;
     /* Ztso */
     bool ztso;
     /* Use icount trigger for native debug */
@@ -583,14 +577,9 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (ctx->pm_mask_enabled) {
-        tcg_gen_andc_tl(addr, addr, pm_mask);
-    } else if (get_address_xl(ctx) == MXL_RV32) {
+    if (get_address_xl(ctx) == MXL_RV32) {
         tcg_gen_ext32u_tl(addr, addr);
     }
-    if (ctx->pm_base_enabled) {
-        tcg_gen_or_tl(addr, addr, pm_base);
-    }
 
     return addr;
 }
@@ -602,14 +591,9 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (ctx->pm_mask_enabled) {
-        tcg_gen_andc_tl(addr, addr, pm_mask);
-    } else if (get_xl(ctx) == MXL_RV32) {
+    if (get_xl(ctx) == MXL_RV32) {
         tcg_gen_ext32u_tl(addr, addr);
     }
-    if (ctx->pm_base_enabled) {
-        tcg_gen_or_tl(addr, addr, pm_base);
-    }
     return addr;
 }
 
@@ -1201,8 +1185,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->pm_mask_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_MASK_ENABLED);
-    ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
@@ -1335,9 +1317,4 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
                              "load_val");
-    /* Assign PM CSRs to tcg globals */
-    pm_mask = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, cur_pmmask),
-                                 "pmmask");
-    pm_base = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, cur_pmbase),
-                                 "pmbase");
 }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fa139040f8..39ba2a09dd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -104,7 +104,7 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
-    return (addr & ~env->cur_pmmask) | env->cur_pmbase;
+    return addr;
 }
 
 /*
-- 
2.34.1


