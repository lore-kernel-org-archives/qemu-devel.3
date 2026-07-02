Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E445C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFy-0006ix-AH; Thu, 02 Jul 2026 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFx-0006fT-02
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFq-0000TQ-Gt
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:30 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3811074a8c5so473938a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025002; x=1783629802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yNna9vlV0YwnvUE578LpD4Ad+UPg4psiWFYJgm3K26A=;
 b=qr1dxCN6xSnyTeLYXIncdqMKu6jljcdWgMKFuZNdjR/xBhNIwZqC2gIqO9v0DeRPmr
 ySMYBleeLR1yCyk3b09xo42p7Z/Me0tLRlAAcfBf/L24uKlzAd0V6o6Bb7/ic1RptcwR
 CGVqTu6iyJkcFdQDWYy9nJar0ALdcHBkHqbvWnFMT5N3PNMmO4jUb66i0uakpV/lfXTI
 feteQqH5fpVviJEXC3n0FKXNy4B6OKvfl0kSX812QjlFCt/sU7FACD16M+cRq7i7g1s9
 8NTsFT8grTWLHZrS3ekPcyUZlktIfmZ6H52/62leu3i7IQXetCJyN4PQaNG+1UbVLmon
 mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025002; x=1783629802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yNna9vlV0YwnvUE578LpD4Ad+UPg4psiWFYJgm3K26A=;
 b=UhrmNJTa+40gRU57fnGWD7Ww5xFykPBj/0zw2xnTfyTty+QWv98rAOQOQ1m6U+RkKy
 LHCELu8XpJbXloMpka+ggJF1kmu14iFVGsjlTTFfRXaZCgp3IeeDw8KRUTG2HTM8IFJ0
 KDPnrnB6gfzaKzFTsbU36I95exVj6jMQB4dUUFIgxsKVc0TGOpteMaYwCTD6q9rpXvBy
 /cOH0mqdbjehdQnea+iKhwa7V8Jl+N7Ax9vXqdbuH3zn5qKCD0+wVzifIFPlDCsCWRjv
 yBf/u3IPgyqanCxuMcL6zsk64clirC5OMZu3DgRw9RLxzkBYV0XEGd9MsfThApflMpd5
 NFJA==
X-Gm-Message-State: AOJu0YyTdlAvVWCdpcd/7v3YLIudtfhNnu04Cvb9C0JUbwT3hx8g94Tz
 Ie+yTjcy4E2hvsjwy942FXjg3xt/fs4Byx42IE1Ej+EFlqKW9uAGNtvsZlqVpmoBX0NRsCdESdZ
 1cC3K
X-Gm-Gg: AfdE7cnpwjblhtbvdw+H1reehIvW0ezK+DMgyQtdsgUx4M2a1nVzaR1+zFB3ui6GOFl
 Vwig6XXOi9taIGPfxW+d1z7/n4PSNTa/bC1nCPzInjqMDyOOBeLlO4/fPQO9j7q/lFR3HnmrLRd
 EgDVkML0mwo+5VR0E3zgk9rxZtPfo0Eh0pfCZwAEhrBqBddorY42KG6G+KcSW9a0m7WU76BoJjF
 AixDw+2XPZKpkmXKncpOoCYK2jIfIjv4Wn987PxUlQuG9Xw5hnseKWN0Qv/SMaPTF6k0ovgGGpw
 yFah2mPqVBIaAtEtkN7SoZEcLLgYPXgV0Pjlh64UY/EKaVPRs9jEbuZNOvncUY4uqvob3lQXQ6J
 FbAn1R4VlgUSCOnMc0gxHdVuT825XQvlVhW1xw7VFFsvUdgJloZRyLAS+O0c6Y8TJU/wF8kMkFA
 v3kVAbD0z/otEmqEnAkOi8oUEiXkgQyyld1RPt2X+2otSp36QVYQ==
X-Received: by 2002:a05:6a21:4903:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3bff411556fmr7654063637.27.1783025002048; 
 Thu, 02 Jul 2026 13:43:22 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/15] target/arm: Implement FMOP4 (widening,
 4-way fp8 to fp32)
Date: Thu,  2 Jul 2026 13:43:06 -0700
Message-ID: <20260702204314.79224-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sme.c   | 18 ++++++++++++++++++
 target/arm/tcg/sme.decode        |  5 +++++
 5 files changed, 46 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d8e0dcd0f8..c7e247e37b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1812,6 +1812,11 @@ static inline bool isar_feature_aa64_sme_mop4_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f8f32(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f8f32(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 126dcadf77..47f35a82dc 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -44,3 +44,5 @@ DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr,
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 902e4b0ae9..f899a6cbf7 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -973,3 +973,19 @@ void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
         } while (++i & 7);
     } while (i < elements);
 }
+
+static void inner_fmop4a_sb(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    FP8MulContext *ctx = vinfo;
+
+    *d = f8dotadd_s(*n, *m, 4, *d, ctx);
+}
+
+void HELPER(sme_fmop4a_sb)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float32), inner_fmop4a_sb);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 544a825595..386ded1b90 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2072,3 +2072,21 @@ static gen_helper_gvec_3_ptr * const fmop4_sh[3] = {
     gen_helper_sme_ah_fmop4s_sh
 };
 TRANS_FEAT(FMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, fmop4_sh)
+
+static bool do_mop4_fp8(DisasContext *s, arg_mop4 *a, MemOp esz,
+                        gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, tcg_env, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(FMOP4A_sb, aa64_sme_mop4_f8f32,
+           do_mop4_fp8, a, MO_32, gen_helper_sme_fmop4a_sb)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ea9f459e38..b8b507d8fb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1101,6 +1101,9 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 @mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+@mop4_o2_s0     .... .... ... m:1 .... .... .. n:1 ... . ... zad:2 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn s=0
+
 BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
@@ -1108,3 +1111,5 @@ FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
+
+FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
-- 
2.43.0


