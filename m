Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFEDCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZP-00080v-At; Wed, 20 May 2026 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZI-0007ib-5x
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ9-0000gW-2d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so4832394a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301357; x=1779906157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbxzBKw85ieXpS8gNagaiOLWU+/c2aV0GOxiaxlAUhM=;
 b=ij4HfsN9lZ2uN593TSjCQZcCI8ddKNJ70AhVPwO9lFOuyUauTmw5nYgLTaU6Scyc11
 95IBvbRUZy9lrvtGV8ao6DWKxZV3IBfZkpezB9ShPj33Lr9f416RAN2YLXiBlKcNBIra
 7hchSYRw+cEBOTplpe6PFIylOCedfbk1l6iYvGiwT0loz8TAN1/YvUfncTWyW8jly38K
 8xzbtTK9iZAHEPhWRxqdieDEyNeu94K+N4LIw+TaGNErH5nbtkee0dU6PoObIbWpj11u
 RK3Ju++X3YavCyL4Wp1GKS7+FGgZU6UnYoxmkliLRVl6CPSr2IbYYo1UxngfSFPgdK5B
 jbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301357; x=1779906157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbxzBKw85ieXpS8gNagaiOLWU+/c2aV0GOxiaxlAUhM=;
 b=O0nh2LTJZPZsdsMAZg7uI/AUyADeZZnIGpm+j4EhdLbXSf3WxnT8ZkWu6d/4zDtOMt
 iyjC8wttrEjWELZpsS70vHnC9Qtn0a2srAx9WI6trx3dvp84KLWQxpmj/Nh7ZGeop8QF
 0N+vMkLlntKFP3qTkuwlN4K/598+7/WxfD/aNGndQTv3S+oy21lFFwyIZYv7ypGf4NkS
 xWc/uui+W1cmZ4G8BSvVX4cjPBLTeo0g2A0uzNd8nBmK5lA7FnBUmkfG8L72AzJ54zL3
 zcacURU+1ci75mTbhtsNOe8G1LMoZa2YmqGdIS8YXZFsGXgv2tXWr4X1cIGhbXQiGdIF
 pdGw==
X-Gm-Message-State: AOJu0YwtZZ7UQ5RfD0DQvtmNPWrYiO99yOXvTpwltou8eIxYtWnCpynV
 tOSRQI0a/OiI5td3QD43iTOJhN0kJwxlD8FxB0/1z8awFpuK+sbz5pVeF1fgevTMCzOQQqD9tXP
 FRjndt8Q=
X-Gm-Gg: Acq92OFKsNvxV8tD2UpgNY6zJFGtdMOGoDtzMgBzP/Mp62hV7n+RYHqGJScKNwQ8voK
 aAbIfYljalAOKUTETUfKErU0TtMvrZDiyzumFkB3rA7y/uCr9PQy8YPA5kzg8FPOs1ivpV+PhfU
 NOkAgq9CDUKv8FLFD5qUfK9cZxwoSGc3vMES4EBZNQMcrvmy2IeS/jayFh2AITLlGTpsX3nDIdw
 jZgWnJQL9/PthrrzSJQd1mSSxFH/uz3h10ZDDMN1k2avTD2FKRzABmg9WpjuQfmuDDhJmoQoSL7
 qav+g+nFOFXaHc9kIH9fJ8NQCWOk5iYP6LCSjlUckjKPYZXTIef4oI7SqYd2f2x9vbn/lJevM6A
 Q0yWK11yMqsUhwTfP8QrO9v3o3dolGlaJweFXejN6G1evi0xVu/ngVc2KPk4yOBEHngCXoXESmI
 uJWSF/FN42TJfX4Pn5N3D2v8WElglK
X-Received: by 2002:a17:90b:574d:b0:36a:9d7:8589 with SMTP id
 98e67ed59e1d1-36a09d78874mr8359902a91.21.1779301357001; 
 Wed, 20 May 2026 11:22:37 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 32/64] target/arm: Implement FCVTN (16- to 8-bit fp) for
 AdvSIMD
Date: Wed, 20 May 2026 11:21:41 -0700
Message-ID: <20260520182213.872945-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 37 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 15 +++++++++++++
 target/arm/tcg/a64.decode        |  2 ++
 4 files changed, 56 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index bbc8d69e28..6530d1a6da 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -14,3 +14,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0a4f603c8a..a8337a8fb7 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -181,6 +181,13 @@ static uint8_t fcvt_b16_to_fp8(bfloat16 x, fcvt_fp8_output_fn *f8fmt,
     return f8fmt(&p, scale, saturate, s);
 }
 
+static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = float16_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -370,3 +377,33 @@ void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, true);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vd == vm) {
+        m = memcpy(&scratch, vm, oprsz);
+    }
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H1(i)] = fcvt_f16_to_fp8(n[H2(i)], output_fmt,
+                                   ctx.scale, osc, &ctx.stat);
+    }
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H1(i) + nelem] = fcvt_f16_to_fp8(m[H2(i)], output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 565053a1a4..0927eb6516 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6522,6 +6522,21 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
 };
 TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
 
+static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           FPST_A64 << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 26d31d0a33..71456d44e1 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1201,6 +1201,8 @@ FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
+FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


