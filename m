Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6ADC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwwr-0003Tk-Cz; Wed, 02 Jul 2025 08:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnC-00006G-8X
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:27 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-0003Aa-V9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:24 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2e9a38d2a3aso4367309fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460126; x=1752064926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQbTCIZfXAx+H1aXpv73PAoNk3q2xsGUdD62vzGqb0w=;
 b=bSek5vcktT50ALLxz7kDay4wlXb5gKmVgqn5bPtPkpi4ojeYV8ncZTMFkI9vPpumRH
 TaLHrhV5ryx+7MinnwyJMM6pd5M9XOJctq13go3xEjSP+8YzG0eo8OVor3sARpPtsIEO
 DqlQnmapWQkJueRSfEIcvaPQYZVbbExs8rWdgjDC/AW+iymgIJhrbUFasXXJqGbCGh4H
 miUeM0nH4XhYy7nukyQc7DXG+qAZjEoCf7A91L4JiEU8Q1KrNWq/KTp24n4kuIZkKRxh
 L1u8FakPLpleslyHtD2D6Uetot/9PEUEuEzbI1NRUEKwORfUB7sBmvk5Hg9gYptKTA+X
 Rb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460126; x=1752064926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQbTCIZfXAx+H1aXpv73PAoNk3q2xsGUdD62vzGqb0w=;
 b=Cxzn9xAU6RtCNRXnzN04TWaVT0xHN8+GJvQU7GWk62Q24f8YcfrQLBG7UI0+yjQO3n
 yKGZjGI7X4lsF+VT1JTiZ0Yx9xjdWSINYsNl1tiUZ1MnUT/q7daQ1wqu7q82e3qpjvNG
 w1D4hy5WoMTPfLTJAraIAiM4Ds0e6GyKH1ChixmWliB6an6dyH6wobDcnjytjJCi1Mgp
 yXrcwV+y+MqtfaR6wWV3VCT0PCYdGpr14yX60cp3xSWB+hqcjOdff4oeGyUOirnW6/hL
 pBK3oS9KWf5myFmuq9xCC8aPmL1mQEIDMBmPwe1awbPpCdfnk2aR7EERgJh712XYoseV
 U5iA==
X-Gm-Message-State: AOJu0YzJx9xD75Tz4Y4kZiqMVcjd9u6+HWQSqe4nV2wpmNp4nTHZRQ9z
 gNofm3wrNQXb6FliymAiXRHxqd8YLsKAnhxvv5MKuMNq64SExt2k/hbm3sZjml1okdVRQPS/dyX
 uGrXWBQ8=
X-Gm-Gg: ASbGncsnrGqKMbd+R9BFZvEkUPJOSbbkodEQWP3N5fy2XljMvlpQ1vNITjZ6Cjpj3Ni
 R1uF/Oy1RZHBr3Uj13IzwWtFF3y9upmN3HYHo1aAHTwmoLVZpRcW8kNyAPJ/QtdtyfVMV1Pw9Um
 NYrB8FOUabCDM6og4zPvTzM6E/kseqdtTmAVT8jEZWOjJaCgBVgMj8afL07E/q1x8/ZzLbsaSgr
 NpFZn8SX9uwSXv6SQFDeDWYBQbVWrOM2CgszmzL6Sr42KxxbFYZGxim8HUFWodMl1tTSJ2WwgFp
 8gwKnHWGesRDmSS4niIzR4lucMPHrg2SYC6Y0vQqlmp7lJMT3H8wNsE0aZPzOHXitd+rmg==
X-Google-Smtp-Source: AGHT+IET1aIAoGoQ1UYG1/fI0it4euBZdyfvQdWPskPJpydqL1sBoKOp9CzRkyGZNq/UJwY5h3yDSw==
X-Received: by 2002:a05:6871:28a6:b0:2b8:fab0:33c with SMTP id
 586e51a60fabf-2f5a8b93e0fmr2103688fac.23.1751460126367; 
 Wed, 02 Jul 2025 05:42:06 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 87/97] target/arm: Implement LD1Q, ST1Q for SVE2p1
