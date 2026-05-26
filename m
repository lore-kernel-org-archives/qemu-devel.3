Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC72CCD6E41
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmi-0000s8-Qb; Tue, 26 May 2026 10:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmZ-0000FA-Gl
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmX-0001L5-92
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so43281435e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805760; x=1780410560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fbUR0y3m+ZaGpE8A2CtpDj4N7hEhJk70SJ9aVfodHf8=;
 b=FI9pnZMBRj0Rqq5P8GI+UU7fWmdanAY5t2Uaz6GuKjV2rjd4WJq1sLFrjgXkyyN4xI
 tc9Rc3fbvraUV3UiqxdlfoQIUbKZ/04DOQwOWYvGFhdtpqAq6UNGShlJRoUyFB6V42dN
 HEoBKDNTlNKfz/d9J9gVV/SSIIOFPk+U7fkT66sTgS1S73Ipb1ajhIDIdcVpnBgwUg3P
 g/mL75lxQ6oha6kmlwzDJNjQeoJQmDKFyc/+l3y299+Q0gC4siZr0iqQ+yGjjeDIpUhQ
 KJUnrHfnQ7HBcJY6L4a6QphjsZA5NwP+cXJR+fFga2Uj1IlJCN2kCxe4sVsCBCNrKJWd
 kA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805760; x=1780410560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fbUR0y3m+ZaGpE8A2CtpDj4N7hEhJk70SJ9aVfodHf8=;
 b=cUf46d/FjmOgy3xjOzIfojoszCYcwU3xIxNDWhXjGJbfwDlaTrsQ2wvj4lQGlmHTk1
 P0jNyIwE0hgy2SlymbZgnTI3iAalQO18Qoa55cPacwzMi+OqpZSrn3DAeYMNiuqgsNXv
 jpx7cbxIHMGrAPgrzRNfZXm4XXfIQLz1SMSilfLQ4mcMdFDIr1w08VgNkSqKBPars0Wg
 f95doL2wG9upFJCfgRfI0/hrmySIP365uf8Tgk5O+IoegWIXsRpBZ9R+wbKZB6UIMqTO
 hZByyJ7M7C4QDCllX3XdNbpBHAf0eJQF6aANiBFG6v8m7sCX/Gc+UyEvPuJ2aobsTSvt
 w69A==
X-Gm-Message-State: AOJu0YyMLufUwnDU4cSQdecN5dXAyGug41BVV+NBPDGA/Lu1r8gtGhQP
 v1S4DPRF0Qn37aHrlCUWLv3k9SENK0xV9JT4CeuCJR3P52i1Erp8t4r1uE1Jvzwxn5faLI1waGR
 u+9VY
X-Gm-Gg: Acq92OF9Itqpg0UQRgRBRMShB6yJEm+ShakdOmxtwcgZuogmzdgQ7yX0c6mP4uuSDlJ
 gX7x3zcUFvVPaq8t91o4rtwmEmzUiThDmbmkgFz9XR6H4DnqfPZj68CtK15c+8tGdpM27hpQdVz
 CuAscbXCY9msXjxLwMhLQxB0FG0sHz07vcKFc2biXJ6UJFjCdKTM6KgPoq+Z/f4mB6kC7J8GN4M
 ZcoIFrQC918gDU/e8N1SXtcrW6WWsDLDcBDPLGINCAdRLICoeQIcrRA940CN34QlAS15khrhhaO
 +XyBKaJo+s/4MeXumjJjjPet2PWvSYznPNwJ7+jcK6vONm1ImWb1ZbQBC3CfqqIbAGvtPP+n32r
 FZHY+B/m/xiWeINVHAHu6AfoXI5AZjtqres1vgNkr4d02oCQPDOc1vu9vwHTuS8aI14sOsYd3fE
 rh5uvmXOWtHqlrKy+OWYbf6D0h1v16H3/IOcFLBl+DYtQUAN75/MjyYdPmo9QLpzmYFDIGzy0Sk
 5fIR8TIupQ4uSw/7hPA40vvLQfeZro=
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id
 5b1f17b1804b1-490482c4586mr331794845e9.23.1779805759598; 
 Tue, 26 May 2026 07:29:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/54] target/arm: SVE2 FMAXP, FMINP must honour AH=1
Date: Tue, 26 May 2026 15:28:25 +0100
Message-ID: <20260526142850.2326589-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The behaviour of floating-point maximum and minimum insns has
some odd special cases when FPCR.AH=1. We get this right in most
places (for instance, the ASIMD FMAXP, FMINP) but forgot about
it for the SVE2 versions of FMAXP and FMINP.

Cc: qemu-stable@nongnu.org
Fixes: 384433e70983 ("target/arm: Implement FPCR.AH semantics for FMINP and FMAXP")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260521122913.1565011-2-peter.maydell@linaro.org
---
 target/arm/tcg/helper-sve-defs.h | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c      |  8 ++++++++
 target/arm/tcg/translate-sve.c   |  4 ++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index c3541a8ca8..cd05dd0fb4 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -2914,6 +2914,20 @@ DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve2_ah_fmaxp_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fmaxp_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fmaxp_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve2_ah_fminp_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fminp_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve2_ah_fminp_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve2_eor3, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_bcax, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_bsl1n, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 062d8881bd..179cbd74fb 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -778,6 +778,14 @@ DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_h, float16, H1_2, float16_min)
 DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_s, float32, H1_4, float32_min)
 DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_d, float64, H1_8, float64_min)
 
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_h, float16, H1_2, helper_vfp_ah_maxh)
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_s, float32, H1_4, helper_vfp_ah_maxs)
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_d, float64, H1_8, helper_vfp_ah_maxd)
+
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_h, float16, H1_2, helper_vfp_ah_minh)
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_s, float32, H1_4, helper_vfp_ah_mins)
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_d, float64, H1_8, helper_vfp_ah_mind)
+
 #undef DO_ZPZZ_PAIR_FP
 
 /* Three-operand expander, controlled by a predicate, in which the
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index aa7d72a35e..bf9f0ae179 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7667,8 +7667,8 @@ TRANS_FEAT_NONSTREAMING(HISTSEG, aa64_sve2, gen_gvec_ool_arg_zzz,
 DO_ZPZZ_FP(FADDP, aa64_sme_or_sve2, sve2_faddp_zpzz)
 DO_ZPZZ_FP(FMAXNMP, aa64_sme_or_sve2, sve2_fmaxnmp_zpzz)
 DO_ZPZZ_FP(FMINNMP, aa64_sme_or_sve2, sve2_fminnmp_zpzz)
-DO_ZPZZ_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz)
-DO_ZPZZ_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz)
+DO_ZPZZ_AH_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz, sve2_ah_fmaxp_zpzz)
+DO_ZPZZ_AH_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz, sve2_ah_fminp_zpzz)
 
 static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
                      gen_helper_gvec_4_ptr *fn)
-- 
2.43.0


