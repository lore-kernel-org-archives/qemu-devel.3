Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F5C7EE33
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUPtF-0000yC-J0; Wed, 25 Jun 2025 09:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uUNqX-0003m0-Ni; Wed, 25 Jun 2025 06:59:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uUNqU-0001WN-3f; Wed, 25 Jun 2025 06:59:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so637566b3a.1; 
 Wed, 25 Jun 2025 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750849150; x=1751453950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DfTlTxK1dlkaot0V6gSP9zmhbaUrUlY5kLppezkfyDY=;
 b=UirR6gxqxGo3w7+ohvUwnC7AjpPPOclg1JkDzqM5/e1fQDGadk+oKr0sKtrdG9tFPZ
 ZZok43Eco4W4pYguA1TD8Cx+27YyRVtaVyg7lF+BW0Sy7cJu+YMeLq7PwaJuLmB+haUc
 liJAlQq9snx/QzTpzkShbXFoOWsAj2WAlZAyMBDu0FA7xWH6QJWK9XU6yhzHAjkxIybV
 CI78lAi7sF+cTvPvgybam85rOPC7Yx81rJ/6r5x6envC0GwUHR1qHoVc3ikEe2/xzpPt
 o9oNKo4FihImfSmoOu2uG9VCOSHyMrv9KW3CiFhBM8rrBsZwXPrS1OaXdXe5wTNOA3PG
 OCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750849150; x=1751453950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DfTlTxK1dlkaot0V6gSP9zmhbaUrUlY5kLppezkfyDY=;
 b=tyASX9AO7rymzENVYe5z7UrEuwU2JJ6W/RbsPC90bWNIbiLrkWdwuSTYOmTEDn3PHl
 EcUjB9AOscCdP6hVozCBLW/kazKqF36zTdEoF5G/sxKQ5o531kjMsPPHLDc3a65kAe8I
 JS+P4f6UuicYdJD0TIDHE2DwgBKcJhkUPYjQNmvfMz7Bi0hOb4c2Uti0s3vHHHP6fhdC
 W+UfStUaQnMBdSs00OEfUWbfTIjC7j/C9h9kfZL+ensHLl46rxzSV3x13IM+Qwb9RByi
 8W36aatvzEOUbtaZ5Ilb+0PdxbahhtT1A6z1q82hCJenttaV7ro7Gq+YpQNCTrjxgSs6
 JQFA==
X-Gm-Message-State: AOJu0YwRhRVw/MGl5sjG2d/4V6gOyNJhiBlCKOiBjbejRM0z6AGStqcS
 AAi7FfreRCpvvz4bliPGJBNvBzr3a1zy/3rC7X9Kjv2ZWSeOgptwXEc3lTzULJ4/nCw=
X-Gm-Gg: ASbGncuZMf2T3s6GwAe76COhMDeWFRCcd4OgPqI/5I/k3ZvBmr9abw+6cL+uRVJB1ki
 8HD8PW1dicLcXKEVuLZCN0pLjEzbb+eGKyA+Wul1uQrDe7EGK9lOR85hyEMzaVqvZEZ9fDo5pFH
 0XjcaoawX5vKAcMU55WZukOT8ECgyxofhn7u+maC8e7580Pcdrn95AGh8Sc7vk9Bhur1E8qgtVU
 tHCZ7zBLKiuxDXNfWEn8OjpvixY0kII+FEX0OSl9UxohBU6W7FTWsgPxRL5XYvsEzx5WMs0yRuL
 5eLy3tsEpL12C2TqXsw3tmZLbK5GmiM1aevR8ztpHSUwpABLs4WkfC9DMGZNcqBF5xqcr0YxGgv
 lyfqngNa16eyiKRNFI8GPFPTkJHV1jpbgPMvKYN3JnCI=
X-Google-Smtp-Source: AGHT+IFJbo9+sJVsXNNJ0MKnKQCGHQVNJpDWiaS+/P5ieZrTB3gKp4auvRfIAWaU7Qo/2tRoiBCV2Q==
X-Received: by 2002:a05:6a00:999:b0:748:e289:6bc with SMTP id
 d2e1a72fcca58-74ad4ad64cfmr3911742b3a.1.1750849149720; 
 Wed, 25 Jun 2025 03:59:09 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-749c882ceb3sm4147619b3a.76.2025.06.25.03.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 03:59:09 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH] target/arm: Fix M-profile helper loads/stores alignment checks
