Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15315C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUw-0005MP-Ur; Fri, 04 Jul 2025 10:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPR-0003C1-5X
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:03 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPO-0001il-Bm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:00 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2efbbf5a754so772553fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639337; x=1752244137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrgLV1hJCWlcAk9bGFt6SGzMPkONZbBNBWA6ashyxVU=;
 b=K9aCUUmgqKywVT0rmlq32NS3IZx+IG3WatXrX/yXssKwZxbSF6H+o1/xyy4NgoYVyK
 xqHXUq/4WkK9x/rttKs+FAd8s/VGfBzD7YbD4I7wuKw2ZWirKcT222SaJ4odNOXVv21G
 Mtm+XWHswJVET9od50uFpetMHWKJSgjFSXhR/MpYRYzAqT4RXpibDYIslvD9xLAc90bQ
 d76nm2k629sD7/1RRlcaioQZU5+MpRP6IyUn4PQlqvxVBL8RGOGgUJPUeMB+YfZFzcus
 96ctB4W0W7bfdL5gkCjDGUKQe/+VORDANXepgsHjCKNzKb+chwVpEYUrfys9xAHbhWhk
 9tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639337; x=1752244137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrgLV1hJCWlcAk9bGFt6SGzMPkONZbBNBWA6ashyxVU=;
 b=O9xSlyZ841SUuch5qyZfNUYM6YfNAbm+wZ1EpRjUl6Fgji2mr4TPoYCwUYRHfL/xX1
 6B0lbCaZe6s2lDtxtMM8cBt+yv605bJkP2E4iib4AWtps44Hq2dHyDCFH6QCtOU7JT8e
 SbxZ1ZQGu6yxkMhIwzRppE4b2LcL8Lzr3TM4cmJb1TwcTN1R6Y1Lh5/gpvrhb3Za9mzc
 GE5QDoe2Cj6ElGS4gCNs24hYwUtuDS61azQOd3O9h+ydK14ZCdJXzYlqVgHW5G7cuQYG
 9R0GxYMa4JsVMPfdy3wcxl3S4CQxqmdSLFNTFuEoMSstOb7+XOFxnmtuBKSnCd1ot1tc
 Hviw==
X-Gm-Message-State: AOJu0YyDvicn4hOk10Gpy52dtTlo6Xc1xt4jbz+LRfHTGNH0WO6roOge
 /Rm3ueoW5RLzhho+BosSUkD/ZbE2vOzbJxs5G3eH/txWZISjf01C25jymiDnKeYwes6U8LelPLZ
 4ipjSl2E=
X-Gm-Gg: ASbGncvQYnCa7jmJwjxETL56uhUbZJMra0rgpOh/9ykX5Y5lLWsp/vSrRIcLSx9ysSy
 9y2Nt11a13LyOIS3L/6iOni40GgPUGw7ias0DLfs02bs0iPn9G1X8P6W3zAxrWfITAYPRmyJefa
 2ZLg0852p+RHdtwct8P3fdBMYxblLJaeFgGX49E4zFx+YMREJKeXAWF+fl0r89pM+laoA39JIHc
 03bc9bCHmqicuEhO36ZIjrAWuX+JP/7b0SfOHpxY5KRs7Sk5UCfGVScrPs/pLePxGnmPW2FePqY
 f9ZWhJDMqKlZt0lCtRHjDB86Tp5PzSQxp57ZQA9r3qVTaVUnzG7vV1jvUYw4pf/m5oLo/Ef7Wu4
 ydZ3yeQOMrWlmcqnCA0NJAGSxaDGwEPHRmGfI9grARHEJyzaD
X-Google-Smtp-Source: AGHT+IH9nyr7d1rFG6jpiswUv6rTW/xxd0ON0Emo0qpjvMCdyf8fKxozetv4fnaXYbVAnbXG0vm9iw==
X-Received: by 2002:a05:6870:e99c:b0:2cc:37d4:82b2 with SMTP id
 586e51a60fabf-2f796c0a593mr1780634fac.14.1751639336999; 
 Fri, 04 Jul 2025 07:28:56 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 098/108] target/arm: Implement LD1Q, ST1Q for SVE2p1
Date: Fri,  4 Jul 2025 08:21:01 -0600
Message-ID: <20250704142112.1018902-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 360114ece2..43b872c7fd 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7211,6 +7211,9 @@ DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
 DO_LD1_ZPZ_D(dd_be, zss, MO_64)
 DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
+DO_LD1_ZPZ_D(qq_le, zd, MO_128)
+DO_LD1_ZPZ_D(qq_be, zd, MO_128)
+
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
 
@@ -7597,6 +7600,9 @@ DO_ST1_ZPZ_D(sd_be, zd, MO_32)
 DO_ST1_ZPZ_D(dd_le, zd, MO_64)
 DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
+DO_ST1_ZPZ_D(qq_le, zd, MO_128)
+DO_ST1_ZPZ_D(qq_be, zd, MO_128)
+
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7dff028569..7b575734fd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6121,13 +6121,23 @@ gather_load_fn64[2][2][2][3][2][4] = {
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
@@ -6142,6 +6152,12 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
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
 
@@ -6309,6 +6325,14 @@ static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][2][3][4] = {
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
@@ -6318,7 +6342,9 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
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
@@ -6332,6 +6358,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
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


