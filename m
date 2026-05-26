Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF634CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmj-0000tR-Bd; Tue, 26 May 2026 10:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmg-0000hz-Fj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsme-0001Mz-G2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-452169ae568so6891036f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805767; x=1780410567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uiSxSSvXNgeTkOHtQ1PRnF2n1HTHwql5VVMq3OlWrWk=;
 b=QK3IS4Wk9knY+2Zey8qaW46M8C7Bhysg1wsYmaLucPg62bxmknQt9Xpy1Rl+BlvRON
 dhM8oo42+5nJCjuHt8+kKt7YEw8JuUshX64ce5DFs5GdLT6KDitJdTvKoYssLEhX7KSA
 Cb9+YHNVTiOvUkq9CyPvcWfeUbgwm7ecWUip77Z0xjsWamc0SvkVWoq7WEgFOMI5l2JV
 zQZpsesUEPVs9lJoqbfSqPasOauE4G/cj40+dcVFMwHYaMi8R/9opJXK5b4sAcrDUwQj
 0dibbJtKAW6fXBCZW5l7x9VsWmWEh7IwR835vY55QYrRQ7oul9Rpd05GZ+YfXtmgD6eM
 UdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805767; x=1780410567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uiSxSSvXNgeTkOHtQ1PRnF2n1HTHwql5VVMq3OlWrWk=;
 b=oJOtcZoYcdPPlU93JuOyUr/lKtnqRHn5K42Ky56ZJg5gJEOUrBq50peYW6mvHn774S
 CHgytZ4uHp7Rb/E76s+qi+5FyPxLDxqCmlry42nrO6A5kpT8wWj3NecmWZXRJ45wg1Er
 tFBZdMhKJDJIUPEK0iCF4RVmbByoxZjBO3Ri44/gxKhX3avRbrY7USfbNir8O4vDK6sf
 hvjacK4xD7WjbnzTNh8u+9+zvE5FxmZpzoLGpM6WSWRrGlOgVjKtHynQplL6sAYEMbrk
 8Sb1itmvg5M0fkLapqoQbUCOpcQDWAs+SW/ID1O/r6aiHBaYAO9IcWC69+z9BWiJIxPj
 zUdw==
X-Gm-Message-State: AOJu0YzU3SDCz7phl2+mmQKhG1EWbKK/Z10zWBoseNmli3WcNdR4W025
 qQ8gTSsmLxFxYmtog7PsUXpItdSlAezxmfaJ4iccdO1MFKhqU3ZRqhYGfx7FDNkwVUIlxnFiJYw
 0rmS3
X-Gm-Gg: Acq92OGnSy01Rkt24VVvrbOL6Q9lyupuZnK2JQCcjTLilBEsdjGzqEGzJcpCXLNuCcl
 BYRZKAF/pcSU/4KQpq/m+UPuITFpzPNHXwtp4xwL+HWgJt4BsSdSfR9Czi04hJ4rZtI3gs9jaME
 U0Axh5SFyik/mdnfw9x7pz5AAbrERMUqbvf41ZuMo44pI7az9sZkFYYMR7sSTM4l0UcFMS25p97
 H19nUaprtF3tJfs78Jmn5IKJ1hhu4R4DlnPaestyOvyFQDPv9PaSRg2Yx6KgJR5yuOOT99vtJfv
 Jbcnhl0+o4xgzeoMjcTfrBbkolSkcX0BgkKxAS9A69FO4yzXTo8H2fAJbpS0zxpngOO8XEipumj
 rpvC24VvzM/aEanqVvPoaX5ZK+nKq0+GpZ/2leJ2LLu8s/p6FzhvscDomF0bDM+vmaqDKCsyd43
 nS905Kj3emZpxnCKwa5SAgSS+7l4ZgWsjeihsqTZFcaWtoxePp2XLcUT96Zrk1Et8O+02Xiljuc
 vcLJVH3+QCGyG/JwN5/1nQUPF3Cjjw=
X-Received: by 2002:a5d:59c4:0:b0:45e:5c98:c8ed with SMTP id
 ffacd0b85a97d-45eb38af486mr28299629f8f.21.1779805766969; 
 Tue, 26 May 2026 07:29:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/54] target/arm: Implement FEAT_FAMINMAX for SVE
Date: Tue, 26 May 2026 15:28:31 +0100
Message-ID: <20260526142850.2326589-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260522220306.235200-5-richard.henderson@linaro.org
[PMM: add comments for TRANS_ macros]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        | 11 +++++++++++
 target/arm/tcg/helper-sve-defs.h | 14 ++++++++++++++
 target/arm/tcg/sve.decode        |  2 ++
 target/arm/tcg/sve_helper.c      |  8 ++++++++
 target/arm/tcg/translate-sve.c   | 20 ++++++++++++++++++++
 target/arm/tcg/translate.h       | 12 ++++++++++++
 6 files changed, 67 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 21b91b1503..a7ab7e2a31 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1568,6 +1568,11 @@ static inline bool isar_feature_aa64_sme_or_sve2(const ARMISARegisters *id)
     return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2(id);
 }
 
