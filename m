Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75835CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYJ-000283-3d; Wed, 10 Jun 2026 12:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYD-0001y3-VK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYC-0005sA-6G
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so77042145e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107987; x=1781712787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ftN4VbZgXk5klPBBhRve5YXNmghakPrf14CCWqLU1ok=;
 b=kbOHTYQmBHBNUsiiHvIgABRtTs858GxjGst8HFauPsXgLAwfvZc1UHtTy+Ph+cGkc+
 YddvjqW5eeuMRPifoSdCieARYEnAw6orz7m5V9qpF6u7kJBbyIHrwm1dA0+FCE8VbLE5
 RLG++4+sJDFYi+WeO4c/mVSwtrpY/SISNZzV+BoNbTHE6QC1FvxUH1Q6s+XKY9O8bS4m
 9zZmIZoOWGnoGNVjPvhUBhjvBP65PkrlCqqlyEdl7KKUcIR5/V/unva47xWJ+KmxP77G
 ZNdJ+OxRWQhLG+hRxU7d9OurH3hT6STI42aIOgYzx7B5VxOUuxmmuUVGktcGzEquaWcZ
 GhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107987; x=1781712787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ftN4VbZgXk5klPBBhRve5YXNmghakPrf14CCWqLU1ok=;
 b=rwRHta6Q8dIvJYNtbB3XbdlUqBRE427upvcJDX9BVdkGq+1UBzvUhtPMAwYOJuidpB
 morHAn3c0zi6NdWRoaAeg7Hwgf2or3vMPO7GfbWdBHc7ebNWODx/rG+CLLiIHtRlsH/N
 b3/T2LVp7CTvFBA1nS0T/KNZIT2m9LeTAB160xOlqCRREovbqr2s4mg+0INjglX2qVaU
 4nCe9dzJ6Fk8cN1i5Z2Us1ZYZEBG8T0YY9kLgwomlC6MEVSqg2XMvj5tunjyNAtbgAKR
 QF26YpcM9Bdl8BZnp9KkMB+Y9OdLebAWCZ3qnvJW7sH4MREkQ1UTEzscBc7q409VqUfb
 jHoQ==
X-Gm-Message-State: AOJu0YwRgSuQbR0e5cAIrxMnK2ydgNK1qiNLWiLJ3182uFrlk/Dot/Ji
 dPQtx1VBY6gNoVIOW2Fn9GMEENEycA93i9nXlAYTkHd0nzIZxw8bJfC4mi+T9nGqO5EvQGpt40Q
 UVbma
X-Gm-Gg: Acq92OGRTk30yJUZSY4eWB79ohzWE55qi6P+ahOFk+TFrOXBDAUYYWrgcM83+uvPqhS
 Rw0tkRdyBYkr3BueTjmNS81NIqBsRYM0g5HsouF7ewKUFSITUz1vVDbgRS4Q+hpf7mQRSP5hVEq
 LNZl7yrkye4zmQVO9umlD6ZNuDSxSKjrPVWrvzj/YZgCOSpuVSdKy7BtTBAG1m1eET4kSoUa8+r
 h/HtbTzpmBuCth7yqu1EwnaBtvlVd2Cuks+LvZzjMjpRyp2GLM9NZs9RuaNHf2soBJsRv3EungC
 EwDxoNvq2Npd8ItPVprl4u3/1pMCNAtj5XBNyRHnqPr68VyugriVZJ5+I3pdZyj+3GyG++CjP9x
 n6gEjgbtUuiiuSwuar/H+BmwrmBJVFRGEi3r9HWgnxksrz7UTSvBwm3piYrTUjOTKR35LGvMYz6
 +4nTPKhGU52e2L+etzjP8MGmVpzqQjsU5FT9a63RMAM2mmjEJ+CHBT5UYWSXc600IPzzEPUOs7r
 lkHSZwPjmz1PTGAQn+mvN9OgRpiWarithy5dc9aupY=
X-Received: by 2002:a05:600c:5248:b0:490:cb90:3e00 with SMTP id
 5b1f17b1804b1-490cb903f1emr268478765e9.14.1781107986746; 
 Wed, 10 Jun 2026 09:13:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/71] target/arm: Implement FCVT, FCVTN (FP32 to FP8) for SME
Date: Wed, 10 Jun 2026 17:11:37 +0100
Message-ID: <20260610161202.2235298-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20260609192110.752384-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 59 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/sme.decode        |  3 ++
 target/arm/tcg/translate-sme.c   |  3 ++
 4 files changed, 67 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 3bd57ff350..a39dc6f859 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -509,3 +509,62 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    ARMVectorReg scratch[4];
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n = vn;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    size_t stride = sizeof(ARMVectorReg) / 4;
+
+    if (vectors_overlap(vd, 1, vn, 4)) {
+        n = memcpy(scratch, vn, sizeof(scratch));
+    }
+
+    for (size_t i = 0; i < nelem; i++) {
+        for (size_t j = 0; j < 4; j++) {
+            d[H1(i + nelem * j)] = fcvt_f32_to_fp8(n[H4(i) + stride * j],
+                                                   output_fmt, ctx.scale,
+                                                   osc, &ctx.stat);
+        }
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
+void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *n2 = vn + sizeof(ARMVectorReg) * 2;
+    uint32_t *n3 = vn + sizeof(ARMVectorReg) * 3;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        float32 e2 = n2[H4(i)];
+        float32 e3 = n3[H4(i)];
+
+        d[H1(4 * i + 0)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 1)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 2)] = fcvt_f32_to_fp8(e2, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 3)] = fcvt_f32_to_fp8(e3, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5863a6dbb8..36ae977431 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -21,3 +21,5 @@ DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a02bcc0e22..2b9e41a75a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -865,6 +865,9 @@ BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
 FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
 
+FCVT_bs         11000001 001 10100 111000 ...00 .....       @zz_1x4
+FCVTN_bs        11000001 001 10100 111000 ...01 .....       @zz_1x4
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 49eee95d88..76bbacfb6e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1572,6 +1572,9 @@ static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
     return true;
 }
 
+TRANS_FEAT(FCVT_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_bs, 0)
+TRANS_FEAT(FCVTN_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtn_bs, 0)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
-- 
2.43.0