Date: Wed, 25 Jun 2025 20:28:32 +0930
Message-ID: <20250625105832.1277378-1-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Jun 2025 09:10:04 -0400
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

Historically, M-profile helper functions in m_helper.c and mve_helper.c
used the unaligned cpu_*_data_ra() routines to perform guest memory
accesses. This meant we had no way to enforce alignment constraints
when executing helper-based loads/stores. With the addition of the
cpu_*_mmu() APIs, we can now combine the current MMU state
(cpu_mmu_index(env, false)) with MO_ALIGN flags to build a MemOpIdx
that enforces alignment at the helper level.

This patch:
- Replaces all calls to cpu_ldl_data_ra(), cpu_ldst_data_ra(), etc.,
  in the M-profile helpers (m_helper.c) and the MVE helpers
  (mve_helper.c) with their cpu_*_mmu() equivalents.
- Leaves SME and SVE helper code untouched, as those extensions
  support unaligned accesses by design.
- Retains the manual alignment checks in the vlldm/vlstm helpers
  because those instructions enforce an 8-byte alignment requirement
  (instead of the 4-byte alignment for ordinary long loads/stores).
  References to cpu_*_data_* are still replaced with cpu_*_mmu(), so
  that the individual word accesses themselves also perform the standard
  alignment checks, in keeping with the ARM pseudocode.

With this change, all M-profile and MVE helper-based loads and stores
will now correctly honor their alignment requirements.

Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
---
 target/arm/tcg/m_helper.c   |  33 +--
 target/arm/tcg/mve_helper.c | 408 ++++++++++++++++++++----------------
 2 files changed, 254 insertions(+), 187 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832..28307b5615 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -632,8 +632,11 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     }
 
     /* Note that these stores can throw exceptions on MPU faults */
-    cpu_stl_data_ra(env, sp, nextinst, GETPC());
-    cpu_stl_data_ra(env, sp + 4, saved_psr, GETPC());
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
+    cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
+    cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
 
     env->regs[13] = sp;
     env->regs[14] = 0xfeffffff;
@@ -1048,6 +1051,9 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
 
@@ -1073,7 +1079,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
      * Note that we do not use v7m_stack_write() here, because the
      * accesses should not set the FSR bits for stacking errors if they
      * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
-     * or AccType_LAZYFP). Faults in cpu_stl_data_ra() will throw exceptions
+     * or AccType_LAZYFP). Faults in cpu_stl_mmu() will throw exceptions
      * and longjmp out.
      */
     if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
@@ -1089,12 +1095,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
             if (i >= 16) {
                 faddr += 8; /* skip the slot for the FPSCR */
             }
-            cpu_stl_data_ra(env, faddr, slo, ra);
-            cpu_stl_data_ra(env, faddr + 4, shi, ra);
+            cpu_stl_mmu(env, faddr, slo, oi, ra);
+            cpu_stl_mmu(env, faddr + 4, shi, oi, ra);
         }
-        cpu_stl_data_ra(env, fptr + 0x40, vfp_get_fpscr(env), ra);
+        cpu_stl_mmu(env, fptr + 0x40, vfp_get_fpscr(env), oi, ra);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            cpu_stl_data_ra(env, fptr + 0x44, env->v7m.vpr, ra);
+            cpu_stl_mmu(env, fptr + 0x44, env->v7m.vpr, oi, ra);
         }
 
         /*
@@ -1121,6 +1127,9 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 {
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
     assert(env->v7m.secure);
@@ -1155,16 +1164,16 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
                 faddr += 8; /* skip the slot for the FPSCR and VPR */
             }
 
-            slo = cpu_ldl_data_ra(env, faddr, ra);
-            shi = cpu_ldl_data_ra(env, faddr + 4, ra);
+            slo = cpu_ldl_mmu(env, faddr, oi, ra);
+            shi = cpu_ldl_mmu(env, faddr + 4, oi, ra);
 
             dn = (uint64_t) shi << 32 | slo;
             *aa32_vfp_dreg(env, i / 2) = dn;
         }
-        fpscr = cpu_ldl_data_ra(env, fptr + 0x40, ra);
+        fpscr = cpu_ldl_mmu(env, fptr + 0x40, oi, ra);
         vfp_set_fpscr(env, fpscr);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            env->v7m.vpr = cpu_ldl_data_ra(env, fptr + 0x44, ra);
