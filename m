Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06087CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Oi-0000hH-1W; Thu, 07 May 2026 19:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Of-0000Xj-2n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:49 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Oc-0001BL-S2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1872504cbso1372386a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197485; x=1778802285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TD5alF7orbbwxvi1kYcSIvIUO1d+/7yBfpn7JAzHu/s=;
 b=tYVA1C+JbyAGC+/gmkHORQQRnz7osCPPNkOVaC929CNcttsBw3LU5nX5HzuvBFoONX
 iI+wWQg20O3qg7um5mDf1sIR/901KDX8nLFRapXP0OySq7TcJR2PEkEB3QmqygGYJYYJ
 4MShuOgHpu+V+/lRzfjqWYvsPYsMND9lbrQnwg7rpiFG0jbrNJEBc3igr/Nhurr+ND6B
 SWDUensnngNtJ7sfVcVLjaWs6TE7wy/6VrlJ+4gVpCIC3Azg8sjpcca4lvuH9hd3kRah
 FhkRx3ZdNn8W4rpypaaB/Ck89RjUnn2fj09hu5TGSfa/1xklOvNEBv6lQs8KavO6QI0l
 qbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197485; x=1778802285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TD5alF7orbbwxvi1kYcSIvIUO1d+/7yBfpn7JAzHu/s=;
 b=HVEpbWg3CCoGl+pfho81kD6S/x8jlxt+c4wOj48CWFXv12ZWd2xPeilhbsQ2+bQ7k1
 QnGD0GMVK5mc1D2ej0Zz9ZIy2N8kUfDhZxpC5x002ipvZWkio+kvvBwxv0kb2QNazefp
 P70w0qve4IuLt6SSGsD9R+AbzCMmyMRQt9gb4bWZY9Ckwc0T8n33ivev61QzdbG5kn/T
 Lrr5QAZQcmyPYR3dQLpEklWCUEzSADLq+p6aSMsDr9fuXV1A33mOenUqRsz5plahI/fV
 dWh6tihroPG1wvcfAzVbdQoyCbG48OAQSYI+/l24AcuP/rY9ojPj5/eVCLFd6V4hlD+U
 2v1g==
X-Gm-Message-State: AOJu0YxeCg3Gdb7m5pI5BxHzLdWTLo74DjSla46GGYj4y34mWof0pzU+
 0jbuiK8crhn2cr+eDhkvfhASXir8P7igQCsJTSOksnO9x1vfYERM6wS4kbYPEL97CZhqXtCCWJj
 xjK8G
X-Gm-Gg: AeBDiesF1n474oM0l6ySKJQhf5lMvvd3k5W50n1jUwoMsXZbB7/Gt/fbOcaW4NCgCo3
 6jATwZv2LIOp1XKbRc9YYwb1KbMZpdjo5BTM42RGR2pF7c15Lau6/iXl8sJhkbpUrMOhx+4j0Df
 33WH12B0DcGdd6l5l/xnyMhuiXGyhEGAt+RGh7w90fzjvEVHh/56kJuZRO2UkfKq4n9WPYcxbPN
 sTuSpb1VgrxTA8+Cqj/FHPI4dbCJY6clzZtAiCIpFXA9rD3NZWyRnrDMAfb2nYeJDZLvkXJ4so2
 atqSy2X199fujqrM2Paf8SMzgnEo6qDuDlkg2MAPZg2HzepJjnbq1+3mIePm8EomO/Dp/SnubLb
 RCUteSbv3nu2xvYzhe6c9lu/hDPeaefP7kBbtJLkBgv/jiDxa/Nk4kk7sAeawZ2FHHtWIfossXa
 adQ2uzhkkqlJfYUxkxgS0r7Dd8imfgP4sHyeqMkbfstOW+UA==
X-Received: by 2002:a05:6830:3c09:b0:7de:9b99:a8ee with SMTP id
 46e09a7af769-7e1fd219afcmr3089414a34.9.1778197484785; 
 Thu, 07 May 2026 16:44:44 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 31/60] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Thu,  7 May 2026 18:43:44 -0500
Message-ID: <20260507234413.643512-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
 target/arm/tcg/fp8_helper.c      | 33 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 16 ++++++++++++++++
 target/arm/tcg/a64.decode        |  1 +
 4 files changed, 52 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 6530d1a6da..023a49e12f 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,3 +16,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index e209860a8f..2252d2c526 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -182,6 +182,13 @@ static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
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
@@ -401,3 +408,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
+                             CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
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
+    fp8_finish(env, &ctx);
+    clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0927eb6516..3c784afc99 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6537,6 +6537,22 @@ static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 71456d44e1..a9cf259b9b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1202,6 +1202,7 @@ FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


