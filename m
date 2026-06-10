Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09394CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYB-0001tC-Uz; Wed, 10 Jun 2026 12:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYA-0001la-3w
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY8-0005kt-5D
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so61348675e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107982; x=1781712782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rO0w5lKp2t3uHyRlz4tqze431l11PFiz7PA+zveNqgA=;
 b=TbQrV01qSARjI9gCImZLBU4zMmOexxqYtiXDL1+mv+5cWCYJ57HLYLCsY9eMBpe3nj
 LZPE1qq+MKbpMndhn+j6Zd0zGgHHtwLrXDqdDXVWUglKYtalR5vaKb1Pi1/jvx6BW9ok
 f4SSM+FORYRPNUfMOksIioHyJR/8VqMT4olPKgzOVMi52PAimUiRs2/kCm0XNjMJaEWJ
 E+2sQNJvxNLI4Zh9awNQ3ccIpalorSb5ihWZhC8+KNgu0VDmN0oUfxh38PeDRNr1XM3U
 5vBDWq/N0Nm4VUCx+PLb4nCH0Ie6vIqBJJTYrEmJn5g7PtRonB1rynwL34Gpbq/wphbS
 oKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107982; x=1781712782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rO0w5lKp2t3uHyRlz4tqze431l11PFiz7PA+zveNqgA=;
 b=MTAbQqR4EmdUTUeMlvWfNzNgt4RFBuwcYWV6jA8x+FE4mDH94dD+byR1TadCwTEf1g
 fNJa5FoKyUL3npW6YanxYD/1KB3G8ocFfotkoxyDEUijSYBfclUDf9t/YWgR3lR5KUdP
 r7fy855ht7cA9gwzG9LYioAFgyhqyPzEap+WXZuj568+D853GYVW18iHBEucoDuZiVby
 WUcg+vV1vVCr2fzI3UWsXFEe60U8KEmWtIIT6RjxQcckxg6VSb4ehwWxTmoJFSgc6yDv
 642uK0VHlJuFOPHySy5KrhAj2asf3etJyHLWaFspUu5qNJmvTPil0OdgZ1XFxcVpNwoH
 Foyg==
X-Gm-Message-State: AOJu0Ywa6o3Xu28g5rhlNRUFn1gJrf2Kkn32NNEv/KqQ1E03FAP6CBvc
 WllK+2XC6wf4dn7Ivp0jyTuCOYBaR3tiEzdkw2hmtw/NFuE5jG8h1xlTRYKk2cCOJAz4HDp1Dvt
 4OD++
X-Gm-Gg: Acq92OElu3tuMSWoy8jByF0JFfo57D0dOjtVSzAwGy60NCG4lN6QdYSVU91P/pImr1K
 ZF0FYXvlv/65rGCX372wB65ApFXAMqxEGNe8wQx3Lip6H3iJpN9JefvmaGItwD92uLq4/qxaIuF
 Sa5pE41mgsA57AlcD9Vti5Bbg+eY+5q8FDYgU8wAZ2kDRB9ztMLOV8dmcDmkJ1959jL8qs26P77
 iPJHphZiio7fG+mWKpOa1oszmkj+GU9D1++cMoRMQmNsI0g52UflHgkg5zCjYVgJ8eluOQuZ88E
 06zwtik6x3Jr674rN5sW63HrWQPOl17iI+AmtmiQQzj42vUSOKARjBmwbah7bRyFpX023ugRWy0
 lH/wTa2sJLt+dXp54oimmzuGR0vmyzle+/3Y5onVTMbiZp8UCKXCUZ/M5qYzb6UK5ttahrlJ3dL
 qYqlGnKDmaK/f2ia+0ccA9HpYb6yFdgdGX0kK/opfFmB707iWkwSHrzG0KIu44Zho0u2gOT4eR1
 wWWD6vcWbjpUdZd5E7pT28wXj+N/Zjo9HPIvPaEGW4=
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-490c264cc2emr426628775e9.33.1781107982066; 
 Wed, 10 Jun 2026 09:13:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/71] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Wed, 10 Jun 2026 17:11:33 +0100
Message-ID: <20260610161202.2235298-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode        |  1 +
 target/arm/tcg/fp8_helper.c      | 33 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/translate-a64.c   | 16 ++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b08895d917..610047846f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1213,6 +1213,7 @@ FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 8e7982a888..0b86ed9eb9 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -187,6 +187,13 @@ static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
     return f8fmt(&p, scale, saturate, s);
 }
 
+static uint8_t fcvt_f32_to_fp8(float32 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = float32_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -406,3 +413,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_cvt_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
+                             CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n = vn, *m = vm, scratch[4];
+    uint8_t *d = vd + 8 * ctx.high;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    if (vd == vm) {
+        m = memcpy(scratch, vm, 16);
+    }
+
+    for (size_t i = 0; i < 4; ++i) {
+        d[H1(i + 0)] = fcvt_f32_to_fp8(n[H4(i)], output_fmt,
+                                       ctx.scale, osc, &ctx.stat);
+    }
+    for (size_t i = 0; i < 4; ++i) {
+        d[H1(i + 4)] = fcvt_f32_to_fp8(m[H4(i)], output_fmt,
+                                       ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 6530d1a6da..023a49e12f 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,3 +16,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 538b318415..5606f610c8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6634,6 +6634,22 @@ static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
     return true;
 }
 
+static bool trans_FCVTN_bs(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, 16, vec_full_reg_size(s),
+                           (a->q << 1) | FPST_A64 << 2,
+                           gen_helper_advsimd_fcvt_bs);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
-- 
2.43.0


