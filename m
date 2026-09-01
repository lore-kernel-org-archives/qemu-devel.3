Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF97CC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONc-0001OJ-TM; Tue, 01 Sep 2026 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONZ-0001E9-SV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:21 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONY-0007KZ-4n
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:21 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c255acff671so671654766b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268699; x=1788873499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7EpQqs/EO1u2Z/s0CO7u5NFiL0ls0KxxXzXG+ncCo6U=;
 b=UkX/f9BBdkICZreWFxsueLXH4ECf05YC2aiH9ngVevncP2jVcUC4uJuqN868QzGIjA
 HLqE0npX1o04cGEF1WRg1vCLjIXgjGL/B33o70JrSOJOvJCDwQUpiYMJvANkJ89rn2ba
 mn8fChBt9GNR1ZfyU02T+JsUf5wM09c1Uhck+4fnPc9gdakm3gaH1YJT4vmCyaf5WBYp
 p1qHu0sPbsV4ITFV/SeSqpqwcLzbTpR0fybzU0Uwu7Xb1PF0ZPZmVTRgzFC+4ztKr9UZ
 2EGCjkEjiNqqHGWpdHnhP+djqYFa3wciGc/UIHH2AdguUwjXSkH5Louv6sRDDRZCVIMW
 mPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268699; x=1788873499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7EpQqs/EO1u2Z/s0CO7u5NFiL0ls0KxxXzXG+ncCo6U=;
 b=mdmmHxkg+38wpGr3bk07O8s6IF6x0YDEGQRnuzKtYozGix6+ofmxFWUAdnwSdwgJ0P
 w3hy/rY1PlqGjWFbp0mMweG+ftVfNXY4euo4Tt+wGoDdvxfu8YO1j1H6QoE7Li/yMaUD
 7n3Hx2yQDyrPZylSJ9qGdc0R1x3EROLjf7BWKSvHLvsL1LNsLnTlzLLyy6E4xB6n9BR6
 Slft4pgs//XHUJHUoJiy0VZVraQZ1tfW9skZdiCbLsMQqXoi2oQfEDkI4Y4cctJ/n6Z+
 +aB4VmpP1pIIYWI3SXwwF4dZHUIIdk7VJkyHRboSDMJ0R07FpgXZL2WQeYdusXBB34LO
 olcA==
X-Gm-Message-State: AFuF++npKk5CAlZRKxl8TQBhFACnSUqUG6BbCJq4qQZPiB++TmGSSsX1
 hH209imnN5Tm5Rn/oleu+BICkHyDIFfTByxdjyVCPyovb5B1VvRvFtmGRL15Q8uJV0mMbkz4rj5
 1OM9Qmgo=
X-Gm-Gg: AR+sD10Xb/bubTKKizxt8tgpokSzNNLDmsw0DEgV/ObNOqJ3yUBjOfhzB3Lb2vGjx3j
 BABlaM22+US0rGt+97LCXaFOnzWWB1qtaokZOez+faCVSOH36VN1KjMEIHd2RARUjDOCnvmpRWo
 8FK9Ox0/o6nMiyi2BwpO6m6+kO2LNRGXpUrB9jxM5CU5DN97DMvVcZBttNPk9Kqs0edissZa9iA
 GJFAxVIkDw37OTWHhHriH1HSbZUbvADmEqhEwqs78/YDnS9SzMSyN1XLhcapw1wk/nHooXc7inn
 lGn15TJiRR0oHNb7vHuiwnY1w7RJ/BZxrJ2yoFcMco+uLTB67sprjifNvMN7Ngtkgn1YqmY5lYT
 KI7DUBM0erXEp7uwF360awEWHVebzdbp51r/R9oK4P3sRv1ycGYvwJ8S8Yz2tseBsp5bFbmmY+F
 XGkGBz1r5FHs5mSTH+Zrb5of8LvL2FQyrD/z/lRisaBlJqNVel+2Me7BQ8E5u9+DfEXwMPteiad
 upEZdCTFeiwdj49QhgzSW4lcSxPghdvBVk0vfqM8xEUHeE+OgenE/5ANZamOYdvyRyLVD+ff8E2
 EpF0
X-Received: by 2002:a17:906:9fc5:b0:c20:f4ee:7c97 with SMTP id
 a640c23a62f3a-c2556c19e06mr2197125766b.5.1788268698616; 
 Tue, 01 Sep 2026 06:18:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/58] target/arm: Implement SME BFSCALE
Date: Tue,  1 Sep 2026 14:17:19 +0100
Message-ID: <20260901131732.2263947-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Message-id: 20260826174213.614571-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  1 +
 target/arm/tcg/sme.decode        | 20 ++++++++++++++++----
 target/arm/tcg/translate-sme.c   |  4 ++++
 target/arm/tcg/vec_helper64.c    |  1 +
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 60463a67431..07507d263e9 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1877,6 +1877,11 @@ static inline bool isar_feature_aa64_sme_tmop_f8f32(const ARMISARegisters *id)
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f32(id);
 }
 
+static inline bool isar_feature_aa64_sme2_sve_bfscale(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sve_bfscale(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 12f58c6a442..c1e5d86b272 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -151,6 +151,7 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fscale_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 60c7cacc10e..4e19c42b196 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -287,8 +287,14 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
-FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
-FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+{
+  BFSCALE_n1   1100000 1 00 10 .... 1010.0 01100 .... 0    @z2z_2x1_e0
+  FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+}
+{
+  BFSCALE_n1   1100000 1 00 10 .... 1010.0 01100 .... 0    @z2z_4x1_e0
+  FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+}
 
 FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
@@ -365,8 +371,14 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
-FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
-FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+{
+  BFSCALE_nn   1100000 1 00 1 ..... 1011.0 01100 .... 0    @z2z_2x2_e0
+  FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+}
+{
+  BFSCALE_nn   1100000 1 00 1 ..... 1011.0 01100 .... 0    @z2z_4x4_e0
+  FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+}
 
 FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 463754b057f..d28574a8cf0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -890,6 +890,10 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
 };
 TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
 TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
+TRANS_FEAT(BFSCALE_n1, aa64_sme2_sve_bfscale, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fscale_b16)
+TRANS_FEAT(BFSCALE_nn, aa64_sme2_sve_bfscale, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fscale_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
     NULL,
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index d8b25b868ea..88799693507 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -179,6 +179,7 @@ DO_3OP(gvec_famin_s, float32_famin, float32)
 DO_3OP(gvec_famax_d, float64_famax, float64)
 DO_3OP(gvec_famin_d, float64_famin, float64)
 
+DO_3OP(gvec_fscale_b16, bfloat16_scalbn, int16_t)
 DO_3OP(gvec_fscale_h, float16_scalbn, int16_t)
 DO_3OP(gvec_fscale_s, float32_scalbn, int32_t)
 DO_3OP(gvec_fscale_d, scalbn_d, int64_t)
-- 
2.43.0