+            env->v7m.vpr = cpu_ldl_mmu(env, fptr + 0x44, oi, ra);
         }
     }
 
@@ -1937,7 +1946,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
          * do them as secure, so work out what MMU index that is.
          */
         mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
-        oi = make_memop_idx(MO_LEUL, arm_to_core_mmu_idx(mmu_idx));
+        oi = make_memop_idx(MO_LEUL | MO_ALIGN, arm_to_core_mmu_idx(mmu_idx));
         newpc = cpu_ldl_mmu(env, frameptr, oi, 0);
         newpsr = cpu_ldl_mmu(env, frameptr + 4, oi, 0);
 
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 506d1c3475..2a4521e1fa 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -147,62 +147,85 @@ static void mve_advance_vpt(CPUARMState *env)
     env->v7m.vpr = vpr;
 }
 
+/* Mapping of LDTYPE/STTYPE to the number of bytes accessed */
+#define MSIZE_b 1
+#define MSIZE_w 2
+#define MSIZE_l 4
+
+/* Mapping of LDTYPE/STTYPE to MemOp flag */
+#define MFLAG_b MO_UB
+#define MFLAG_w MO_TEUW
+#define MFLAG_l MO_TEUL
+
+#define MSIZE(t)  MSIZE_##t
+#define MFLAG(t)  MFLAG_##t
+
+#define SIGN_EXT(v, T, B) \
+    ((T)(v) << (sizeof(T) * 8 - (B))) >> (sizeof(T) * 8 - (B))
+
 /* For loads, predicated lanes are zeroed instead of keeping their old values */
-#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned b, e;                                                  \
-        /*                                                              \
-         * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
-         * beats so we don't care if we update part of the dest and     \
-         * then take an exception.                                      \
-         */                                                             \
-        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
-            if (eci_mask & (1 << b)) {                                  \
-                d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
-                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;     \
-            }                                                           \
-            addr += MSIZE;                                              \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                               \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)          \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned b, e;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);      \
+        /*                                                                    \
+         * R_SXTM allows the dest reg to become UNKNOWN for abandoned         \
+         * beats so we don't care if we update part of the dest and           \
+         * then take an exception.                                            \
+         */                                                                   \
+        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                         \
+            if (eci_mask & (1 << b)) {                                        \
+                d[H##ESIZE(e)] = (mask & (1 << b)) ?                          \
+                    SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),    \
+                             TYPE,                                            \
+                             MSIZE * 8)                                       \
+                    : 0;                                                      \
+            }                                                                 \
+            addr += MSIZE;                                                    \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
-#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                         \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        unsigned b, e;                                                  \
-        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
-            if (mask & (1 << b)) {                                      \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
-            }                                                           \
-            addr += MSIZE;                                              \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                               \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)          \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        uint16_t mask = mve_element_mask(env);                                \
+        unsigned b, e;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);      \
+        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                         \
+            if (mask & (1 << b)) {                                            \
+                cpu_st##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
+            }                                                                 \
+            addr += MSIZE;                                                    \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
-DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
-DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
-DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
+DO_VLDR(vldrb, 1, b, 1, uint8_t)
+DO_VLDR(vldrh, 2, w, 2, uint16_t)
+DO_VLDR(vldrw, 4, l, 4, uint32_t)
 
-DO_VSTR(vstrb, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, 4, stl, 4, uint32_t)
+DO_VSTR(vstrb, 1, b, 1, uint8_t)
+DO_VSTR(vstrh, 2, w, 2, uint16_t)
+DO_VSTR(vstrw, 4, l, 4, uint32_t)
 
-DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
-DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
-DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
-DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
-DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
-DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
+DO_VLDR(vldrb_sh, 1, b, 2, int16_t)
+DO_VLDR(vldrb_sw, 1, b, 4, int32_t)
+DO_VLDR(vldrb_uh, 1, b, 2, uint16_t)
+DO_VLDR(vldrb_uw, 1, b, 4, uint32_t)
+DO_VLDR(vldrh_sw, 2, w, 4, int32_t)
+DO_VLDR(vldrh_uw, 2, w, 4, uint32_t)
 
-DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
-DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
+DO_VSTR(vstrb_h, 1, b, 2, int16_t)
+DO_VSTR(vstrb_w, 1, b, 4, int32_t)
+DO_VSTR(vstrh_w, 2, w, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
@@ -214,54 +237,61 @@ DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
  * For loads, predicated lanes are zeroed instead of retaining
  * their previous values.
  */
-#define DO_VLDR_SG(OP, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)        \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        OFFTYPE *m = vm;                                                \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
-            d[H##ESIZE(e)] = (mask & 1) ?                               \
-                cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;         \
-            if (WB) {                                                   \
-                m[H##ESIZE(e)] = addr;                                  \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VLDR_SG(OP, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)              \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        OFFTYPE *m = vm;                                                      \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);      \
+        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) {\
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H##ESIZE(e)]);                              \
+            d[H##ESIZE(e)] = (mask & 1) ?                                     \
+                SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),        \
+                         TYPE,                                                \
+                         MSIZE(LDTYPE) * 8)                                   \
+                : 0;                                                          \
+            if (WB) {                                                         \
+                m[H##ESIZE(e)] = addr;                                        \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 /* We know here TYPE is unsigned so always the same as the offset type */
-#define DO_VSTR_SG(OP, STTYPE, ESIZE, TYPE, ADDRFN, WB)                 \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        TYPE *m = vm;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
-            if (mask & 1) {                                             \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
-            }                                                           \
-            if (WB) {                                                   \
-                m[H##ESIZE(e)] = addr;                                  \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VSTR_SG(OP, STTYPE, ESIZE, TYPE, ADDRFN, WB)                       \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        TYPE *m = vm;                                                         \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);      \
+        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) {\
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H##ESIZE(e)]);                              \
+            if (mask & 1) {                                                   \
+                cpu_st##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
+            }                                                                 \
+            if (WB) {                                                         \
+                m[H##ESIZE(e)] = addr;                                        \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 /*
@@ -272,54 +302,58 @@ DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
  * Address writeback happens on the odd beats and updates the address
  * stored in the even-beat element.
  */
-#define DO_VLDR64_SG(OP, ADDRFN, WB)                                    \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        uint32_t *d = vd;                                               \
-        uint32_t *m = vm;                                               \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H4(e & ~1)]);                         \
-            addr += 4 * (e & 1);                                        \
-            d[H4(e)] = (mask & 1) ? cpu_ldl_data_ra(env, addr, GETPC()) : 0; \
-            if (WB && (e & 1)) {                                        \
-                m[H4(e & ~1)] = addr - 4;                               \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VLDR64_SG(OP, ADDRFN, WB)                                          \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        uint32_t *d = vd;                                                     \
+        uint32_t *m = vm;                                                     \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);            \
+        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {            \
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H4(e & ~1)]);                               \
+            addr += 4 * (e & 1);                                              \
+            d[H4(e)] = (mask & 1) ? cpu_ldl_mmu(env, addr, oi, GETPC()) : 0;  \
+            if (WB && (e & 1)) {                                              \
+                m[H4(e & ~1)] = addr - 4;                                     \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
-#define DO_VSTR64_SG(OP, ADDRFN, WB)                                    \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        uint32_t *d = vd;                                               \
-        uint32_t *m = vm;                                               \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H4(e & ~1)]);                         \
-            addr += 4 * (e & 1);                                        \
-            if (mask & 1) {                                             \
-                cpu_stl_data_ra(env, addr, d[H4(e)], GETPC());          \
-            }                                                           \
-            if (WB && (e & 1)) {                                        \
-                m[H4(e & ~1)] = addr - 4;                               \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VSTR64_SG(OP, ADDRFN, WB)                                          \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        uint32_t *d = vd;                                                     \
+        uint32_t *m = vm;                                                     \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);            \
+        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {            \
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H4(e & ~1)]);                               \
+            addr += 4 * (e & 1);                                              \
+            if (mask & 1) {                                                   \
+                cpu_stl_mmu(env, addr, d[H4(e)], oi, GETPC());                \
+            }                                                                 \
+            if (WB && (e & 1)) {                                              \
+                m[H4(e & ~1)] = addr - 4;                                     \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 #define ADDR_ADD(BASE, OFFSET) ((BASE) + (OFFSET))
@@ -327,40 +361,40 @@ DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
 #define ADDR_ADD_OSW(BASE, OFFSET) ((BASE) + ((OFFSET) << 2))
 #define ADDR_ADD_OSD(BASE, OFFSET) ((BASE) + ((OFFSET) << 3))
 
-DO_VLDR_SG(vldrb_sg_sh, ldsb, 2, int16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_sw, ldsb, 4, int32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_sw, ldsw, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_sh, b, 2, int16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_sw, b, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_sw, w, 4, int32_t, uint32_t, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrb_sg_ub, ldub, 1, uint8_t, uint8_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_uh, ldub, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_uw, ldub, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uh, lduw, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uw, lduw, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrw_sg_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_ub, b, 1, uint8_t, uint8_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_uh, b, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_uw, b, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uh, w, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uw, w, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrw_sg_uw, l, 4, uint32_t, uint32_t, ADDR_ADD, false)
 DO_VLDR64_SG(vldrd_sg_ud, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrh_sg_os_sw, ldsw, 4, int32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uh, lduw, 2, uint16_t, uint16_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uw, lduw, 4, uint32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrw_sg_os_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD_OSW, false)
+DO_VLDR_SG(vldrh_sg_os_sw, w, 4, int32_t, uint32_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrh_sg_os_uh, w, 2, uint16_t, uint16_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrh_sg_os_uw, w, 4, uint32_t, uint32_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrw_sg_os_uw, l, 4, uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VSTR_SG(vstrb_sg_ub, stb, 1, uint8_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrb_sg_uh, stb, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrb_sg_uw, stb, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uh, stw, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uw, stw, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrw_sg_uw, stl, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_ub, b, 1, uint8_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_uh, b, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_uw, b, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uh, w, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uw, w, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrw_sg_uw, l, 4, uint32_t, ADDR_ADD, false)
 DO_VSTR64_SG(vstrd_sg_ud, ADDR_ADD, false)
 
-DO_VSTR_SG(vstrh_sg_os_uh, stw, 2, uint16_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrh_sg_os_uw, stw, 4, uint32_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrw_sg_os_uw, stl, 4, uint32_t, ADDR_ADD_OSW, false)
+DO_VSTR_SG(vstrh_sg_os_uh, w, 2, uint16_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrh_sg_os_uw, w, 4, uint32_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrw_sg_os_uw, l, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VLDR_SG(vldrw_sg_wb_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
+DO_VLDR_SG(vldrw_sg_wb_uw, l, 4, uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
-DO_VSTR_SG(vstrw_sg_wb_uw, stl, 4, uint32_t, ADDR_ADD, true)
+DO_VSTR_SG(vstrw_sg_wb_uw, l, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
 
 /*
@@ -387,13 +421,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 4; e++, data >>= 8) {                       \
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 qd[H1(off[beat])] = data;                               \
@@ -411,13 +447,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 8 + (beat & 1) * 4;               \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y);             \
             qd[H2(off[beat])] = data;                                   \
             data >>= 16;                                                \
@@ -436,13 +474,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             qd[H4(off[beat] >> 2)] = data;                              \
@@ -473,13 +513,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 2;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 4; e++, data >>= 8) {                       \
                 qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + (e & 1));    \
                 qd[H1(off[beat] + (e >> 1))] = data;                    \
@@ -497,13 +539,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         int e;                                                          \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 2; e++, data >>= 16) {                      \
                 qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + e);         \
                 qd[H2(off[beat])] = data;                               \
@@ -520,13 +564,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat];                                    \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + (beat & 1));    \
             qd[H4(off[beat] >> 3)] = data;                              \
         }                                                               \
@@ -549,6 +595,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -560,7 +608,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 data = (data << 8) | qd[H1(off[beat])];                 \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -574,6 +622,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -584,7 +634,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             data = qd[H2(off[beat])];                                   \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y + 1);         \
             data |= qd[H2(off[beat])] << 16;                            \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -598,6 +648,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -607,7 +659,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             data = qd[H4(off[beat] >> 2)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -635,6 +687,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -646,7 +700,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
                 qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + (e & 1));    \
                 data = (data << 8) | qd[H1(off[beat] + (e >> 1))];      \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -660,6 +714,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         int e;                                                          \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -671,7 +727,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
                 qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + e);         \
                 data = (data << 16) | qd[H2(off[beat])];                \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -684,6 +740,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -692,7 +750,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
             addr = base + off[beat];                                    \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + (beat & 1));    \
             data = qd[H4(off[beat] >> 3)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
-- 
2.48.1


