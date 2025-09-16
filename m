Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DEACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4y-0003Ak-Kd; Tue, 16 Sep 2025 14:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4b-00037R-6r
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4W-0001bi-H5
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45f2fa8a1adso1013315e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045991; x=1758650791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OPr92eDOEYUyH7jSutoU+e2bdRZrMlDHsVBsG8Qmdwc=;
 b=cmpqAyXQmx2HlTqQ1z1rxYTxFa89k75JM31iYBvptVWXjCI04hlIWzqcdrqpJLJsrz
 RxlgndPHK+/ptDoRsHOOe18g9sfWgi9borIpwXvOeb9rmsZ7PiSNlw0Wom+AwBQ1/nbT
 qJIfOSDMopIJ6+VwtkcaHDLXSaJrYEi0CAblmtEEIewU44/pDcVugQ0ypU2zekgU3zN7
 Ml/P39x3cyH/L3P9xSHDSlXqcUDzNOlLLFA3dEMl6XyQUeMRTsaSFjqzYmfCvgUOPk48
 fnsSwDwE95bzzjQQAQaeZ7hgZjisFhDVKX6KYCO8IvrSPwch8++Cu6IL13Mr3WT8zdyI
 i1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045991; x=1758650791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPr92eDOEYUyH7jSutoU+e2bdRZrMlDHsVBsG8Qmdwc=;
 b=GilvhjcLxA+dl126koVIx9eDAV75hZdkh7h3chKCXSgldQO/9BHyr3VTS1hX9ANo9+
 tUexssmdW/CDYfXv7e7mOR5ws+D96e2v5zMId68NzOS191usaJ6Mu1+xN6jtncKaK2eK
 /Cj99DTcpa2HuhyFic0x0pO2Bcw1y3QJ8XSqhHy3a0wz6uBwLhnUv2PjQg2/9djK3L+V
 k+IWv5DKqUcVtJfuXPxAZNuV6Owofud23Nu610JMbZWt9usIc54sVvPIpgA515QPEIuz
 eR1JY95qOBByoxt4svWjiNbaDPJEllTUp7xxnzSPsWFwC6Ob93IcfXoDeqoehdONKI85
 x5Jw==
X-Gm-Message-State: AOJu0Yy0mvUWdWy/bmtdtg8PfW3FEwtQbtd6U1FmMhvrV0SR2Aaj+r8n
 TCXNY2lN8PjYC8ztou2ij8LiquWALpuvb3EJUdU0AYty0/ePavp6x2N7fYDDMdhIsuUI6XdwJ6J
 qUvJp
X-Gm-Gg: ASbGnct6XBPJ3RYO0RavXm6e0scjM7nGQB0XqcSjjhbDUE65NDmuQvWjG36X6Dt9q9h
 WAxibIqItfVJLapMMvGTss0FDYFdrdmMCu6WgfvJX/oNpRRwpZYUUlyk5nhuwyUEfmdveSxYvQr
 DY1utEkyVgaLEJWZgmjqyo/kDq//LUo2GBN46Rz0zuHsMgvesETc4NVDgUiV1a77dfMpQ8OX3w9
 X9AdUmMZ6CKNggRq5R+IrHHVf1j6qBzLY8xF+Lf5jYZug3LN9iIijB4aygpq5ARyXIKbQT6N5Qp
 Hgu8GKsl0EvCivw/QhjVigrwHaPM/ghZuatu53tWj5bLNSBKmO2EIiH6DrEsENfvykMuBRDpXQW
 R7Z3jxPLmMDB9JZY6dDrGZ0p0ToUR
X-Google-Smtp-Source: AGHT+IF2/Ai+Ve+d96SBMBa7xQgBKR+nlXJ5SlKQesy3DKNeryBbYvlutqMly2qnVBpvBQJxpTZWdQ==
X-Received: by 2002:a05:600c:840f:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-45f32d173d5mr37929255e9.6.1758045990396; 
 Tue, 16 Sep 2025 11:06:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] target/arm: Remove XScale and iWMMXt translate.c code
Date: Tue, 16 Sep 2025 19:05:50 +0100
Message-ID: <20250916180611.1481266-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Remove all the translator code that is accessible only via
ARM_FEATURE_XSCALE or ARM_FEATURE_IWMMXT.  This includes the
xscale-only cp15_cpar TB flags and cpu_{V0,V1,M0} TCG temps.

The no-longer-used helper functions will be removed in a separate
commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250828140422.3271703-3-peter.maydell@linaro.org
---
 target/arm/cpu.h           |    7 -
 target/arm/tcg/translate.h |    2 -
 target/arm/tcg/hflags.c    |   13 +-
 target/arm/tcg/translate.c | 1324 +-----------------------------------
 4 files changed, 7 insertions(+), 1339 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c15d79a106b..f56fa6df8dd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3025,13 +3025,6 @@ FIELD(TBFLAG_AM32, THUMB, 23, 1)         /* Not cached. */
  */
 FIELD(TBFLAG_A32, VECLEN, 0, 3)         /* Not cached. */
 FIELD(TBFLAG_A32, VECSTRIDE, 3, 2)     /* Not cached. */
-/*
- * We store the bottom two bits of the CPAR as TB flags and handle
- * checks on the other bits at runtime. This shares the same bits as
- * VECSTRIDE, which is OK as no XScale CPU has VFP.
- * Not cached, because VECLEN+VECSTRIDE are not cached.
- */
-FIELD(TBFLAG_A32, XSCALE_CPAR, 5, 2)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)         /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, SCTLR__B, 8, 1)      /* Cannot overlap with SCTLR_B */
 FIELD(TBFLAG_A32, HSTR_ACTIVE, 9, 1)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f974996f3f8..ec4755ae3fd 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -175,8 +175,6 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
-    /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
-    int c15_cpar;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 59ab5263753..01894226cc9 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -624,16 +624,9 @@ TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs)
                 DP_TBFLAG_M32(flags, MVE_NO_PRED, 1);
             }
         } else {
-            /*
-             * Note that XSCALE_CPAR shares bits with VECSTRIDE.
-             * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
-             */
-            if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-                DP_TBFLAG_A32(flags, XSCALE_CPAR, env->cp15.c15_cpar);
-            } else {
-                DP_TBFLAG_A32(flags, VECLEN, env->vfp.vec_len);
-                DP_TBFLAG_A32(flags, VECSTRIDE, env->vfp.vec_stride);
-            }
+            /* Note that VECLEN+VECSTRIDE are RES0 for M-profile. */
+            DP_TBFLAG_A32(flags, VECLEN, env->vfp.vec_len);
+            DP_TBFLAG_A32(flags, VECSTRIDE, env->vfp.vec_stride);
             if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
                 DP_TBFLAG_A32(flags, VFPEN, 1);
             }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f7d6d8ce196..e62dcc5d85d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -44,8 +44,6 @@
 #define ENABLE_ARCH_7     arm_dc_feature(s, ARM_FEATURE_V7)
 #define ENABLE_ARCH_8     arm_dc_feature(s, ARM_FEATURE_V8)
 
