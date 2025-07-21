Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9172C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYl-0005Eu-2h; Mon, 21 Jul 2025 09:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYJ-0000De-00
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYE-0005Iu-Ue
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so32414595e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104449; x=1753709249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6N2CS6KzSnhTjKUQmU745sHXbS2AT18sliWIi4VMq1I=;
 b=uWjHy38HUs7wlLZy2RZDM9ozlSDzzYGs3gaBkZjT0yCZ87ymGXfy8Sx+FEMiVuDla2
 2rQ/D7oRuePwPmgw+AwUk7bWtEkqk5gGvhma6HAHCz+bJcMykGNiz4iZsvU3MU7KcC/0
 iGC8DFRzs3Mbcqewu2T1YUYosvJ/De0kjreH9KlGLNWvYvdshQTmKz8ShE8r5kDlJPTp
 wptrsaxZCY7iFj6eN5wJFzkaqjSnFnIGJ+2yCL2W5o1A4KrBxx0lz2lfNyYutziChtBX
 5SWaAcNm3OoDvGGgUml/WaVN7e4DAQ1Galk7k9iuvel3LtETfPGpGfL46U9ozMhNlLXQ
 eKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104449; x=1753709249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6N2CS6KzSnhTjKUQmU745sHXbS2AT18sliWIi4VMq1I=;
 b=VdFNEfAlUFiQykR886ONt1zCqeZOMmXxxvvL6qejEBdNdx9C17p4shMNeWt3k5+d2N
 9cWZ2eqgyTzCl0pUff95JC1nPjI7In3tQYSB/EZMRZ1E5RbXqF7pOtcpv42HQa39k0Yp
 JgBQWHr72a4UZCEyhZb03MpT57CbV3O0bH69aITH/lqZITkuu1xYmlgp82n/Zr0Sfbdp
 B8AH9L9hJk383BDA+PNHCTdHfEDVO2q+wf+f5n93Ywy8m0a6jOUpMFeS5W4lKYG7XdMt
 s9FBits7KFuonwEcRN52qmjD4qwk1A+fueGPsl8EdqlNYquNtOvcRkiLrCujMta8sFGR
 X5Dw==
X-Gm-Message-State: AOJu0YzyTGYpVcj8kmaaTbvJVKlFyuUlKZYSFQuwWRXjJDwtU3uWWb0c
 ZEINDX0mmNylYbqh0PY5RF2BvyM/3KJCTNc0mN2kNwOYMonBvcW7Zk0EmTBAP+2BbOSFmhA3QIW
 DaL03
X-Gm-Gg: ASbGncs0vdS9ARCq+LMopMC6uQYTjl43oggOimPRbmGBf3pb9MiR/Laub/urd63A9H+
 ikHLHAObytWRQn138ZpXfDy0kgVV0F9bY5CmP4hDpx+pC4O+q1NBg2sR3CgBiG/7JPcZ3G+3Sg2
 vpmnsrE7nzbV/rEuIfqmkADkzeib9AMcttSe+0WJZ/AR1QBMkH7nsOeII2Nar+jM1XrETFlqVVi
 eigFiv8dGgvFglhn31tEhjLazB+jBhw95uUjf9WW7vBChhe0lxD9G8O/cMG9ZQ7pUm3Ee8ysmf7
 N8THggx58NJl03h9F9ucZRHBNJR5YbzNF8kjItjYIMDUuQ3h+lQzZTZ+6Mn+y3iPxv3XWROCZOD
 2Mjvnrr2o4pPEMLBi3os/KUDaXC+r
X-Google-Smtp-Source: AGHT+IEVMO9bVsWNrDm1+PinObn/odMqBmX74SByFIv4fOA0JRLwDIMYtIsEEMCkFzgpvruNgsjQyQ==
X-Received: by 2002:a05:600c:800f:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-4563b8d29aamr96893345e9.22.1753104448688; 
 Mon, 21 Jul 2025 06:27:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] target/arm: Add BFADD, BFSUB, BFMUL, BFMAXNM,
 BFMINNM (predicated)
Date: Mon, 21 Jul 2025 14:27:06 +0100
Message-ID: <20250721132718.2835729-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

FEAT_SVE_B16B16 adds bfloat16 versions of the SVE floating point
(predicated) instructions, which are encoded via sz=0b00.
Add BFADD, BFSUB, BFMUL, BFMAXNM, BFMINNM; these are all the insns
in this group which do not change behaviour for AH=1.