+static inline bool isar_feature_aa64_sme2_or_sve2(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) || isar_feature_aa64_sve2(id);
+}
+
 static inline bool isar_feature_aa64_sme_or_sve2p1(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2p1(id);
@@ -1608,6 +1613,12 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_faminmax(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index cd05dd0fb4..f97c31763f 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -3180,3 +3180,17 @@ DEF_HELPER_FLAGS_5(sve2p1_st1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i
 DEF_HELPER_FLAGS_5(sve2p1_st1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
 DEF_HELPER_FLAGS_5(sve2p1_st1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
 DEF_HELPER_FLAGS_5(sve2p1_st1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+
+DEF_HELPER_FLAGS_6(sve2_famax_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_famax_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_famax_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve2_famin_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_famin_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_famin_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ab63cfaa0f..078a085a79 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1130,6 +1130,8 @@ FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
 FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
 FDIV            01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
 FDIV            01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
+FAMAX           01100101 .. 00 1110 100 ... ..... .....    @rdn_pg_rm
+FAMIN           01100101 .. 00 1111 100 ... ..... .....    @rdn_pg_rm
 
 # SVE floating-point arithmetic with immediate (predicated)
 FADD_zpzi       01100101 .. 011 000 100 ... 0000 . .....        @rdn_i1
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d884ba474f..9490f0327f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4750,6 +4750,14 @@ DO_ZPZZ_FP(sve_fmulx_h, uint16_t, H1_2, helper_advsimd_mulxh)
 DO_ZPZZ_FP(sve_fmulx_s, uint32_t, H1_4, helper_vfp_mulxs)
 DO_ZPZZ_FP(sve_fmulx_d, uint64_t, H1_8, helper_vfp_mulxd)
 
+DO_ZPZZ_FP(sve2_famax_h, uint16_t, H1_2, float16_famax)
+DO_ZPZZ_FP(sve2_famax_s, uint32_t, H1_4, float32_famax)
+DO_ZPZZ_FP(sve2_famax_d, uint64_t, H1_8, float64_famax)
+
+DO_ZPZZ_FP(sve2_famin_h, uint16_t, H1_2, float16_famin)
+DO_ZPZZ_FP(sve2_famin_s, uint32_t, H1_4, float32_famin)
+DO_ZPZZ_FP(sve2_famin_d, uint64_t, H1_8, float64_famin)
+
 #undef DO_ZPZZ_FP
 
 /* Three-operand expander, with one scalar operand, controlled by
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 59b8c494a8..d04ef2dcfc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4254,6 +4254,26 @@ DO_ZPZZ_FP(FSCALE, aa64_sme_or_sve, sve_fscalbn)
 DO_ZPZZ_FP(FDIV, aa64_sme_or_sve, sve_fdiv)
 DO_ZPZZ_FP(FMULX, aa64_sme_or_sve, sve_fmulx)
 
+static gen_helper_gvec_4_ptr * const sve2_famax_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve2_famax_h,
+    gen_helper_sve2_famax_s,
+    gen_helper_sve2_famax_d
+};
+TRANS_FEAT_STREAMING_SME2(FAMAX, aa64_sme2_or_sve2_faminmax,
+                          gen_gvec_fpst_arg_zpzz,
+                          sve2_famax_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve2_famin_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve2_famin_h,
+    gen_helper_sve2_famin_s,
+    gen_helper_sve2_famin_d
+};
+TRANS_FEAT_STREAMING_SME2(FAMIN, aa64_sme2_or_sve2_faminmax,
+                          gen_gvec_fpst_arg_zpzz,
+                          sve2_famin_zpzz_fns[a->esz], a)
+
 typedef void gen_helper_sve_fp2scalar(TCGv_ptr, TCGv_ptr, TCGv_ptr,
                                       TCGv_i64, TCGv_ptr, TCGv_i32);
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 77fdc5f3a1..2a586321c8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -865,6 +865,7 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
     static bool trans_##NAME(DisasContext *s, arg_##NAME *a) \
     { return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__); }
 
+/* For SVE insns which are not valid in Streaming SVE mode */
 #define TRANS_FEAT_NONSTREAMING(NAME, FEAT, FUNC, ...)            \
     static bool trans_##NAME(DisasContext *s, arg_##NAME *a)      \
     {                                                             \
@@ -872,4 +873,15 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
         return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
     }
 
+/*
+ * For SVE insns which are only valid in Streaming SVE mode when
+ * SME2 is implemented
+ */
+#define TRANS_FEAT_STREAMING_SME2(NAME, FEAT, FUNC, ...)          \
+    static bool trans_##NAME(DisasContext *s, arg_##NAME *a)      \
+    {                                                             \
+        s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);      \
+        return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
+    }
+
 #endif /* TARGET_ARM_TRANSLATE_H */
-- 
2.43.0