-/* These are TCG temporaries used only by the legacy iwMMXt decoder */
-static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
 /* These are TCG globals which alias CPUARMState fields */
 static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
@@ -1252,1263 +1250,6 @@ void write_neon_element64(TCGv_i64 src, int reg, int ele, MemOp memop)
     }
 }
 
-#define ARM_CP_RW_BIT   (1 << 20)
-
-static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
-{
-    tcg_gen_ld_i64(var, tcg_env, offsetof(CPUARMState, iwmmxt.regs[reg]));
-}
-
-static inline void iwmmxt_store_reg(TCGv_i64 var, int reg)
-{
-    tcg_gen_st_i64(var, tcg_env, offsetof(CPUARMState, iwmmxt.regs[reg]));
-}
-
-static inline TCGv_i32 iwmmxt_load_creg(int reg)
-{
-    TCGv_i32 var = tcg_temp_new_i32();
-    tcg_gen_ld_i32(var, tcg_env, offsetof(CPUARMState, iwmmxt.cregs[reg]));
-    return var;
-}
-
-static inline void iwmmxt_store_creg(int reg, TCGv_i32 var)
-{
-    tcg_gen_st_i32(var, tcg_env, offsetof(CPUARMState, iwmmxt.cregs[reg]));
-}
-
-static inline void gen_op_iwmmxt_movq_wRn_M0(int rn)
-{
-    iwmmxt_store_reg(cpu_M0, rn);
-}
-
-static inline void gen_op_iwmmxt_movq_M0_wRn(int rn)
-{
-    iwmmxt_load_reg(cpu_M0, rn);
-}
-
-static inline void gen_op_iwmmxt_orq_M0_wRn(int rn)
-{
-    iwmmxt_load_reg(cpu_V1, rn);
-    tcg_gen_or_i64(cpu_M0, cpu_M0, cpu_V1);
-}
-
-static inline void gen_op_iwmmxt_andq_M0_wRn(int rn)
-{
-    iwmmxt_load_reg(cpu_V1, rn);
-    tcg_gen_and_i64(cpu_M0, cpu_M0, cpu_V1);
-}
-
-static inline void gen_op_iwmmxt_xorq_M0_wRn(int rn)
-{
-    iwmmxt_load_reg(cpu_V1, rn);
-    tcg_gen_xor_i64(cpu_M0, cpu_M0, cpu_V1);
-}
-
-#define IWMMXT_OP(name) \
-static inline void gen_op_iwmmxt_##name##_M0_wRn(int rn) \
-{ \
-    iwmmxt_load_reg(cpu_V1, rn); \
-    gen_helper_iwmmxt_##name(cpu_M0, cpu_M0, cpu_V1); \
-}
-
-#define IWMMXT_OP_ENV(name) \
-static inline void gen_op_iwmmxt_##name##_M0_wRn(int rn) \
-{ \
-    iwmmxt_load_reg(cpu_V1, rn); \
-    gen_helper_iwmmxt_##name(cpu_M0, tcg_env, cpu_M0, cpu_V1); \
-}
-
-#define IWMMXT_OP_ENV_SIZE(name) \
-IWMMXT_OP_ENV(name##b) \
-IWMMXT_OP_ENV(name##w) \
-IWMMXT_OP_ENV(name##l)
-
-#define IWMMXT_OP_ENV1(name) \
-static inline void gen_op_iwmmxt_##name##_M0(void) \
-{ \
-    gen_helper_iwmmxt_##name(cpu_M0, tcg_env, cpu_M0); \
-}
-
-IWMMXT_OP(maddsq)
-IWMMXT_OP(madduq)
-IWMMXT_OP(sadb)
-IWMMXT_OP(sadw)
-IWMMXT_OP(mulslw)
-IWMMXT_OP(mulshw)
-IWMMXT_OP(mululw)
-IWMMXT_OP(muluhw)
-IWMMXT_OP(macsw)
-IWMMXT_OP(macuw)
-
-IWMMXT_OP_ENV_SIZE(unpackl)
-IWMMXT_OP_ENV_SIZE(unpackh)
-
-IWMMXT_OP_ENV1(unpacklub)
-IWMMXT_OP_ENV1(unpackluw)
-IWMMXT_OP_ENV1(unpacklul)
-IWMMXT_OP_ENV1(unpackhub)
-IWMMXT_OP_ENV1(unpackhuw)
-IWMMXT_OP_ENV1(unpackhul)
-IWMMXT_OP_ENV1(unpacklsb)
-IWMMXT_OP_ENV1(unpacklsw)
-IWMMXT_OP_ENV1(unpacklsl)
-IWMMXT_OP_ENV1(unpackhsb)
-IWMMXT_OP_ENV1(unpackhsw)
-IWMMXT_OP_ENV1(unpackhsl)
-
-IWMMXT_OP_ENV_SIZE(cmpeq)
-IWMMXT_OP_ENV_SIZE(cmpgtu)
-IWMMXT_OP_ENV_SIZE(cmpgts)
-
-IWMMXT_OP_ENV_SIZE(mins)
-IWMMXT_OP_ENV_SIZE(minu)
-IWMMXT_OP_ENV_SIZE(maxs)
-IWMMXT_OP_ENV_SIZE(maxu)
-
-IWMMXT_OP_ENV_SIZE(subn)
-IWMMXT_OP_ENV_SIZE(addn)
-IWMMXT_OP_ENV_SIZE(subu)
-IWMMXT_OP_ENV_SIZE(addu)
-IWMMXT_OP_ENV_SIZE(subs)
-IWMMXT_OP_ENV_SIZE(adds)
-
-IWMMXT_OP_ENV(avgb0)
-IWMMXT_OP_ENV(avgb1)
-IWMMXT_OP_ENV(avgw0)
-IWMMXT_OP_ENV(avgw1)
-
-IWMMXT_OP_ENV(packuw)
-IWMMXT_OP_ENV(packul)
-IWMMXT_OP_ENV(packuq)
-IWMMXT_OP_ENV(packsw)
-IWMMXT_OP_ENV(packsl)
-IWMMXT_OP_ENV(packsq)
-
-static void gen_op_iwmmxt_set_mup(void)
-{
-    TCGv_i32 tmp;
-    tmp = load_cpu_field(iwmmxt.cregs[ARM_IWMMXT_wCon]);
-    tcg_gen_ori_i32(tmp, tmp, 2);
-    store_cpu_field(tmp, iwmmxt.cregs[ARM_IWMMXT_wCon]);
-}
-
-static void gen_op_iwmmxt_set_cup(void)
-{
-    TCGv_i32 tmp;
-    tmp = load_cpu_field(iwmmxt.cregs[ARM_IWMMXT_wCon]);
-    tcg_gen_ori_i32(tmp, tmp, 1);
-    store_cpu_field(tmp, iwmmxt.cregs[ARM_IWMMXT_wCon]);
-}
-
-static void gen_op_iwmmxt_setpsr_nz(void)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_iwmmxt_setpsr_nz(tmp, cpu_M0);
-    store_cpu_field(tmp, iwmmxt.cregs[ARM_IWMMXT_wCASF]);
-}
-
-static inline void gen_op_iwmmxt_addl_M0_wRn(int rn)
-{
-    iwmmxt_load_reg(cpu_V1, rn);
-    tcg_gen_ext32u_i64(cpu_V1, cpu_V1);
-    tcg_gen_add_i64(cpu_M0, cpu_M0, cpu_V1);
-}
-
-static inline int gen_iwmmxt_address(DisasContext *s, uint32_t insn,
-                                     TCGv_i32 dest)
-{
-    int rd;
-    uint32_t offset;
-    TCGv_i32 tmp;
-
-    rd = (insn >> 16) & 0xf;
-    tmp = load_reg(s, rd);
-
-    offset = (insn & 0xff) << ((insn >> 7) & 2);
-    if (insn & (1 << 24)) {
-        /* Pre indexed */
-        if (insn & (1 << 23))
-            tcg_gen_addi_i32(tmp, tmp, offset);
-        else
-            tcg_gen_addi_i32(tmp, tmp, -offset);
-        tcg_gen_mov_i32(dest, tmp);
-        if (insn & (1 << 21)) {
-            store_reg(s, rd, tmp);
-        }
-    } else if (insn & (1 << 21)) {
-        /* Post indexed */
-        tcg_gen_mov_i32(dest, tmp);
-        if (insn & (1 << 23))
-            tcg_gen_addi_i32(tmp, tmp, offset);
-        else
-            tcg_gen_addi_i32(tmp, tmp, -offset);
-        store_reg(s, rd, tmp);
-    } else if (!(insn & (1 << 23)))
-        return 1;
-    return 0;
-}
-
-static inline int gen_iwmmxt_shift(uint32_t insn, uint32_t mask, TCGv_i32 dest)
-{
-    int rd = (insn >> 0) & 0xf;
-    TCGv_i32 tmp;
-
-    if (insn & (1 << 8)) {
-        if (rd < ARM_IWMMXT_wCGR0 || rd > ARM_IWMMXT_wCGR3) {
-            return 1;
-        } else {
-            tmp = iwmmxt_load_creg(rd);
-        }
-    } else {
-        tmp = tcg_temp_new_i32();
-        iwmmxt_load_reg(cpu_V0, rd);
-        tcg_gen_extrl_i64_i32(tmp, cpu_V0);
-    }
-    tcg_gen_andi_i32(tmp, tmp, mask);
-    tcg_gen_mov_i32(dest, tmp);
-    return 0;
-}
-
-/* Disassemble an iwMMXt instruction.  Returns nonzero if an error occurred
-   (ie. an undefined instruction).  */
-static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
-{
-    int rd, wrd;
-    int rdhi, rdlo, rd0, rd1, i;
-    TCGv_i32 addr;
-    TCGv_i32 tmp, tmp2, tmp3;
-
-    if ((insn & 0x0e000e00) == 0x0c000000) {
-        if ((insn & 0x0fe00ff0) == 0x0c400000) {
-            wrd = insn & 0xf;
-            rdlo = (insn >> 12) & 0xf;
-            rdhi = (insn >> 16) & 0xf;
-            if (insn & ARM_CP_RW_BIT) {                         /* TMRRC */
-                iwmmxt_load_reg(cpu_V0, wrd);
-                tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
-                tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
-            } else {                                    /* TMCRR */
-                tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
-                iwmmxt_store_reg(cpu_V0, wrd);
-                gen_op_iwmmxt_set_mup();
-            }
-            return 0;
-        }
-
-        wrd = (insn >> 12) & 0xf;
-        addr = tcg_temp_new_i32();
-        if (gen_iwmmxt_address(s, insn, addr)) {
-            return 1;
-        }
-        if (insn & ARM_CP_RW_BIT) {
-            if ((insn >> 28) == 0xf) {                  /* WLDRW wCx */
-                tmp = tcg_temp_new_i32();
-                gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                iwmmxt_store_creg(wrd, tmp);
-            } else {
-                i = 1;
-                if (insn & (1 << 8)) {
-                    if (insn & (1 << 22)) {             /* WLDRD */
-                        gen_aa32_ld64(s, cpu_M0, addr, get_mem_index(s));
-                        i = 0;
-                    } else {                            /* WLDRW wRd */
-                        tmp = tcg_temp_new_i32();
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    }
-                } else {
-                    tmp = tcg_temp_new_i32();
-                    if (insn & (1 << 22)) {             /* WLDRH */
-                        gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                    } else {                            /* WLDRB */
-                        gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-                    }
-                }
-                if (i) {
-                    tcg_gen_extu_i32_i64(cpu_M0, tmp);
-                }
-                gen_op_iwmmxt_movq_wRn_M0(wrd);
-            }
-        } else {
-            if ((insn >> 28) == 0xf) {                  /* WSTRW wCx */
-                tmp = iwmmxt_load_creg(wrd);
-                gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-            } else {
-                gen_op_iwmmxt_movq_M0_wRn(wrd);
-                tmp = tcg_temp_new_i32();
-                if (insn & (1 << 8)) {
-                    if (insn & (1 << 22)) {             /* WSTRD */
-                        gen_aa32_st64(s, cpu_M0, addr, get_mem_index(s));
-                    } else {                            /* WSTRW wRd */
-                        tcg_gen_extrl_i64_i32(tmp, cpu_M0);
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    }
-                } else {
-                    if (insn & (1 << 22)) {             /* WSTRH */
-                        tcg_gen_extrl_i64_i32(tmp, cpu_M0);
-                        gen_aa32_st16(s, tmp, addr, get_mem_index(s));
-                    } else {                            /* WSTRB */
-                        tcg_gen_extrl_i64_i32(tmp, cpu_M0);
-                        gen_aa32_st8(s, tmp, addr, get_mem_index(s));
-                    }
-                }
-            }
-        }
-        return 0;
-    }
-
-    if ((insn & 0x0f000000) != 0x0e000000)
-        return 1;
-
-    switch (((insn >> 12) & 0xf00) | ((insn >> 4) & 0xff)) {
-    case 0x000:                                                 /* WOR */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 0) & 0xf;
-        rd1 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        gen_op_iwmmxt_orq_M0_wRn(rd1);
-        gen_op_iwmmxt_setpsr_nz();
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x011:                                                 /* TMCR */
-        if (insn & 0xf)
-            return 1;
-        rd = (insn >> 12) & 0xf;
-        wrd = (insn >> 16) & 0xf;
-        switch (wrd) {
-        case ARM_IWMMXT_wCID:
-        case ARM_IWMMXT_wCASF:
-            break;
-        case ARM_IWMMXT_wCon:
-            gen_op_iwmmxt_set_cup();
-            /* Fall through.  */
-        case ARM_IWMMXT_wCSSF:
-            tmp = iwmmxt_load_creg(wrd);
-            tmp2 = load_reg(s, rd);
-            tcg_gen_andc_i32(tmp, tmp, tmp2);
-            iwmmxt_store_creg(wrd, tmp);
-            break;
-        case ARM_IWMMXT_wCGR0:
-        case ARM_IWMMXT_wCGR1:
-        case ARM_IWMMXT_wCGR2:
-        case ARM_IWMMXT_wCGR3:
-            gen_op_iwmmxt_set_cup();
-            tmp = load_reg(s, rd);
-            iwmmxt_store_creg(wrd, tmp);
-            break;
-        default:
-            return 1;
-        }
-        break;
-    case 0x100:                                                 /* WXOR */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 0) & 0xf;
-        rd1 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        gen_op_iwmmxt_xorq_M0_wRn(rd1);
-        gen_op_iwmmxt_setpsr_nz();
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x111:                                                 /* TMRC */
-        if (insn & 0xf)
-            return 1;
-        rd = (insn >> 12) & 0xf;
-        wrd = (insn >> 16) & 0xf;
-        tmp = iwmmxt_load_creg(wrd);
-        store_reg(s, rd, tmp);
-        break;
-    case 0x300:                                                 /* WANDN */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 0) & 0xf;
-        rd1 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tcg_gen_neg_i64(cpu_M0, cpu_M0);
-        gen_op_iwmmxt_andq_M0_wRn(rd1);
-        gen_op_iwmmxt_setpsr_nz();
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x200:                                                 /* WAND */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 0) & 0xf;
-        rd1 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        gen_op_iwmmxt_andq_M0_wRn(rd1);
-        gen_op_iwmmxt_setpsr_nz();
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x810: case 0xa10:                             /* WMADD */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 0) & 0xf;
-        rd1 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 21))
-            gen_op_iwmmxt_maddsq_M0_wRn(rd1);
-        else
-            gen_op_iwmmxt_madduq_M0_wRn(rd1);
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x10e: case 0x50e: case 0x90e: case 0xd0e:     /* WUNPCKIL */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            gen_op_iwmmxt_unpacklb_M0_wRn(rd1);
-            break;
-        case 1:
-            gen_op_iwmmxt_unpacklw_M0_wRn(rd1);
-            break;
-        case 2:
-            gen_op_iwmmxt_unpackll_M0_wRn(rd1);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x10c: case 0x50c: case 0x90c: case 0xd0c:     /* WUNPCKIH */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            gen_op_iwmmxt_unpackhb_M0_wRn(rd1);
-            break;
-        case 1:
-            gen_op_iwmmxt_unpackhw_M0_wRn(rd1);
-            break;
-        case 2:
-            gen_op_iwmmxt_unpackhl_M0_wRn(rd1);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x012: case 0x112: case 0x412: case 0x512:     /* WSAD */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 22))
-            gen_op_iwmmxt_sadw_M0_wRn(rd1);
-        else
-            gen_op_iwmmxt_sadb_M0_wRn(rd1);
-        if (!(insn & (1 << 20)))
-            gen_op_iwmmxt_addl_M0_wRn(wrd);
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x010: case 0x110: case 0x210: case 0x310:     /* WMUL */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 21)) {
-            if (insn & (1 << 20))
-                gen_op_iwmmxt_mulshw_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_mulslw_M0_wRn(rd1);
-        } else {
-            if (insn & (1 << 20))
-                gen_op_iwmmxt_muluhw_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_mululw_M0_wRn(rd1);
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x410: case 0x510: case 0x610: case 0x710:     /* WMAC */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 21))
-            gen_op_iwmmxt_macsw_M0_wRn(rd1);
-        else
-            gen_op_iwmmxt_macuw_M0_wRn(rd1);
-        if (!(insn & (1 << 20))) {
-            iwmmxt_load_reg(cpu_V1, wrd);
-            tcg_gen_add_i64(cpu_M0, cpu_M0, cpu_V1);
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x006: case 0x406: case 0x806: case 0xc06:     /* WCMPEQ */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            gen_op_iwmmxt_cmpeqb_M0_wRn(rd1);
-            break;
-        case 1:
-            gen_op_iwmmxt_cmpeqw_M0_wRn(rd1);
-            break;
-        case 2:
-            gen_op_iwmmxt_cmpeql_M0_wRn(rd1);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x800: case 0x900: case 0xc00: case 0xd00:     /* WAVG2 */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 22)) {
-            if (insn & (1 << 20))
-                gen_op_iwmmxt_avgw1_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_avgw0_M0_wRn(rd1);
-        } else {
-            if (insn & (1 << 20))
-                gen_op_iwmmxt_avgb1_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_avgb0_M0_wRn(rd1);
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x802: case 0x902: case 0xa02: case 0xb02:     /* WALIGNR */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = iwmmxt_load_creg(ARM_IWMMXT_wCGR0 + ((insn >> 20) & 3));
-        tcg_gen_andi_i32(tmp, tmp, 7);
-        iwmmxt_load_reg(cpu_V1, rd1);
-        gen_helper_iwmmxt_align(cpu_M0, cpu_M0, cpu_V1, tmp);
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x601: case 0x605: case 0x609: case 0x60d:     /* TINSR */
-        if (((insn >> 6) & 3) == 3)
-            return 1;
-        rd = (insn >> 12) & 0xf;
-        wrd = (insn >> 16) & 0xf;
-        tmp = load_reg(s, rd);
-        gen_op_iwmmxt_movq_M0_wRn(wrd);
-        switch ((insn >> 6) & 3) {
-        case 0:
-            tmp2 = tcg_constant_i32(0xff);
-            tmp3 = tcg_constant_i32((insn & 7) << 3);
-            break;
-        case 1:
-            tmp2 = tcg_constant_i32(0xffff);
-            tmp3 = tcg_constant_i32((insn & 3) << 4);
-            break;
-        case 2:
-            tmp2 = tcg_constant_i32(0xffffffff);
-            tmp3 = tcg_constant_i32((insn & 1) << 5);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        gen_helper_iwmmxt_insr(cpu_M0, cpu_M0, tmp, tmp2, tmp3);
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x107: case 0x507: case 0x907: case 0xd07:     /* TEXTRM */
-        rd = (insn >> 12) & 0xf;
-        wrd = (insn >> 16) & 0xf;
-        if (rd == 15 || ((insn >> 22) & 3) == 3)
-            return 1;
-        gen_op_iwmmxt_movq_M0_wRn(wrd);
-        tmp = tcg_temp_new_i32();
-        switch ((insn >> 22) & 3) {
-        case 0:
-            tcg_gen_shri_i64(cpu_M0, cpu_M0, (insn & 7) << 3);
-            tcg_gen_extrl_i64_i32(tmp, cpu_M0);
-            if (insn & 8) {
-                tcg_gen_ext8s_i32(tmp, tmp);
-            } else {
-                tcg_gen_andi_i32(tmp, tmp, 0xff);
-            }
-            break;
-        case 1:
-            tcg_gen_shri_i64(cpu_M0, cpu_M0, (insn & 3) << 4);
-            tcg_gen_extrl_i64_i32(tmp, cpu_M0);
-            if (insn & 8) {
-                tcg_gen_ext16s_i32(tmp, tmp);
-            } else {
-                tcg_gen_andi_i32(tmp, tmp, 0xffff);
-            }
-            break;
-        case 2:
-            tcg_gen_shri_i64(cpu_M0, cpu_M0, (insn & 1) << 5);
-            tcg_gen_extrl_i64_i32(tmp, cpu_M0);
-            break;
-        }
-        store_reg(s, rd, tmp);
-        break;
-    case 0x117: case 0x517: case 0x917: case 0xd17:     /* TEXTRC */
-        if ((insn & 0x000ff008) != 0x0003f000 || ((insn >> 22) & 3) == 3)
-            return 1;
-        tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            tcg_gen_shri_i32(tmp, tmp, ((insn & 7) << 2) + 0);
-            break;
-        case 1:
-            tcg_gen_shri_i32(tmp, tmp, ((insn & 3) << 3) + 4);
-            break;
-        case 2:
-            tcg_gen_shri_i32(tmp, tmp, ((insn & 1) << 4) + 12);
-            break;
-        }
-        tcg_gen_shli_i32(tmp, tmp, 28);
-        gen_set_nzcv(tmp);
-        break;
-    case 0x401: case 0x405: case 0x409: case 0x40d:     /* TBCST */
-        if (((insn >> 6) & 3) == 3)
-            return 1;
-        rd = (insn >> 12) & 0xf;
-        wrd = (insn >> 16) & 0xf;
-        tmp = load_reg(s, rd);
-        switch ((insn >> 6) & 3) {
-        case 0:
-            gen_helper_iwmmxt_bcstb(cpu_M0, tmp);
-            break;
-        case 1:
-            gen_helper_iwmmxt_bcstw(cpu_M0, tmp);
-            break;
-        case 2:
-            gen_helper_iwmmxt_bcstl(cpu_M0, tmp);
-            break;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x113: case 0x513: case 0x913: case 0xd13:     /* TANDC */
-        if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
-            return 1;
-        tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
-        tmp2 = tcg_temp_new_i32();
-        tcg_gen_mov_i32(tmp2, tmp);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            for (i = 0; i < 7; i ++) {
-                tcg_gen_shli_i32(tmp2, tmp2, 4);
-                tcg_gen_and_i32(tmp, tmp, tmp2);
-            }
-            break;
-        case 1:
-            for (i = 0; i < 3; i ++) {
-                tcg_gen_shli_i32(tmp2, tmp2, 8);
-                tcg_gen_and_i32(tmp, tmp, tmp2);
-            }
-            break;
-        case 2:
-            tcg_gen_shli_i32(tmp2, tmp2, 16);
-            tcg_gen_and_i32(tmp, tmp, tmp2);
-            break;
-        }
-        gen_set_nzcv(tmp);
-        break;
-    case 0x01c: case 0x41c: case 0x81c: case 0xc1c:     /* WACC */
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            gen_helper_iwmmxt_addcb(cpu_M0, cpu_M0);
-            break;
-        case 1:
-            gen_helper_iwmmxt_addcw(cpu_M0, cpu_M0);
-            break;
-        case 2:
-            gen_helper_iwmmxt_addcl(cpu_M0, cpu_M0);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x115: case 0x515: case 0x915: case 0xd15:     /* TORC */
-        if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
-            return 1;
-        tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
-        tmp2 = tcg_temp_new_i32();
-        tcg_gen_mov_i32(tmp2, tmp);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            for (i = 0; i < 7; i ++) {
-                tcg_gen_shli_i32(tmp2, tmp2, 4);
-                tcg_gen_or_i32(tmp, tmp, tmp2);
-            }
-            break;
-        case 1:
-            for (i = 0; i < 3; i ++) {
-                tcg_gen_shli_i32(tmp2, tmp2, 8);
-                tcg_gen_or_i32(tmp, tmp, tmp2);
-            }
-            break;
-        case 2:
-            tcg_gen_shli_i32(tmp2, tmp2, 16);
-            tcg_gen_or_i32(tmp, tmp, tmp2);
-            break;
-        }
-        gen_set_nzcv(tmp);
-        break;
-    case 0x103: case 0x503: case 0x903: case 0xd03:     /* TMOVMSK */
-        rd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        if ((insn & 0xf) != 0 || ((insn >> 22) & 3) == 3)
-            return 1;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = tcg_temp_new_i32();
-        switch ((insn >> 22) & 3) {
-        case 0:
-            gen_helper_iwmmxt_msbb(tmp, cpu_M0);
-            break;
-        case 1:
-            gen_helper_iwmmxt_msbw(tmp, cpu_M0);
-            break;
-        case 2:
-            gen_helper_iwmmxt_msbl(tmp, cpu_M0);
-            break;
-        }
-        store_reg(s, rd, tmp);
-        break;
-    case 0x106: case 0x306: case 0x506: case 0x706:     /* WCMPGT */
-    case 0x906: case 0xb06: case 0xd06: case 0xf06:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_cmpgtsb_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_cmpgtub_M0_wRn(rd1);
-            break;
-        case 1:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_cmpgtsw_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_cmpgtuw_M0_wRn(rd1);
-            break;
-        case 2:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_cmpgtsl_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_cmpgtul_M0_wRn(rd1);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x00e: case 0x20e: case 0x40e: case 0x60e:     /* WUNPCKEL */
-    case 0x80e: case 0xa0e: case 0xc0e: case 0xe0e:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_unpacklsb_M0();
-            else
-                gen_op_iwmmxt_unpacklub_M0();
-            break;
-        case 1:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_unpacklsw_M0();
-            else
-                gen_op_iwmmxt_unpackluw_M0();
-            break;
-        case 2:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_unpacklsl_M0();
-            else
-                gen_op_iwmmxt_unpacklul_M0();
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x00c: case 0x20c: case 0x40c: case 0x60c:     /* WUNPCKEH */
-    case 0x80c: case 0xa0c: case 0xc0c: case 0xe0c:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_unpackhsb_M0();
-            else
-                gen_op_iwmmxt_unpackhub_M0();
-            break;
-        case 1:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_unpackhsw_M0();
-            else
-                gen_op_iwmmxt_unpackhuw_M0();
-            break;
-        case 2:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_unpackhsl_M0();
-            else
-                gen_op_iwmmxt_unpackhul_M0();
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x204: case 0x604: case 0xa04: case 0xe04:     /* WSRL */
-    case 0x214: case 0x614: case 0xa14: case 0xe14:
-        if (((insn >> 22) & 3) == 0)
-            return 1;
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = tcg_temp_new_i32();
-        if (gen_iwmmxt_shift(insn, 0xff, tmp)) {
-            return 1;
-        }
-        switch ((insn >> 22) & 3) {
-        case 1:
-            gen_helper_iwmmxt_srlw(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 2:
-            gen_helper_iwmmxt_srll(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 3:
-            gen_helper_iwmmxt_srlq(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x004: case 0x404: case 0x804: case 0xc04:     /* WSRA */
-    case 0x014: case 0x414: case 0x814: case 0xc14:
-        if (((insn >> 22) & 3) == 0)
-            return 1;
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = tcg_temp_new_i32();
-        if (gen_iwmmxt_shift(insn, 0xff, tmp)) {
-            return 1;
-        }
-        switch ((insn >> 22) & 3) {
-        case 1:
-            gen_helper_iwmmxt_sraw(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 2:
-            gen_helper_iwmmxt_sral(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 3:
-            gen_helper_iwmmxt_sraq(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x104: case 0x504: case 0x904: case 0xd04:     /* WSLL */
-    case 0x114: case 0x514: case 0x914: case 0xd14:
-        if (((insn >> 22) & 3) == 0)
-            return 1;
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = tcg_temp_new_i32();
-        if (gen_iwmmxt_shift(insn, 0xff, tmp)) {
-            return 1;
-        }
-        switch ((insn >> 22) & 3) {
-        case 1:
-            gen_helper_iwmmxt_sllw(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 2:
-            gen_helper_iwmmxt_slll(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 3:
-            gen_helper_iwmmxt_sllq(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x304: case 0x704: case 0xb04: case 0xf04:     /* WROR */
-    case 0x314: case 0x714: case 0xb14: case 0xf14:
-        if (((insn >> 22) & 3) == 0)
-            return 1;
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = tcg_temp_new_i32();
-        switch ((insn >> 22) & 3) {
-        case 1:
-            if (gen_iwmmxt_shift(insn, 0xf, tmp)) {
-                return 1;
-            }
-            gen_helper_iwmmxt_rorw(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 2:
-            if (gen_iwmmxt_shift(insn, 0x1f, tmp)) {
-                return 1;
-            }
-            gen_helper_iwmmxt_rorl(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        case 3:
-            if (gen_iwmmxt_shift(insn, 0x3f, tmp)) {
-                return 1;
-            }
-            gen_helper_iwmmxt_rorq(cpu_M0, tcg_env, cpu_M0, tmp);
-            break;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x116: case 0x316: case 0x516: case 0x716:     /* WMIN */
-    case 0x916: case 0xb16: case 0xd16: case 0xf16:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_minsb_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_minub_M0_wRn(rd1);
-            break;
-        case 1:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_minsw_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_minuw_M0_wRn(rd1);
-            break;
-        case 2:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_minsl_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_minul_M0_wRn(rd1);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x016: case 0x216: case 0x416: case 0x616:     /* WMAX */
-    case 0x816: case 0xa16: case 0xc16: case 0xe16:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 0:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_maxsb_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_maxub_M0_wRn(rd1);
-            break;
-        case 1:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_maxsw_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_maxuw_M0_wRn(rd1);
-            break;
-        case 2:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_maxsl_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_maxul_M0_wRn(rd1);
-            break;
-        case 3:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x002: case 0x102: case 0x202: case 0x302:     /* WALIGNI */
-    case 0x402: case 0x502: case 0x602: case 0x702:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        iwmmxt_load_reg(cpu_V1, rd1);
-        gen_helper_iwmmxt_align(cpu_M0, cpu_M0, cpu_V1,
-                                tcg_constant_i32((insn >> 20) & 3));
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    case 0x01a: case 0x11a: case 0x21a: case 0x31a:     /* WSUB */
-    case 0x41a: case 0x51a: case 0x61a: case 0x71a:
-    case 0x81a: case 0x91a: case 0xa1a: case 0xb1a:
-    case 0xc1a: case 0xd1a: case 0xe1a: case 0xf1a:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 20) & 0xf) {
-        case 0x0:
-            gen_op_iwmmxt_subnb_M0_wRn(rd1);
-            break;
-        case 0x1:
-            gen_op_iwmmxt_subub_M0_wRn(rd1);
-            break;
-        case 0x3:
-            gen_op_iwmmxt_subsb_M0_wRn(rd1);
-            break;
-        case 0x4:
-            gen_op_iwmmxt_subnw_M0_wRn(rd1);
-            break;
-        case 0x5:
-            gen_op_iwmmxt_subuw_M0_wRn(rd1);
-            break;
-        case 0x7:
-            gen_op_iwmmxt_subsw_M0_wRn(rd1);
-            break;
-        case 0x8:
-            gen_op_iwmmxt_subnl_M0_wRn(rd1);
-            break;
-        case 0x9:
-            gen_op_iwmmxt_subul_M0_wRn(rd1);
-            break;
-        case 0xb:
-            gen_op_iwmmxt_subsl_M0_wRn(rd1);
-            break;
-        default:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x01e: case 0x11e: case 0x21e: case 0x31e:     /* WSHUFH */
-    case 0x41e: case 0x51e: case 0x61e: case 0x71e:
-    case 0x81e: case 0x91e: case 0xa1e: case 0xb1e:
-    case 0xc1e: case 0xd1e: case 0xe1e: case 0xf1e:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        tmp = tcg_constant_i32(((insn >> 16) & 0xf0) | (insn & 0x0f));
-        gen_helper_iwmmxt_shufh(cpu_M0, tcg_env, cpu_M0, tmp);
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x018: case 0x118: case 0x218: case 0x318:     /* WADD */
-    case 0x418: case 0x518: case 0x618: case 0x718:
-    case 0x818: case 0x918: case 0xa18: case 0xb18:
-    case 0xc18: case 0xd18: case 0xe18: case 0xf18:
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 20) & 0xf) {
-        case 0x0:
-            gen_op_iwmmxt_addnb_M0_wRn(rd1);
-            break;
-        case 0x1:
-            gen_op_iwmmxt_addub_M0_wRn(rd1);
-            break;
-        case 0x3:
-            gen_op_iwmmxt_addsb_M0_wRn(rd1);
-            break;
-        case 0x4:
-            gen_op_iwmmxt_addnw_M0_wRn(rd1);
-            break;
-        case 0x5:
-            gen_op_iwmmxt_adduw_M0_wRn(rd1);
-            break;
-        case 0x7:
-            gen_op_iwmmxt_addsw_M0_wRn(rd1);
-            break;
-        case 0x8:
-            gen_op_iwmmxt_addnl_M0_wRn(rd1);
-            break;
-        case 0x9:
-            gen_op_iwmmxt_addul_M0_wRn(rd1);
-            break;
-        case 0xb:
-            gen_op_iwmmxt_addsl_M0_wRn(rd1);
-            break;
-        default:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x008: case 0x108: case 0x208: case 0x308:     /* WPACK */
-    case 0x408: case 0x508: case 0x608: case 0x708:
-    case 0x808: case 0x908: case 0xa08: case 0xb08:
-    case 0xc08: case 0xd08: case 0xe08: case 0xf08:
-        if (!(insn & (1 << 20)) || ((insn >> 22) & 3) == 0)
-            return 1;
-        wrd = (insn >> 12) & 0xf;
-        rd0 = (insn >> 16) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        gen_op_iwmmxt_movq_M0_wRn(rd0);
-        switch ((insn >> 22) & 3) {
-        case 1:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_packsw_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_packuw_M0_wRn(rd1);
-            break;
-        case 2:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_packsl_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_packul_M0_wRn(rd1);
-            break;
-        case 3:
-            if (insn & (1 << 21))
-                gen_op_iwmmxt_packsq_M0_wRn(rd1);
-            else
-                gen_op_iwmmxt_packuq_M0_wRn(rd1);
-            break;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        gen_op_iwmmxt_set_cup();
-        break;
-    case 0x201: case 0x203: case 0x205: case 0x207:
-    case 0x209: case 0x20b: case 0x20d: case 0x20f:
-    case 0x211: case 0x213: case 0x215: case 0x217:
-    case 0x219: case 0x21b: case 0x21d: case 0x21f:
-        wrd = (insn >> 5) & 0xf;
-        rd0 = (insn >> 12) & 0xf;
-        rd1 = (insn >> 0) & 0xf;
-        if (rd0 == 0xf || rd1 == 0xf)
-            return 1;
-        gen_op_iwmmxt_movq_M0_wRn(wrd);
-        tmp = load_reg(s, rd0);
-        tmp2 = load_reg(s, rd1);
-        switch ((insn >> 16) & 0xf) {
-        case 0x0:                                       /* TMIA */
-            gen_helper_iwmmxt_muladdsl(cpu_M0, cpu_M0, tmp, tmp2);
-            break;
-        case 0x8:                                       /* TMIAPH */
-            gen_helper_iwmmxt_muladdsw(cpu_M0, cpu_M0, tmp, tmp2);
-            break;
-        case 0xc: case 0xd: case 0xe: case 0xf:                 /* TMIAxy */
-            if (insn & (1 << 16))
-                tcg_gen_shri_i32(tmp, tmp, 16);
-            if (insn & (1 << 17))
-                tcg_gen_shri_i32(tmp2, tmp2, 16);
-            gen_helper_iwmmxt_muladdswl(cpu_M0, cpu_M0, tmp, tmp2);
-            break;
-        default:
-            return 1;
-        }
-        gen_op_iwmmxt_movq_wRn_M0(wrd);
-        gen_op_iwmmxt_set_mup();
-        break;
-    default:
-        return 1;
-    }
-
-    return 0;
-}
-
-/* Disassemble an XScale DSP instruction.  Returns nonzero if an error occurred
-   (ie. an undefined instruction).  */
-static int disas_dsp_insn(DisasContext *s, uint32_t insn)
-{
-    int acc, rd0, rd1, rdhi, rdlo;
-    TCGv_i32 tmp, tmp2;
-
-    if ((insn & 0x0ff00f10) == 0x0e200010) {
-        /* Multiply with Internal Accumulate Format */
-        rd0 = (insn >> 12) & 0xf;
-        rd1 = insn & 0xf;
-        acc = (insn >> 5) & 7;
-
-        if (acc != 0)
-            return 1;
-
-        tmp = load_reg(s, rd0);
-        tmp2 = load_reg(s, rd1);
-        switch ((insn >> 16) & 0xf) {
-        case 0x0:                                       /* MIA */
-            gen_helper_iwmmxt_muladdsl(cpu_M0, cpu_M0, tmp, tmp2);
-            break;
-        case 0x8:                                       /* MIAPH */
-            gen_helper_iwmmxt_muladdsw(cpu_M0, cpu_M0, tmp, tmp2);
-            break;
-        case 0xc:                                       /* MIABB */
-        case 0xd:                                       /* MIABT */
-        case 0xe:                                       /* MIATB */
-        case 0xf:                                       /* MIATT */
-            if (insn & (1 << 16))
-                tcg_gen_shri_i32(tmp, tmp, 16);
-            if (insn & (1 << 17))
-                tcg_gen_shri_i32(tmp2, tmp2, 16);
-            gen_helper_iwmmxt_muladdswl(cpu_M0, cpu_M0, tmp, tmp2);
-            break;
-        default:
-            return 1;
-        }
-
-        gen_op_iwmmxt_movq_wRn_M0(acc);
-        return 0;
-    }
-
-    if ((insn & 0x0fe00ff8) == 0x0c400000) {
-        /* Internal Accumulator Access Format */
-        rdhi = (insn >> 16) & 0xf;
-        rdlo = (insn >> 12) & 0xf;
-        acc = insn & 7;
-
-        if (acc != 0)
-            return 1;
-
-        if (insn & ARM_CP_RW_BIT) {                     /* MRA */
-            iwmmxt_load_reg(cpu_V0, acc);
-            tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
-            tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
-            tcg_gen_andi_i32(cpu_R[rdhi], cpu_R[rdhi], (1 << (40 - 32)) - 1);
-        } else {                                        /* MAR */
-            tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
-            iwmmxt_store_reg(cpu_V0, acc);
-        }
-        return 0;
-    }
-
-    return 1;
-}
-
 static void gen_goto_ptr(void)
 {
     tcg_gen_lookup_and_goto_ptr();
@@ -3048,13 +1789,10 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
     }
 
     if ((s->hstr_active && s->current_el == 0) || ri->accessfn ||
-        (ri->fgt && s->fgt_active) ||
-        (arm_dc_feature(s, ARM_FEATURE_XSCALE) && cpnum < 14)) {
+        (ri->fgt && s->fgt_active)) {
         /*
          * Emit code to perform further access permissions checks at
          * runtime; this may result in an exception.
-         * Note that on XScale all cp0..c13 registers do an access check
-         * call in order to handle c15_cpar.
          */
         gen_set_condexec(s);
         gen_update_pc(s, 0);
@@ -3192,24 +1930,6 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
     }
 }
 
-/* Decode XScale DSP or iWMMXt insn (in the copro space, cp=0 or 1) */
-static void disas_xscale_insn(DisasContext *s, uint32_t insn)
-{
-    int cpnum = (insn >> 8) & 0xf;
-
-    if (extract32(s->c15_cpar, cpnum, 1) == 0) {
-        unallocated_encoding(s);
-    } else if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
-        if (disas_iwmmxt_insn(s, insn)) {
-            unallocated_encoding(s);
-        }
-    } else if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
-        if (disas_dsp_insn(s, insn)) {
-            unallocated_encoding(s);
-        }
-    }
-}
-
 /* Store a 64-bit value to a register pair.  Clobbers val.  */
 static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
 {
@@ -3569,14 +2289,7 @@ static bool valid_cp(DisasContext *s, int cp)
      * only cp14 and cp15 are valid, and other values aren't considered
      * to be in the coprocessor-instruction space at all. v8M still
      * permits coprocessors 0..7.
-     * For XScale, we must not decode the XScale cp0, cp1 space as
-     * a standard coprocessor insn, because we want to fall through to
-     * the legacy disas_xscale_insn() decoder after decodetree is done.
      */
-    if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cp == 0 || cp == 1)) {
-        return false;
-    }
-
     if (arm_dc_feature(s, ARM_FEATURE_V8) &&
         !arm_dc_feature(s, ARM_FEATURE_M)) {
         return cp >= 14;
@@ -7343,18 +6056,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             disas_neon_shared(s, insn)) {
             return;
         }
-        /* fall back to legacy decoder */
-
-        if ((insn & 0x0e000f00) == 0x0c000100) {
-            if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
-                /* iWMMXt register transfer.  */
-                if (extract32(s->c15_cpar, 1, 1)) {
-                    if (!disas_iwmmxt_insn(s, insn)) {
-                        return;
-                    }
-                }
-            }
-        }
         goto illegal_op;
     }
     if (cond != 0xe) {
@@ -7368,16 +6069,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         disas_vfp(s, insn)) {
         return;
     }
-    /* fall back to legacy decoder */
-    /* TODO: convert xscale/iwmmxt decoder to decodetree ?? */
-    if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
-        if (((insn & 0x0c000e00) == 0x0c000000)
-            && ((insn & 0x03000000) != 0x03000000)) {
-            /* Coprocessor insn, coprocessor 0 or 1 */
-            disas_xscale_insn(s, insn);
-            return;
-        }
-    }
+    /* We didn't match anything in the decoder: UNDEF */
 
 illegal_op:
     unallocated_encoding(s);
@@ -7606,12 +6298,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->hstr_active = EX_TBFLAG_A32(tb_flags, HSTR_ACTIVE);
         dc->ns = EX_TBFLAG_A32(tb_flags, NS);
         dc->vfp_enabled = EX_TBFLAG_A32(tb_flags, VFPEN);
-        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-            dc->c15_cpar = EX_TBFLAG_A32(tb_flags, XSCALE_CPAR);
-        } else {
-            dc->vec_len = EX_TBFLAG_A32(tb_flags, VECLEN);
-            dc->vec_stride = EX_TBFLAG_A32(tb_flags, VECSTRIDE);
-        }
+        dc->vec_len = EX_TBFLAG_A32(tb_flags, VECLEN);
+        dc->vec_stride = EX_TBFLAG_A32(tb_flags, VECSTRIDE);
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
     }
@@ -7651,10 +6339,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         int bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
         dc->base.max_insns = MIN(dc->base.max_insns, bound);
     }
-
-    cpu_V0 = tcg_temp_new_i64();
-    cpu_V1 = tcg_temp_new_i64();
-    cpu_M0 = tcg_temp_new_i64();
 }
 
 static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.43.0


