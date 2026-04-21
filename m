Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22C1F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Se-0000YJ-5q; Tue, 21 Apr 2026 01:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rs-0008Dd-UP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:01 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rp-0006fC-Kc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:59 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso986451a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748496; x=1777353296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCib0BGYEL+yIv2p4qc75g1dc9HJbacYoxAIh15CdAM=;
 b=wp31ysLyLoOsgdlw2Wtc9zp6fEsmC29JyXKZSRdIy85ScQdglBxTvhSZAZj2/uSlxx
 mXFikPf2XmRxoxVtKatIqULrcFWxDVRaGmGgWapasNthNWLhfVQHMRhwIcc602NDdUf9
 1QPFU+k56k+P5TSHVfteYm30tCvn7FT8FrSOwM5PFbGeG8ss+dJ4UhC9RufDo+Q69Ac7
 /GJWe1OltZG43lTIa3WHCZyryYf58aJiKwbzJP9/X35HJz+NdUrdk8m/IwY2SAvoFF59
 i5vSI7Izpa7lkRul/WKM4uGqbQWAwbADLerDvJeIF1+9vMCh7qk/NvpLn3yBVJ68A3bi
 ajug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748496; x=1777353296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCib0BGYEL+yIv2p4qc75g1dc9HJbacYoxAIh15CdAM=;
 b=J7AcCkrQlgyr++vMBFIoOA+sHxujvNmhveBTQ+QIdo4VidDna+3j8wqCv1sKG59A1c
 RpjHA5y8bZh1rqIxIcYzyNSJ45g6KXftk+k0BakyuIj4fIea3RZqx2fMkZvTCj5DJ+yK
 wtv3BRT6/ZGgKzViRwMNy/nh4AEUgkRdWml47f/iKlH0QlBb+dzTMeFF/4gZTllrW42f
 xdxGtDhk+l9Nn6tA1aM7gaEMwSMHARBMlC2rNzA25vA4eXwpRD3gwA4gwzPBAB6Ur9ir
 3+KUHoDXU4XnJy3463bb2GTDBnqQ9bEOxFMoa1oFfQuxh+lu9I8YYkLV6muYCLf1Ps4Y
 T7zQ==
X-Gm-Message-State: AOJu0YxDuo6ad17NgJXUIHxfrw3PtCuRRWRTtp3zg+FnFPpHJcrlm6c2
 2JAQc9/eX8ApDq4Xa9PT9hvrWRTQRqp80hwHrd0RDSr0EeXEXCNlds1UmPFBiaYIVh7TVPqCLQw
 unHobNrQ=
X-Gm-Gg: AeBDievfJaOKCQS6WuEyVsC1HTwoUxWbaMX9DSQry33pnziaUV2UneGlCOF/RcPr0Tp
 3Xdc8wpUG+HG73S3MZPayDVZso8Z+Trp4ioEDBlYtxFMM8fs9PBaKlUl2ivLjhHm8N93bBmf97V
 Wr3mN8u5WHPokGBiivyG+OE53/hquMTmdeqe5sg2StJZHN2FppdRcNVKGE740BtBGTtXRWbIH0y
 p5Y+Ia8On/72rYrdy0jCwI2+UFlg54aS7ZeTYb3uufNoYXoK3t4/N9pJ0iLJUeuEOqMXwXappO1
 z7qv7M8hqqrp2RoNirQHxA2VqSDuAGt/MdhAB27DKNH0iEuMMqotmkRpSmuMxhjzmeY5WFzYBaT
 PjCkChhLO58oGzJ831aF6+O3uckOHRDgaQa4x/FQvoZkcyhr50Hk8YY9JEifmTIbW+z/+0LaVAI
 iJCe18xTltJJgkhI7G0zjD3jrYh66tBfwQp2+x4bkX
X-Received: by 2002:a17:903:8c6:b0:2b0:c45a:bc2 with SMTP id
 d9443c01a7336-2b5f9eddc7emr181652405ad.16.1776748496151; 
 Mon, 20 Apr 2026 22:14:56 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 27/37] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
Date: Tue, 21 Apr 2026 15:13:36 +1000
Message-ID: <20260421051346.41106-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  3 +++
 target/arm/tcg/a64.decode        |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 966f83d796..718463422b 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -7,3 +7,5 @@ DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index daf9c35720..ed4923b1d5 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -91,6 +91,16 @@ static void bfloat16_invalid_input(bfloat16 *d, size_t nelem, float_status *s)
     float_raise(float_flag_invalid | float_flag_invalid_snan, s);
 }
 
+static void float16_invalid_input(float16 *d, size_t nelem, float_status *s)
+{
+    float16 dnan = float16_default_nan(s);
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[i] = dnan;
+    }
+    float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -122,6 +132,38 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     clear_tail(vd, 16, simd_maxsz(desc));
 }
 
+void HELPER(advsimd_fcvtl_hb)(void *vd, void *vn,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn, scratch[16];
+    float16 *d = vd;
+
+    if (vd == vn) {
+        n = memcpy(scratch, vn, 16);
+    }
+    n += ctx.high * 8;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = float8_e5m2_to_float16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = float8_e4m3_to_float16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d, 8, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, 16, simd_maxsz(desc));
+}
+
 void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d23d1a0bf5..b3fbc5f193 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10642,6 +10642,9 @@ static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
     return true;
 }
 
+TRANS_FEAT(F1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, false)
+TRANS_FEAT(F2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, true)
+
 TRANS_FEAT(BF1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, false)
 TRANS_FEAT(BF2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, true)
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b7aac148f2..26d31d0a33 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1910,6 +1910,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+F1CVTL          0.10 1110 001 00001 01111 0 ..... .....     @qrr_h
+F2CVTL          0.10 1110 011 00001 01111 0 ..... .....     @qrr_h
+
 BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
 BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
 
-- 
2.43.0


