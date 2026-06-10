Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838E9CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYl-0003tD-0x; Wed, 10 Jun 2026 12:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYj-0003nD-Qp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYh-0006c3-R5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:41 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so5012669f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108018; x=1781712818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TP9hyBS1DKi+7ewnFjYuFQH/JqHtzxVX015tWhGQqUo=;
 b=J5y8jaFQVwCFYKlFW/Ql+uLaebmWKXJJE8Pw88YnodZU15v+RAb9FJSKvSJU6efIYJ
 yOTd+GEmd7he3jX34bLA2OU1TgXXLHTcj2Xp6Vq7E0JUCNr2Z6g+faOZrHQ5SdAbNoWF
 iHz7SektXS8Ng4ajwxLngLeZ9xjD6hPezpNwWKdNwsBNeKnfXfki/LlJZnzvmwQJZ/mt
 M2CpWudwKnWCC0B3XhWno/cgEatb8ZZgLK82oD+QgtyX05J6wRMHp5PH5fPfy3jsmLBx
 QfxFmoPQGwAIE26DrPo1SRrpx5gGOynm8Cpi9kD8gjtXJo3YeZEGLiiTKWBr6L2DTuSG
 pyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108018; x=1781712818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TP9hyBS1DKi+7ewnFjYuFQH/JqHtzxVX015tWhGQqUo=;
 b=n8Sf767+/fsiS0hA3Z4rWlXvedmd5M4ZoEqKduVSUfZEU2iGYiF0xWQTRUI0HCF30b
 dxnybEzqC9ph7bwwEd64BJ9ZWWin+L95hMsYyrVMyE7JzrCK1qbDuLCGPymFIYSmjzPx
 FCDpLgdS+jreEX2U3bP+pbXN+HC6ywSHVcJeMnIIAFPG4OjkzaBLoWRtT9S6c2YBFqD1
 ffhkzCFYaa2caW+1lTKmooDbTbcOObyE0YN+g3pmRhxW90qAG/spf0DJzRcKg1GoP+GU
 VRbB4vxoZ/ipfg/67vowrMjNm1lY5Wwjr89RCQhuNBmjw/wE9ntnwr+WTYZf0DYF+sOD
 Mofw==
X-Gm-Message-State: AOJu0YzzZNC3XfMwFWgmJP0PY05hDpWBLRD7GyDRaWWcTdt0isF2uAFY
 h8Ux2Qo+mOIxaiC0BFIQ0uZtaBh4+Ulg47VWI67A9Cy81jIIan6P54Ne8rviYulzxsgAGL6/847
 +BdCX
X-Gm-Gg: Acq92OHX1kj6KROi6Hduacphqvv/Ld+OV83CyaGDEK71liIFc85ig6n4913T/CTl5O0
 73hJd3DNtWf1Z0En1syX/a1cEqD3RyLDOyWyCDbp+Vj+63vkHgrmXgmFP3OMNyvnOQncRns4Ftt
 dc0CqWD9lSPHGnXg22jnrYc2n/Cmnd5VKRWwl6D8arTMUOpI++pm5MjGRaER8EtNjrnQkcDgiIs
 xKFr1S2FjoEZJ+uikmggxZerm6GJVCq28Ud1EjkRlp25jvEnIEa3M12rxLk0HUqlSJgF+boJ3qY
 l3unaoFtnG2afQ1RhvS0pZrCyawmXpp130JSxGGgPBCyyOEGz2wodctsam0xTnszV95w66wtcHW
 YpUiQlxQoU3XpB+12J0M87E9f5PPpxZ31/+cFxK1v9OcdomNx1aXUXSvJKMXdfTg0J7mi1xk6i0
 3oid4ELHfpvZ57Wy+++tP1VEC0HArRgiNtMAlF296MC1LdNRl1ndja3odFFgaqzlf8RCaSXAbUR
 iS9Ap6y8HyXyJfyZ54VM4qD6L0VuTLRpCMnMxgWBIE=
X-Received: by 2002:a5d:6644:0:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-46030501958mr28143153f8f.23.1781108018293; 
 Wed, 10 Jun 2026 09:13:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/71] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Wed, 10 Jun 2026 17:12:00 +0100
Message-ID: <20260610161202.2235298-70-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Message-id: 20260609192110.752384-44-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/a64.decode        |  1 +
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/translate-a64.c   |  1 +
 5 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 67e9c3bd33..753799008c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1650,6 +1650,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6922e91010..28cd1faf61 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1228,6 +1228,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index b9d4ba3b6a..bd0877071b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -832,3 +832,28 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 8;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[H4(0)], m[H4(0)], 4, d[H2(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[H4(0)], m[H4(1)], 4, d[H2(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[H4(1)], m[H4(0)], 4, d[H2(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[H4(1)], m[H4(1)], 4, d[H2(3)], &ctx);
+
+        d[H2(0)] = d0;
+        d[H2(1)] = d1;
+        d[H2(2)] = d2;
+        d[H2(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ffe59b9471..227719ef25 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7516,6 +7516,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
-- 
2.43.0


