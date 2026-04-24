Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8818FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DO-0002R8-HM; Fri, 24 Apr 2026 00:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DJ-00026p-BG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:25 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DH-0003Xu-Am
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:25 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-42fe552aedeso528782fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005142; x=1777609942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMcr01u60LrCES988dBDvl79mkeVcUNH9ZYKZAUuh5E=;
 b=KL+pV7E3KGebFNDe41gR+k2rdkg59o1eI6nSk6bBfFIxJNYPdc5EZIBUsOLpKOK7gQ
 64r7Qqvn8A90iG2RRQznndqhRFwMNS1BA9X4iR9X5AGIq9q/jNdDx9OPjzi3kJhTwMUF
 2skpOxKCySCu3XGY84My9Oa6X8WENPksjSZdECuKekStrYk8VuVjokCj8r607UFvLgQt
 N4whKu4N0unrH6ISkkN1Gzl4cot7M0LWPPLQmfxp8y1uSGfS/13ZS4yiApOTuVReQVmk
 TsTpR6F4qaJx9LCO9AaXvMnVo+dN9WXOC1zzhFoQV5xrYpzea3sKXJOgOIQTLZqn9SAr
 1C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005142; x=1777609942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMcr01u60LrCES988dBDvl79mkeVcUNH9ZYKZAUuh5E=;
 b=iBToAcQ3/z/ju4K8FfxeeT74vmJPh6iwLroIyOeTBXY2sYzzwnqiPhlRQkgzHwA0pV
 AbQkEaio2DtXb5X/QfKibWVTG5IHuy0iD6SuF0YuD9uutYai3IeICr8a39qknvft0+qo
 PXLy8MVYFTJihbnB+K6yzpqZ61k9WCk+hGqQmmSwTEI6kI42DxmBF2SollFlL5CjbfyZ
 6HBBWCc6kn3nUpN1ou4We8K2l1aUpFgZbC0g1gdCGdBMJrbSvpILPUJF4WFEtkzDi3PE
 5aSFLYCmL+0rVh5B/xG28Gr8xs74Qa6vHQ085QY8d6taj3rKfSYrjneGIHN1jV/c4Ruf
 vpvg==
X-Gm-Message-State: AOJu0YyrTwcsf0JJtkGCX4SM0Zaiq/ccg5dpa2r4jNueuQpLZ2VUy05C
 SMBz8XAdAxFNEgrTWb5BDjKLy8t+4Y+JYyJ7BuEolbFAQyXwNuW4mEBM0NXS+m+2t659DxqfGsL
 /J7Kk5qc=
X-Gm-Gg: AeBDieshzD2wRKbO2oIBCNCQVqB720/HkGtM0ZADH+JdGGYavx4xPWB++aP5gOTwotX
 NoedR95i7jjlSqOblc0m3N7yR5V/04xOaRRXW20V5eBaYVkO4Y+uGyfoNoOXwoRqDnhD/xnTZDt
 aNc8kdGBBKMYeNgmc/Hktl7/KxobyQUKDlaWPSG0h156qKGKDeyxzygb0sJhfCPA5opOm+sqoVP
 9wvvWAej05x+sjzHUnWdioBE53DipMg0c4mNJ3xckTdk8Z1V9WIzW3axWOsalR7yoTfQnowPMC/
 TeS4zpjeD3OxDuBNZ/nSBz6fFzlMr6b+rn1/9EEN567NsB37EF8+3Lw3W0uTau5uEapediJucNQ
 Rv8V3tMlRhp0/96qCONAkEpN8sxRjmQZaVbrk7e+jOePc3767dCFu++oQ0N18ELKaarcP8HyX77
 omPcQrGyuTMv9YPNMxBk386+eaOw+CNoyfpBmSOBrSNb7/fhX6VvEtmAKvEbHQmb5MW/0H0QwA
X-Received: by 2002:a05:6870:968d:b0:42c:1cbb:5f5b with SMTP id
 586e51a60fabf-42c1cbc662amr10115100fac.31.1777005141917; 
 Thu, 23 Apr 2026 21:32:21 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 29/40] target/arm: Implement F1CVT, F1CVTL, F2CVT,
 F2CVTL for SME
Date: Fri, 24 Apr 2026 14:30:03 +1000
Message-ID: <20260424043014.46305-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/fp8_helper.c      | 79 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  5 ++
 target/arm/tcg/sme.decode        |  5 ++
 4 files changed, 91 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3021dafd44..b5dc2b7064 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -10,3 +10,5 @@ DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 32c7a82647..2b1955508d 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -264,6 +264,50 @@ void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
+void HELPER(sme2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vectors_overlap(vd, 2, vn, 1)) {
+        n = memcpy(&scratch, vn, oprsz);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i)];
+            d0[H2(i)] = float8_e5m2_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i) + nelem];
+            d1[H2(i)] = float8_e5m2_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i)];
+            d0[H2(i)] = float8_e4m3_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i) + nelem];
+            d1[H2(i)] = float8_e4m3_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -298,3 +342,38 @@ void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e0 = n[H1(2 * i + 0)];
+            float8_e5m2 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = float8_e5m2_to_float16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = float8_e5m2_to_float16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e0 = n[H1(2 * i + 0)];
+            float8_e4m3 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = float8_e4m3_to_float16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = float8_e4m3_to_float16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3e1da83535..29d116a57a 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1545,6 +1545,11 @@ static bool do_f8cvt(DisasContext *s, arg_zz_n *a,
     return true;
 }
 
+TRANS_FEAT(F1CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_hb, 0)
+TRANS_FEAT(F2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_hb, 1)
+TRANS_FEAT(F1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtl_hb, 0)
+TRANS_FEAT(F2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtl_hb, 1)
+
 TRANS_FEAT(BF1CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 0)
 TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
 TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index df9586c1a5..d6192eb59d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -853,6 +853,11 @@ UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
 
+F1CVT           11000001 001 00110 111000 ..... ....0       @zz_2x1
+F2CVT           11000001 101 00110 111000 ..... ....0       @zz_2x1
+F1CVTL          11000001 001 00110 111000 ..... ....1       @zz_2x1
+F2CVTL          11000001 101 00110 111000 ..... ....1       @zz_2x1
+
 BF1CVT          11000001 011 00110 111000 ..... ....0       @zz_2x1
 BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
 BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
-- 
2.43.0


