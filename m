Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50F0D2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkci0-0002rA-R0; Tue, 27 Jan 2026 01:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchy-0002qd-K8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:50 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchw-0006j2-Ph
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:50 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1988537a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495867; x=1770100667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63sWoJLOOtd8lWo8QXyMTRA67VQwKXCg87mJb8KQGqM=;
 b=YwlQTdm0kCrDPlANMyHieOV+ueEbiUiD+aDAnbbq7bPK1PowS74RudlopufFMhh4K3
 NPmOBgB9wYTVTHsBcH3z0XuK+TffGj3QkFoxyPZRNdMC3KhGWz4h/NjkfqcwKHHAM7xx
 ++TLNPgV09P1sM0J8nStWYjxwJuB+ch+He5f5uz8FzUIwZx4Ujg+49SDnQUaCzsoNnpD
 0Q4ChGnfagYeMVzuBf5Yn8pPpvGuSd2eAMtC7/TPEIkTxWJxQZBVQHv/BmUn3H3FFN81
 7Krw78f1oEHmiCMnWZSyaUcKY/BXmz684TS94GyYcsqQ+hQpJyvTVM6j5YPrvxGFGAzJ
 5XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495867; x=1770100667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=63sWoJLOOtd8lWo8QXyMTRA67VQwKXCg87mJb8KQGqM=;
 b=HENUsnOfw69JyWxFY/iH7sXgQNOt4vAyEqARSt7DyHKqZCReyXiY+keMDp8sJHFRtS
 ulCOles1oTomFxcFpZOOSLs5Yqxt7gKu0Wcpq7bwN5bJYq4KFXjtHuW62hzXDvToKY0x
 BNq9uQ8M2eADGjNil1geWYygv7IH1LTElr2UXxWa8mzwlWDknA26kPOhSXvCyfaSgkQK
 e3uFibTVBoTqfFKjk86Rmgrw8aVHCHSzs0IrS1PRTxCHua2oCXIw3frYKYYF2QIEFSA4
 svMoQ3p3c9mg8ANXK6Pgfaw5FRc9SKiwUd7Z/mLb0YFAesFBR21xVOIV0i2vfiVZWYs3
 m/hQ==
X-Gm-Message-State: AOJu0YymSp8R3deR7K2e/noNTo5uV/fvjOheJxhxiT71fpbxDqRgePmj
 rv3t2fKExGN7v0XNISuDHpFIFQMBGrooEjlnMKJuK0oh0MHb1x6f5D+CpmTE0efM3Jl1grOuVAf
 kaE1PhdIB2/yH4448dOPBULHhxSFkaziXIOY9/bHC3N8hnYdvqo3i51X56YQSP/NgzdWPcCnxKJ
 0JXLPbvcf+HggemnUxkNS1ShT2euQ8nMgL78+nVEMZkA==
X-Gm-Gg: AZuq6aKL8m+4xqnz9RrJEjehZiwccdoihsUW0Upzk2y7SzdS8z3yxsBBd2WTfFN4skE
 NWzkmMdJM9Hy/lLN+3542UCnD9fUfRfFTgM6JeMbUd5TCvHq0UMapPeHvF7AysCz7GNwolo7Pee
 Ktgs1NBLKjUZJjBNItFIUCJBTyXfVHlREzlA33kT+/Jkobsm/dJ8YBv1SSe1592jd8Ygw+UGEM9
 KUQX8piDAzpfvkNPRrBEpqzcU2Ev3IIhWHBZg2wfz6NdsxspID05pE5yb4aj8Dow6tViid2Mh6M
 +FGeq0fwpA8/2iRHPr1xX6PE6ImAbhhC4CCH9Kr+woVls+X/cDBzfKrYU8HyEQ9G+Q+PcsCN+Yl
 yuGnBjjXuswALM09xxnxVrWS5SQx+WP5tW9Q/VAfMQz4anFI7rUEzhcNHS5gx9zhTibZcLOquD9
 havkjYVpxNcN7sFD1lsHinC7fexnToP0q4+p+XeqgSw45nD4NK66sFLdm04zLNJdaShcG/Zo4Oo
 EofiuV7YccBeqg=