We will deal with BFMAX/BFMIN (which do have different AH=1
behaviour) in a following commit.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-3-peter.maydell@linaro.org
---
 target/arm/tcg/helper-sve.h    | 10 ++++++++++
 target/arm/tcg/sve_helper.c    |  5 +++++
 target/arm/tcg/translate-sve.c | 22 +++++++++++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index c36090d13d1..d612bcaded3 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1196,6 +1196,8 @@ DEF_HELPER_FLAGS_5(sve_fcmne0_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_fcmne0_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fadd_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fadd_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fadd_s, TCG_CALL_NO_RWG,
@@ -1203,6 +1205,8 @@ DEF_HELPER_FLAGS_6(sve_fadd_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fadd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fsub_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsub_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsub_s, TCG_CALL_NO_RWG,
@@ -1210,6 +1214,8 @@ DEF_HELPER_FLAGS_6(sve_fsub_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fsub_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fmul_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmul_s, TCG_CALL_NO_RWG,
@@ -1252,6 +1258,8 @@ DEF_HELPER_FLAGS_6(sve_ah_fmax_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_ah_fmax_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fminnum_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnum_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnum_s, TCG_CALL_NO_RWG,
@@ -1259,6 +1267,8 @@ DEF_HELPER_FLAGS_6(sve_fminnum_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fminnum_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fmaxnum_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxnum_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxnum_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 43b872c7fd6..a229503bc21 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4629,14 +4629,17 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,       \
     } while (i != 0);                                           \
 }
 
+DO_ZPZZ_FP(sve_fadd_b16, uint16_t, H1_2, bfloat16_add)
 DO_ZPZZ_FP(sve_fadd_h, uint16_t, H1_2, float16_add)
 DO_ZPZZ_FP(sve_fadd_s, uint32_t, H1_4, float32_add)
 DO_ZPZZ_FP(sve_fadd_d, uint64_t, H1_8, float64_add)
 
+DO_ZPZZ_FP(sve_fsub_b16, uint16_t, H1_2, bfloat16_sub)
 DO_ZPZZ_FP(sve_fsub_h, uint16_t, H1_2, float16_sub)
 DO_ZPZZ_FP(sve_fsub_s, uint32_t, H1_4, float32_sub)
 DO_ZPZZ_FP(sve_fsub_d, uint64_t, H1_8, float64_sub)
 
+DO_ZPZZ_FP(sve_fmul_b16, uint16_t, H1_2, bfloat16_mul)
 DO_ZPZZ_FP(sve_fmul_h, uint16_t, H1_2, float16_mul)
 DO_ZPZZ_FP(sve_fmul_s, uint32_t, H1_4, float32_mul)
 DO_ZPZZ_FP(sve_fmul_d, uint64_t, H1_8, float64_mul)
@@ -4661,10 +4664,12 @@ DO_ZPZZ_FP(sve_ah_fmax_h, uint16_t, H1_2, helper_vfp_ah_maxh)
 DO_ZPZZ_FP(sve_ah_fmax_s, uint32_t, H1_4, helper_vfp_ah_maxs)
 DO_ZPZZ_FP(sve_ah_fmax_d, uint64_t, H1_8, helper_vfp_ah_maxd)
 
+DO_ZPZZ_FP(sve_fminnum_b16, uint16_t, H1_2, bfloat16_minnum)
 DO_ZPZZ_FP(sve_fminnum_h, uint16_t, H1_2, float16_minnum)
 DO_ZPZZ_FP(sve_fminnum_s, uint32_t, H1_4, float32_minnum)
 DO_ZPZZ_FP(sve_fminnum_d, uint64_t, H1_8, float64_minnum)
 
+DO_ZPZZ_FP(sve_fmaxnum_b16, uint16_t, H1_2, bfloat16_maxnum)
 DO_ZPZZ_FP(sve_fmaxnum_h, uint16_t, H1_2, float16_maxnum)
 DO_ZPZZ_FP(sve_fmaxnum_s, uint32_t, H1_4, float32_maxnum)
 DO_ZPZZ_FP(sve_fmaxnum_d, uint64_t, H1_8, float64_maxnum)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f00cccf1548..2739c226d73 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -407,6 +407,10 @@ static bool gen_gvec_fpst_zzzp(DisasContext *s, gen_helper_gvec_4_ptr *fn,
 static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
+    /* These insns use MO_8 to encode BFloat16. */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
+        return false;
+    }
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
                               a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
@@ -4206,13 +4210,21 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_FP(FADD_zpzz, aa64_sve, sve_fadd)
-DO_ZPZZ_FP(FSUB_zpzz, aa64_sve, sve_fsub)
-DO_ZPZZ_FP(FMUL_zpzz, aa64_sve, sve_fmul)
+/* Similar, but for insns where sz == 0 encodes bfloat16 */
+#define DO_ZPZZ_FP_B16(NAME, FEAT, name) \
+    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
+        gen_helper_##name##_b16, gen_helper_##name##_h,         \
+        gen_helper_##name##_s, gen_helper_##name##_d            \
+    };                                                          \
+    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
+
+DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sve, sve_fadd)
+DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sve, sve_fsub)
+DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sve, sve_fmul)
 DO_ZPZZ_AH_FP(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
 DO_ZPZZ_AH_FP(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
-DO_ZPZZ_FP(FMINNM_zpzz, aa64_sve, sve_fminnum)
-DO_ZPZZ_FP(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
+DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sve, sve_fminnum)
+DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
 DO_ZPZZ_AH_FP(FABD, aa64_sve, sve_fabd, sve_ah_fabd)
 DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
 DO_ZPZZ_FP(FDIV, aa64_sve, sve_fdiv)
-- 
2.43.0


