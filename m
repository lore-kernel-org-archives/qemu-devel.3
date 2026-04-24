Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D747EFB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8De-00038J-Vb; Fri, 24 Apr 2026 00:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DY-0002wR-Fh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:40 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DW-0003cA-JA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:40 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67e0d3f288aso4596861eaf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005157; x=1777609957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WADg8Bv+oZ53s3C00yS+/mTr8WhaGyfIt8vkJcIP8Zg=;
 b=HcMIb/bE3x3f4MXgaO+WrNpxTBRBcHZdXwvnalzokLswK6IzsEMH4PCbgGdjQS+OKl
 bmeTqRwNb7guNSKWIjS3pN5ng7AROti309U9DfP3Qp5r3pQefb/YdU82SQn2B/7gKC1j
 L9JDQhzVrkblE1Xkg6BBmFHPzIGZDGYYCbvshxV1lSg5iOiC4U+10A6zhF5ycISGPB/k
 tFXSkphkTAihMRkQb6jJPiYfvQpyKzyPGP/C6pfxJvbKrSZ7GNfn37XblMIB5Y1vxRTr
 JMclhSB4HldyT3RUBID59jVFMdaetiF/0XAdRxPravnSsDQZq1wNJpqrifwN+8dWmnX9
 7HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005157; x=1777609957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WADg8Bv+oZ53s3C00yS+/mTr8WhaGyfIt8vkJcIP8Zg=;
 b=RGoFPP3dPVdIXfWITJeHBOs4yxvM7wntQB1R4hsmg9u7W2Z+7uKGxtmRhIqTrridK7
 GggP1/EIRL5GtR+y8dBF9NO+mbIK0iSwBk40bd9adv/iNDKTICprh90Irz7Co8Ho0+69
 Ke7ZvUjSkYqzdd5nPSc2ihXHt031sBrnMzkAqFGv75PQcQI48TDy+6OSGmpmFZCeViTi
 pSTkgK+UKv2rY9eEd7pt6aaIdsK3lOuVeRN1p43c2WNxyd/SL3FGW3nAlW7ORd5+b9Co
 o+oWdYY5SY6NEV7NexTT9rha9C+tNtJAVFRwM/WsT35mddgnUnD6FjeM9eZvRwxH86tL
 wCJw==
X-Gm-Message-State: AOJu0Yz61xsbSDc9p1leh8FI9b/kwKS5gAPe7scq9B7bcamu3PuIx6TU
 b3rCR8HPb8kq/0g61u0cC+I97L1Ok/71juZnhdCjPvaEHekToufE7kBveDZ62iwouawWau3v1h/
 RgQF8sDg=
X-Gm-Gg: AeBDieveaFPh+gNPwreq74T77oLyMceZIAAUUKhiZi7bSkD588fvA/n4fECVMPi3I0N
 J4joOs/V1Q1aODWGiyll8vKn1CY4UJt91vqFIbUoMZ9FEgCY9Pcoyfq9aEw20jCqgrrLFhZ4sai
 MzdgPFImwmRBguw56lwrT6e2V8zbS1L375/CnqjpDjMrhLvAOsdUezWopkWLc94zNLMEyqS8Ry7
 FTlulcUB1vsot+lwDPKSNnIKn0yMf1oyBE9jZpmPi9zlEj1fzX+GsaT5Y0AP9oQjiQbNp6RJKYU
 hX7VHIgQQ3BGB2ANNOjuUNwG8CNhYd28JuwfWgSH7vYEHwA4KheyvupZU6ny6KSvAzeDlBYRCfH
 fabGGoUJXXmo2oouPUJvjFItyy17oEXwZ1r30PoDdPIITm/Syn+Yh5Tqd2RZThO1g1XmnT9A5YZ
 /tlsgVK9fcc+hTqjHKwFQyFuqGCBWNfMHNI3rt/eu82xUWaaSJSv5TZ1DMdioVHg==
X-Received: by 2002:a05:6820:c0cb:10b0:67e:36e9:79ac with SMTP id
 006d021491bc7-69462e6234dmr12220810eaf.27.1777005157324; 
 Thu, 23 Apr 2026 21:32:37 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 34/40] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Fri, 24 Apr 2026 14:30:08 +1000
Message-ID: <20260424043014.46305-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
 target/arm/tcg/fp8_helper.c      | 85 +++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c   |  4 ++
 target/arm/tcg/sve.decode        |  2 +
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e67fb191c2..5863a6dbb8 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -19,3 +19,5 @@ DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 9bc1349950..ebd448b466 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -520,7 +520,6 @@ void HELPER(sve2_fcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
-
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
@@ -562,3 +561,87 @@ void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
 }
+
+void HELPER(sve2_fcvtnb_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            d[H2(2 * i + 0)] =
+                float32_to_float8_e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H2(2 * i + 1)] =
+                float32_to_float8_e5m2(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            d[H2(2 * i + 0)] =
+                float32_to_float8_e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H2(2 * i + 1)] =
+                float32_to_float8_e4m3(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        for (size_t i = 0; i < oprsz; i += 8) {
+            *(uint64_t *)(vd + i) = 0x00ff00ff00ff00ffull;
+        }
+        float_raise(float_flag_invalid, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            uint8_t d0 = float32_to_float8_e5m2(e0, ctx.scale, osc, &ctx.stat);
+            uint8_t d1 = float32_to_float8_e5m2(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] = d0;
+            d[H1(4 * i + 3)] = d1;
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            uint8_t d0 = float32_to_float8_e4m3(e0, ctx.scale, osc, &ctx.stat);
+            uint8_t d1 = float32_to_float8_e4m3(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] = d0;
+            d[H1(4 * i + 3)] = d1;
+        }
+        break;
+    default:
+        for (size_t i = 0; i < oprsz; i += 8) {
+            *(uint64_t *)(vd + i) |= 0xff00ff00ff00ff00ull;
+        }
+        float_raise(float_flag_invalid, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 319a28e94a..eff3e71ade 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4102,6 +4102,10 @@ TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_bfcvtn_bh, false, false)
+TRANS_FEAT(FCVTNB, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnb_bs, false, false)
+TRANS_FEAT(FCVTNT, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnt_bs, false, false)
 
 /*
  *** SVE Floating Point Compare with Zero Group
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 806953bc35..7fce189b36 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1103,6 +1103,8 @@ BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
 FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
+FCVTNB          01100101 00 001 010 001101 ....0 .....          @rd_rnx2 esz=1
+FCVTNT          01100101 00 001 010 001111 ....0 .....          @rd_rnx2 esz=1
 
 ### SVE FP Compare with Zero Group
 
-- 
2.43.0