X-Received: by 2002:a17:90b:2d83:b0:34a:a1c1:90a0 with SMTP id
 98e67ed59e1d1-353fed87a85mr697371a91.28.1769495867244; 
 Mon, 26 Jan 2026 22:37:47 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:46 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 07/17] target/riscv: rvv: Make vfwcvtbf16.f.f.v support
 OFP8 to BF16 conversion for Zvfofp8min extension
Date: Tue, 27 Jan 2026 14:37:13 +0800
Message-ID: <20260127063723.442734-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the Zvfofp8min extension, the vfwcvtbf16.f.f.v instruction
supports OFP8 to BF16 conversion when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: OFP8.e4m3 to BF16
* altfmt = 1: OFP8.e5m2 to BF16

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      | 12 +++
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 +++-
 target/riscv/vector_helper.c               | 97 ++++++++++++++++++++++
 3 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index eb0a488ba8..356c24d9fb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1247,6 +1247,18 @@ DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmaccbf16_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmaccbf16_vf, void, ptr, ptr, i64, ptr, env, i32)
 
+/* OFP8 functions */
+DEF_HELPER_5(vfwcvtbf16_f_f_v_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvtbf16_f_f_v_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_f_f_w_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_f_f_w_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_sat_f_f_w_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvtbf16_sat_f_f_w_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
+
 /* Vector crypto functions */
 DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 6cfda03d2e..9aafd4d2ef 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -92,11 +92,20 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZVFBFMIN(ctx);
 
-    if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
+    if (opfv_widen_check(ctx, a) &&
+        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
+         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
+        gen_helper_gvec_3_ptr *fn;
         uint32_t data = 0;
 
+        if (ctx->sew == MO_16) {
+            fn = gen_helper_vfwcvtbf16_f_f_v;
+        } else {
+            fn = ctx->altfmt ? gen_helper_vfwcvtbf16_f_f_v_ofp8e5m2 :
+                               gen_helper_vfwcvtbf16_f_f_v_ofp8e4m3;
+        }
+
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -106,8 +115,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
                            ctx->cfg_ptr->vlenb,
-                           ctx->cfg_ptr->vlenb, data,
-                           gen_helper_vfwcvtbf16_f_f_v);
+                           ctx->cfg_ptr->vlenb, data, fn);
         finalize_rvv_inst(ctx);
         return true;
     }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ee5a1e595b..418212973d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5024,6 +5024,103 @@ GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4)
 RVVCALL(OPFVV1, vfncvtbf16_f_f_w, NOP_UU_H, H2, H4, float32_to_bfloat16)
 GEN_VEXT_V_ENV(vfncvtbf16_f_f_w, 2)
 
