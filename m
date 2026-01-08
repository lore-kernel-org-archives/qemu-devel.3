Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A8CD1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlO-0000y5-R4; Thu, 08 Jan 2026 10:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlN-0000wv-2v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:25 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlL-0003Uf-CC
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:24 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81c5ff546f6so535127b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885442; x=1768490242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU5IHKX/mvJC/jNBpl926F0veAMaprINCGZ2jgZDcOo=;
 b=OfgEg7FcY19GHo3YcYtPt8bb8MX1YOLEH1J/PyWATsVoALhbUhhNJfuGLYq1hLbinV
 eaJ+zUsn4O/GFnAiW/mn+N1J3jOqkjlwdwxOaOrM4/aZpIedhJAA/YwUVTEFxTn2fOjU
 bQx3xaJtlxiYTOAtGRiIVFt2iFRiAmTywQd2x00tEC5QYMJ+5Aank+QjKUvwAKlK2rrq
 DPuaMnu20xQ3kf009q1kZhKSH8bzYoXaweMY80NsMlwFtiLTc2th2RVRrzS+RuJLBhrn
 M7xiR7axnmpl1s+It/HLmX9uUFPBp2lwDzfNNzlTmWDTjrm+t8XOjBXrm3Tm1/M+opnf
 kSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885442; x=1768490242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LU5IHKX/mvJC/jNBpl926F0veAMaprINCGZ2jgZDcOo=;
 b=nAX6juCSTMoI3PZ/hNgjKWusjk6/9fUibc+jzjYRxTdrOIU8dSpS439eQ1meSnHAyI
 ppi7SgW5DEc55AWwTZkvEWB6UQTQWE+p9iYftmU5NoosaWejILnVQ83Hh+7iDJeIuN3Z
 Z1ssKpBzDg4zA0WgWUk7iBGkRjDy4M5xGXlaPpU4+Iaa6qRh6RkMu9dv8oGs4n58TTnp
 UuL/nB7tF2Zw/RHGwqb6SsUZJWSBlt+5HW7ih9VegnHhvtskFvHtxUmaYM12eQRoT5sB
 Yd6YgBES2CoE9SeQBZi2hDwS/ga8lOlKdpDnOX4oziLM+6/qCibQmQj/THkmVCmqyn5G
 vU6g==
X-Gm-Message-State: AOJu0Yzqv3TcTn0cptzT1KXxQuD7BNPk5OUdDTtQrZtwE9b1GbuOU6Bs
 dsLEM4qmlIMpmgTC8PyXdznsJia9K7wKw5MjCo/mD9mN6TSBnRtn1XsLWWVfzRvMAhnm5g7UkuG
 Yff+Sxrv/iEVou+pa/z345F4LjblucFy2U1VDcFXlEeqVaMo2dv7jXJ9xTZtPukCeuQ6C4L/xt6
 qim71S7CiUshQ/Xu0LCv5YLi1rG3gBHkt2m4VQG4U=
X-Gm-Gg: AY/fxX46P+4s9yfRuJt9Z8sHz8SrudCqqg5QGSz5Uwr0a/c+nEIjjCtvo9BI6QZfgho
 YY78VeKRuyT/2vjv5deaWtZBX3RMraMnQdUY5LhYKIGhoiJiJncoPksY7e8AqUDNgte5uX/bSzu
 WYATmIFq/QP8+nnVr2sgEtc/OTzLRolR5sVGwvdKal6mrr9rcTLMUsO0rSR13WQeqqR+MpCRjMV
 fK7ngOeif4tQCGgc/iwz5jHGm9oQPTj+a62fVxxxGAmJETFhYlhELgxig3KCvxVhUkwKLyhfr7W
 JFLyZCPIA5plR3lfDgJpT3kQwDlY06m9r5uq7TRfS7mf7qnNTzvJh1fWIw7bVFquJL9jP1vWAgg
 lpfsArN5yr5UCgNjTogoi1ueaSO87s1fpnqeBXwYkmk8IoLlITQ//CDmn1zIPsi5BJAxFUh7Hj2
 mRtQ8CO6g4yZP0QvraVTqHW6xPcmhczb0+RWtTVZjTsup1hxMkjBt8iN65UhwBbPTomg==