Date: Wed,  2 Jul 2025 06:34:00 -0600
Message-ID: <20250702123410.761208-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 16 ++++++++++++++++
 target/arm/tcg/sve_helper.c    |  6 ++++++
 target/arm/tcg/translate-sve.c | 34 ++++++++++++++++++++++++++++++++--
 target/arm/tcg/sve.decode      |  8 ++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ade76ff664..c36090d13d 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2155,6 +2155,10 @@ DEF_HELPER_FLAGS_6(sve_ldsds_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
@@ -2264,6 +2268,10 @@ DEF_HELPER_FLAGS_6(sve_ldsds_le_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
@@ -2549,6 +2557,10 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zsu_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
@@ -2616,6 +2628,10 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve2_sqdmull_zzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index cf46ff9947..dfce9697e2 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7482,6 +7482,9 @@ DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
 DO_LD1_ZPZ_D(dd_be, zss, MO_64)
 DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
+DO_LD1_ZPZ_D(qq_le, zd, MO_128)
+DO_LD1_ZPZ_D(qq_be, zd, MO_128)
+
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
 
@@ -7868,6 +7871,9 @@ DO_ST1_ZPZ_D(sd_be, zd, MO_32)
 DO_ST1_ZPZ_D(dd_le, zd, MO_64)
 DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
+DO_ST1_ZPZ_D(qq_le, zd, MO_128)
+DO_ST1_ZPZ_D(qq_be, zd, MO_128)
+
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 994839e8b4..262670ed89 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6116,13 +6116,23 @@ gather_load_fn64[2][2][2][3][2][4] = {
                   gen_helper_sve_ldffdd_be_zd_mte, } } } } },
 };
 
+static gen_helper_gvec_mem_scatter * const
+gather_load_fn128[2][2] = {
+    { gen_helper_sve_ldqq_le_zd,
+      gen_helper_sve_ldqq_be_zd },
+    { gen_helper_sve_ldqq_le_zd_mte,
+      gen_helper_sve_ldqq_be_zd_mte }
+};
+
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (a->esz < MO_128
+        ? !dc_isar_feature(aa64_sve, s)
+        : !dc_isar_feature(aa64_sve2p1, s)) {
         return false;
     }
     s->is_nonstreaming = true;
@@ -6137,6 +6147,12 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
     case MO_64:
         fn = gather_load_fn64[mte][be][a->ff][a->xs][a->u][a->msz];
         break;
+    case MO_128:
+        assert(!a->ff && a->u && a->xs == 2 && a->msz == MO_128);
+        fn = gather_load_fn128[mte][be];
+        break;
+    default:
+        g_assert_not_reached();
     }
     assert(fn != NULL);
 
@@ -6304,6 +6320,14 @@ static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][2][3][4] = {
                gen_helper_sve_stdd_be_zd_mte, } } },
 };
 
+static gen_helper_gvec_mem_scatter * const
+scatter_store_fn128[2][2] = {
+    { gen_helper_sve_stqq_le_zd,
+      gen_helper_sve_stqq_be_zd },
+    { gen_helper_sve_stqq_le_zd_mte,
+      gen_helper_sve_stqq_be_zd_mte }
+};
+
 static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn;
@@ -6313,7 +6337,9 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
         return false;
     }
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (a->esz < MO_128
+        ? !dc_isar_feature(aa64_sve, s)
+        : !dc_isar_feature(aa64_sve2p1, s)) {
         return false;
     }
     s->is_nonstreaming = true;
@@ -6327,6 +6353,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     case MO_64:
         fn = scatter_store_fn64[mte][be][a->xs][a->msz];
         break;
+    case MO_128:
+        assert(a->xs == 2 && a->msz == MO_128);
+        fn = scatter_store_fn128[mte][be];
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3eda029146..2efd5f57e4 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1340,6 +1340,10 @@ LD1_zprz        1100010 10 1. ..... 1.. ... ..... ..... \
 LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
                 @rprr_g_load_sc esz=3 msz=3 u=1
 
+# LD1Q
+LD1_zprz        1100 0100 000 rm:5 101 pg:3 rn:5 rd:5 \
+                &rprr_gather_load u=0 ff=0 xs=2 esz=4 msz=4 scale=0
+
 # SVE 64-bit gather load (vector plus immediate)
 LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \
                 @rpri_g_load esz=3
@@ -1443,6 +1447,10 @@ ST1_zprz        1110010 .. 01 ..... 101 ... ..... ..... \
 ST1_zprz        1110010 .. 00 ..... 101 ... ..... ..... \
                 @rprr_scatter_store xs=2 esz=3 scale=0
 
+# ST1Q
+ST1_zprz        1110 0100 001 rm:5 001 pg:3 rn:5 rd:5 \
+                &rprr_scatter_store xs=2 msz=4 esz=4 scale=0
+
 # SVE 64-bit scatter store (vector plus immediate)
 ST1_zpiz        1110010 .. 10 ..... 101 ... ..... ..... \
                 @rpri_scatter_store esz=3
-- 
2.43.0