+/*
+ * OCP FP8 Narrowing Conversions (BF16/F32 -> FP8)
+ * 1. Initialize a local float_status with RISC-V specific NaN handling
+ * 2. Call the softfloat conversion function with saturation parameter
+ * 3. Merge exception flags back to the original status
+ */
+#define GEN_OCP_FP8_NARROW(NAME, CONVERT_FN, SATURATE, IN_TYPE)  \
+static uint8_t NAME(IN_TYPE a, float_status *s)                  \
+{                                                                \
+    float_status local = *s;                                     \
+    local.default_nan_pattern = 0x70;                            \
+    local.default_nan_mode = true;                               \
+    uint8_t result = CONVERT_FN(a, SATURATE, &local);            \
+    s->float_exception_flags |= local.float_exception_flags;     \
+    return result;                                               \
+}
+
+/* BF16 -> E4M3/E5M2 conversions */
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e4m3, bfloat16_to_float8_e4m3, false,
+                   uint16_t)
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e5m2, bfloat16_to_float8_e5m2, false,
+                   uint16_t)
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e4m3_sat, bfloat16_to_float8_e4m3, true,
+                   uint16_t)
+GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e5m2_sat, bfloat16_to_float8_e5m2, true,
+                   uint16_t)
+
+/* F32 -> E4M3/E5M2 conversions */
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e4m3, float32_to_float8_e4m3, false, uint32_t)
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e5m2, float32_to_float8_e5m2, false, uint32_t)
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e4m3_sat, float32_to_float8_e4m3, true,
+                   uint32_t)
+GEN_OCP_FP8_NARROW(vfncvt_f32_to_e5m2_sat, float32_to_float8_e5m2, true,
+                   uint32_t)
+
+/*
+ * OCP FP8 Widening Conversions (FP8 -> BF16)
+ * According to Zvfofp8min isa specification: "No rounding occurs, and no
+ * floating-point exception flags are set."
+ * 1. Initialize a local float_status with no_signaling_nans=true
+ * 2. Call the softfloat conversion function
+ * 3. Intentionally DISCARD exception flags (not merged back)
+ */
+#define GEN_OCP_FP8_WIDEN(NAME, CONVERT_FN)      \
+static uint16_t NAME(uint8_t a, float_status *s) \
+{                                                \
+    float_status local = *s;                     \
+    local.no_signaling_nans = true;              \
+    return CONVERT_FN(a, &local);                \
+}
+
+GEN_OCP_FP8_WIDEN(vfwcvt_e4m3_to_bf16, float8_e4m3_to_bfloat16)
+GEN_OCP_FP8_WIDEN(vfwcvt_e5m2_to_bf16, float8_e5m2_to_bfloat16)
+
+/* vfwcvtbf16.f.f.w vd, vs2, vm # Convert OFP8 to BF16. */
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e4m3, WOP_UU_B, H2, H1,
+        vfwcvt_e4m3_to_bf16)
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e5m2, WOP_UU_B, H2, H1,
+        vfwcvt_e5m2_to_bf16)
+GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v_ofp8e4m3, 2)
+GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v_ofp8e5m2, 2)
+
+/* vfncvtbf16.f.f.w vd, vs2, vm # Convert BF16 to OFP8 without saturation. */
+RVVCALL(OPFVV1, vfncvtbf16_f_f_w_ofp8e4m3, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e4m3)
+RVVCALL(OPFVV1, vfncvtbf16_f_f_w_ofp8e5m2, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e5m2)
+GEN_VEXT_V_ENV(vfncvtbf16_f_f_w_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvtbf16_f_f_w_ofp8e5m2, 1)
+
+/* vfncvtbf16.sat.f.f.w vd, vs2, vm # Convert BF16 to OFP8 with saturation. */
+RVVCALL(OPFVV1, vfncvtbf16_sat_f_f_w_ofp8e4m3, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e4m3_sat)
+RVVCALL(OPFVV1, vfncvtbf16_sat_f_f_w_ofp8e5m2, NOP_UU_B, H1, H2,
+        vfncvt_bf16_to_e5m2_sat)
+GEN_VEXT_V_ENV(vfncvtbf16_sat_f_f_w_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvtbf16_sat_f_f_w_ofp8e5m2, 1)
+
+/* Quad-width narrowing type for FP32 to OFP8 */
+#define QOP_UU_B uint8_t, uint32_t, uint32_t
+
+/* vfncvt.f.f.q vd, vs2, vm # Convert FP32 to OFP8. */
+RVVCALL(OPFVV1, vfncvt_f_f_q_ofp8e4m3, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e4m3)
+RVVCALL(OPFVV1, vfncvt_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e5m2)
+GEN_VEXT_V_ENV(vfncvt_f_f_q_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvt_f_f_q_ofp8e5m2, 1)
+
+/* vfncvt.sat.f.f.q vd, vs2, vm # Convert FP32 to OFP8 with saturation. */
+RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e4m3, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e4m3_sat)
+RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
+        vfncvt_f32_to_e5m2_sat)
+GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
+GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
+
 /*
  * Vector Reduction Operations
  */
-- 
2.52.0