X-Google-Smtp-Source: AGHT+IEd+/Mk9GB1kKga0KVJpPOq9SXA8yImeMQVGImzfsOpa1/IrmNZkv7UZ0ILmRjCalm96L9Xdg==
X-Received: by 2002:a05:6a00:4405:b0:81c:ce40:b28d with SMTP id
 d2e1a72fcca58-81cce40b648mr2013565b3a.4.1767885441348; 
 Thu, 08 Jan 2026 07:17:21 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:21 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 08/18] target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8
 to BF16 conversion for Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:39 +0800
Message-ID: <20260108151650.16329-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
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

According to the Zvfofp8min extension, the vfwcvtbf16.f.f.v instruction
supports OFP8 to BF16 conversion when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: OFP8.e4m3 to BF16
* altfmt = 1: OFP8.e5m2 to BF16

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      | 12 +++
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 +++-
 target/riscv/vector_helper.c               | 93 ++++++++++++++++++++++
 3 files changed, 117 insertions(+), 4 deletions(-)

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
index ee5a1e595b..759ebb3251 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5024,6 +5024,99 @@ GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4)
 RVVCALL(OPFVV1, vfncvtbf16_f_f_w, NOP_UU_H, H2, H4, float32_to_bfloat16)
 GEN_VEXT_V_ENV(vfncvtbf16_f_f_w, 2)
 
+/*
+ * Vector OFP8 conversion operations for Zvfofp8min
+ *
+ * Note: The OCP FP8 conversion functions use flags in float_status to control
+ * the same_canonical_nan and only_quiet_nan behavior. RISC-V should set
+ * ocp_fp8_same_canonical_nan and ocp_fp8e5m2_no_signal_nan flags during CPU
+ * initialization to get the correct Zvfofp8min behavior.
+ */
+
+/* Wrapper functions for RVVCALL macro compatibility */
+static uint8_t vfncvt_bf16_to_e4m3(uint16_t a, float_status *s)
+{
+    return bfloat16_to_float8_e4m3(a, false, s);
+}
+
+static uint8_t vfncvt_bf16_to_e5m2(uint16_t a, float_status *s)
+{
+    return bfloat16_to_float8_e5m2(a, false, s);
+}
+
+static uint8_t vfncvt_bf16_to_e4m3_sat(uint16_t a, float_status *s)
+{
+    return bfloat16_to_float8_e4m3(a, true, s);
+}
+
+static uint8_t vfncvt_bf16_to_e5m2_sat(uint16_t a, float_status *s)
+{
+    return bfloat16_to_float8_e5m2(a, true, s);
+}
+
+static uint8_t vfncvt_f32_to_e4m3(uint32_t a, float_status *s)
+{
+    return float32_to_float8_e4m3(a, false, s);
+}
+
+static uint8_t vfncvt_f32_to_e5m2(uint32_t a, float_status *s)
+{
+    return float32_to_float8_e5m2(a, false, s);
+}
+
+static uint8_t vfncvt_f32_to_e4m3_sat(uint32_t a, float_status *s)
+{
+    return float32_to_float8_e4m3(a, true, s);
+}
+
+static uint8_t vfncvt_f32_to_e5m2_sat(uint32_t a, float_status *s)
+{
+    return float32_to_float8_e5m2(a, true, s);
+}
+
+/* vfwcvtbf16.f.f.w vd, vs2, vm # Convert OFP8 to BF16. */
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e4m3, WOP_UU_B, H2, H1,
+        float8_e4m3_to_bfloat16)
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e5m2, WOP_UU_B, H2, H1,
+        float8_e5m2_to_bfloat16)
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
2.43.7


