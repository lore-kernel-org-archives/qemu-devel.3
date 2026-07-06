Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA5EC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggis-0007e1-WD; Mon, 06 Jul 2026 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggie-0007DF-Tj
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggid-0003UL-3t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493b1710405so17303405e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334310; x=1783939110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rs1VDjr5PB3VP0zb1dNRY2Ym5YO2bAgk5HVrjMi0WPk=;
 b=dGAqekcJjLfjxzBN+vISZEHi1UiG93SLdzlwOGyMRTpJSDSn5M/V4SrzgEAR0h86Y2
 /EOZn1MA//2TuSDwuNhCYyOvmr/zBKEdCHssyU8NfLTwqkJB+3EgFkpHhDgBgiXUy57A
 0iLrD7no17vNnNTWKFi5kcpaZdun1JYh2ZaU0wSz8puMMdhk9kDYPPZfQfrwKADaaRMB
 7qyc/Guv5tBzKqSYbEKUM6BNGp3MNU/U1r+SPqH6+8pFHlOiBSnjdqlGKLsJ5fsAZHfr
 VmReK6uvbsIS5DawmHTw2GmRB7qY4M+9ilKeOIxSACScF1SMbYHMgJPuYaMF++kj14VA
 BdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334310; x=1783939110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rs1VDjr5PB3VP0zb1dNRY2Ym5YO2bAgk5HVrjMi0WPk=;
 b=sFrWTqTNaxEzvcbZ3QW/JhuDN2n5gySStOf7XcG5gAZaOe02Wi9jnzlyt1fVN0vt3r
 KlEuet87OSIoZVsKwuKqbrrQSfjvT3j7ay+ll4gkqF6c4cKrysbZHci3+BHUGAD+TA4/
 xTckWhGNEtBcKaebmHH7o7nM1g3GRlZDuWvB3GA/jh0yFZO7Cl7gcG1N2q9MkysMssRP
 UzzYEEVlXCsTUA2xZBo6SegiG9j9tA87ODghKDupDHuzLgxL+KW/Imi/eTKv49EI2v7i
 X9pajHE7SJLKKLi2fugOuSivYvDaC+RVLgPxVey8qoYZdwNBirKARyDIB2OTsDGh5TFr
 gVww==
X-Gm-Message-State: AOJu0YyXn2DAakbEpWJBFFTMYYE+VdpOds1bNcI7h98dBdh/Qb2rJ53q
 I4OyOEW+Wu9hE39w9peiOfZP0rziY4tDw9s3gZeSHKxEx5W+FcuWvcv2Hg76TbAmT8LbaOwQpSp
 iRrYpaE734A==
X-Gm-Gg: AfdE7ck4t6tYgYlLqgyIkBICzV4xCAkbyePOfsOuBQDn4902IE1fkP8y8Ux5dsCOw7L
 ta/RHbAe/VJG1wjwX/MfG6NFIYwK7JvgyVV161HSq6WNBp3KUC3CPGgtyMAMhEUof+RnKhxttp5
 gowARw9F2iMgAeMoFPmL8hfy99T+5yGC/ZMDKFyygrD6OG1k3yG7bvhC7mEEK6WHfy8lFqmKHZ5
 8whrl4Kvu7upXUYNSW6mzVbFFiZIVouUNgIaDXLiUxpc1piFeT7PtCtA9DISe8lRjrckgNvq2sq
 ZgZdS/4sG/jUrsvk5qjDSj02UjXIAKmDnyuNCoQK0Mxcs4AelSrFP4mGS/aGoPgiWBipaf4z6gq
 s6cKYXcj0wiAg3oHZ72X3YpiQBSbkJmO2bK+/v4zkkOTiQ9CbMa8bSsfQo5ywC3lwu7l5GzFR8p
 WgHoLq07sXMoySBDoeftYqa2v43qN9hbnsx4XBj/u7ooN5m9y8mOAILdnWlsZUOjrgN/Hf+hkL/
 BNk2eJIKHNPCLd0aG9kYyZJvo8c4YVJ
X-Received: by 2002:a7b:cd13:0:b0:493:bc4a:9547 with SMTP id
 5b1f17b1804b1-493d1204c74mr77508365e9.39.1783334309644; 
 Mon, 06 Jul 2026 03:38:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/49] target/arm: Implement FMOP4 (non-widening) for float16
Date: Mon,  6 Jul 2026 11:37:35 +0100
Message-ID: <20260706103752.320511-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Message-id: 20260702204314.79224-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme.decode        |  3 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 5 files changed, 62 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e480995cc6..a1a4f37277 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1807,6 +1807,11 @@ isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_f16f16(id) || isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 9e1f09ce5b..ec7389d2ae 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -356,6 +356,10 @@ DEF_HELPER_FLAGS_5(sme2_sel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 
+DEF_HELPER_FLAGS_5(sme_fmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sme_fmop4a_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5a3d47cdfe..227f3d7790 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1094,7 +1094,10 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 %mop4_zm        17:3 !function=times_2_plus_16
 %mop4_zn        6:3  !function=times_2
 
+@mop4_o1        .... .... ... m:1 .... .... .. n:1 ... . s:1 ... zad:1 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn
 @mop4_o2        .... .... ... m:1 .... .... .. n:1 ... . s:1 .. zad:2 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index b08d91e6de..c4d149f7f7 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2636,6 +2636,48 @@ void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
     }
 }
 
+static void inner_fmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4a_hh)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4a_hh);
+}
+
+static void inner_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(float16_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4s_hh)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4s_hh);
+}
+
+static void inner_ah_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_fmop4s_hh)(void *vza, void *vzn, void *vzm,
+                              float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_ah_fmop4s_hh);
+}
+
 static void inner_fmop4a_ss(void *vd, void *vn, void *vm, void *vinfo)
 {
     float32 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index aab5eab9df..d19cd274ac 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2025,6 +2025,14 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const fmop4_hh[3] = {
+    gen_helper_sme_fmop4a_hh,
+    gen_helper_sme_fmop4s_hh,
+    gen_helper_sme_ah_fmop4s_hh
+};
+TRANS_FEAT(FMOP4_hh, aa64_sme_mop4_f16f16,
+           do_mop4_fp, a, MO_16, FPST_ZA_F16, fmop4_hh)
+
 static gen_helper_gvec_3_ptr * const fmop4_ss[3] = {
     gen_helper_sme_fmop4a_ss,
     gen_helper_sme_fmop4s_ss,
-- 
2.43.0


