Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A7C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhV3-0005YY-Dv; Fri, 04 Jul 2025 10:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPU-0003P5-Sg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:08 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPP-0001nB-VE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:02 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso963824fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639338; x=1752244138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27KFz/QbnRCUP0rL1Ovg7EoKPMOkldxvhT6tE1pySAw=;
 b=TfuR1W7bmf8Mkakp1R57tmep4vYgxYGmyZyd4nEDIbCo+ZULkYOIeEWBAdnywYykVH
 /asuF3Ec5dOVgu2PQHIDLNKb+9ObZ0Iwvc4buR3hyrAoyzRBxybOdhfxglLnwUa2XAn+
 +FF7j8hYouWUWZJGs9XpwMwn3LWLQ6vyZQzOUk/0CrOBV9fzImlsSGU1xmCSrdRT9Y/6
 nLg7tHOz/h60pO8xElkKEC3cAzgWg0kos4Bjj8WLOXhyumfRnIlLQpj50njISuaRA/3X
 WzLCYfoYGHdsf88J+vToJtUh+GnhneE9vYvNR/zAgc5hppFLGRY7M1flnIZYAnZDdXCG
 UqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639338; x=1752244138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27KFz/QbnRCUP0rL1Ovg7EoKPMOkldxvhT6tE1pySAw=;
 b=oiYy8c32GybOReYJdNPMJI9KUmM0DHi/IWuxohKWrMhWS9yToSVDm28275VALfO8BE
 Z2vohMzmOa9M3Qpe9Imi4WkzWO9NaTZq8Q0owz/4Nqxts78IE2OQK/xHY0NyKvvs/73V
 p/e2nQnNZ+Hl2wPxNpvJNinazwcj8K6aEbHlXsMPq5LHZ3RQOU5ovQC5lsXGfUIAcuph
 nfdUidXLeh4/5ugMCkIq0DO89MqGYZdWRwzaTt+2CdoyvjuN10UWMlz8tK8wbYAEWWw9
 VilIUY+oZ+xefz7MrGwnLbSpP58N8T3PT9WtWWsDWFsoGECLkJ2W8YydReHdXdL0Wlp9
 71tA==
X-Gm-Message-State: AOJu0YxhJvp/HRf9zcMiFpj5l7vqIuWwgxEYjAVD6qvR4Ts8FWgMIAHW
 3J6FhIBD7Jw56aa6tQ1/rnM3AKu3DoKvrusa14LegUyOD8x8t2f+j+LkkN3C0ROchTqTmpBGbrO
 T3f/t/0c=
X-Gm-Gg: ASbGncuVvhyi4SfRZytNrI6kJamkAWrqy6qxCsHlpDIG4YDErhKCIkc80KhdXpsVDpG
 FZf8kitda7JWpf2vmNQdgt/PlBmEhlNXyBYSKbsOqiZJHEBtn3Qjs10gfWy393eDHEqPMjTxPOQ
 aXsvbUP+CrqlnWYPl9IX8OU0vAigiBTrfCtSQuv3R4/zDB/fQJ3ppSwKmq+SZUVrgSrEkjjZWLV
 E7CDYORB0ukl5ncNY+gIe6s6Dg0HGGcmI5RMkQ6fmZ1yfLYUR1pPrmewfXzqUeQ0h0LEIL4AaBZ
 14RV6sKhxzl0Hp1NjMeb4IuZTdL+rrXWs98vgiT7UPHyG76+n/9o/6jNaOLUrZyR+nxHwZwlVc3
 fjFEz7GjdUytw9FSnaTjQFmS58y/5s3aXBjrXauECL0nNhamp
X-Google-Smtp-Source: AGHT+IHgq884POa5h1e0ohxU7+TPql4P8NTdtorK0BNgb+1Zr9/lq151t/g8KmEAzVeD2sDCkf3REQ==
X-Received: by 2002:a05:6871:5825:b0:296:b568:7901 with SMTP id
 586e51a60fabf-2f791da46camr2303707fac.16.1751639338069; 
 Fri, 04 Jul 2025 07:28:58 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 099/108] target/arm: Implement MOVAZ for SME2p1
Date: Fri,  4 Jul 2025 08:21:02 -0600
Message-ID: <20250704142112.1018902-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme_helper.c    | 60 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 46 +++++++++++++++++++-------
 target/arm/tcg/sme.decode      | 36 ++++++++++++++++++++
 4 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 467073ea25..c9961d6b7f 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -42,6 +42,12 @@ DEF_HELPER_FLAGS_3(sme2_mova_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_mova_cz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index df16bb2f9c..424fc006be 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -257,6 +257,66 @@ void HELPER(sme2_mova_zc_d)(void *vdst, void *vsrc, uint32_t desc)
     }
 }
 
+void HELPER(sme2p1_movaz_zc_b)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint8_t *src = vsrc;
+    uint8_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc);
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_h)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint16_t *src = vsrc;
+    uint16_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 2;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_s)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint32_t *src = vsrc;
+    uint32_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 4;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_d)(void *vdst, void *vsrc, uint32_t desc)
+{
+    uint64_t *src = vsrc;
+    uint64_t *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 8;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        src[tile_vslice_index(i)] = 0;
+    }
+}
+
+void HELPER(sme2p1_movaz_zc_q)(void *vdst, void *vsrc, uint32_t desc)
+{
+    Int128 *src = vsrc;
+    Int128 *dst = vdst;
+    size_t i, n = simd_oprsz(desc) / 16;
+
+    for (i = 0; i < n; ++i) {
+        dst[i] = src[tile_vslice_index(i)];
+        memset(&src[tile_vslice_index(i)], 0, 16);
+    }
+}
+
 /*
  * Clear elements in a tile slice comprising len bytes.
  */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7407597177..9592f6a996 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -247,7 +247,8 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
 TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
 
-static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
+static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n,
+                           bool to_vec, bool zero)
 {
     static gen_helper_gvec_2 * const cz_fns[] = {
         gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
@@ -257,6 +258,11 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
         gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
     };
+    static gen_helper_gvec_2 * const zc_z_fns[] = {
+        gen_helper_sme2p1_movaz_zc_b, gen_helper_sme2p1_movaz_zc_h,
+        gen_helper_sme2p1_movaz_zc_s, gen_helper_sme2p1_movaz_zc_d,
+        gen_helper_sme2p1_movaz_zc_q,
+    };
     TCGv_ptr t_za;
     int svl, bytes_per_op = n << a->esz;
 
@@ -270,6 +276,8 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         return true;
     }
 
+    assert(a->esz <= MO_64 + zero);
+
     if (!sme_smza_enabled_check(s)) {
         return true;
     }
@@ -292,7 +300,9 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
             TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
             t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
                                    a->off * n + i, 1, n, a->v);
-            if (to_vec) {
+            if (zero) {
+                zc_z_fns[a->esz](t_zr, t_za, t_desc);
+            } else if (to_vec) {
                 zc_fns[a->esz](t_zr, t_za, t_desc);
             } else {
                 cz_fns[a->esz](t_za, t_zr, t_desc);
@@ -305,6 +315,9 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
                                    a->off * n + i, 1, n, a->v);
             if (to_vec) {
                 tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, 0, svl, svl);
+                if (zero) {
+                    tcg_gen_gvec_dup_imm_var(MO_8, t_za, 0, svl, svl, 0);
+                }
             } else {
                 tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, o_zr, svl, svl);
             }
@@ -313,12 +326,17 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
     return true;
 }
 
-TRANS_FEAT(MOVA_tz2, aa64_sme2, do_mova_tile_n, a, 2, false)
-TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
-TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true)
-TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true)
+TRANS_FEAT(MOVA_tz2, aa64_sme2, do_mova_tile_n, a, 2, false, false)
+TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false, false)
+TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true, false)
+TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true, false)
 
-static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
+TRANS_FEAT(MOVAZ_zt, aa64_sme2p1, do_mova_tile_n, a, 1, true, true)
+TRANS_FEAT(MOVAZ_zt2, aa64_sme2p1, do_mova_tile_n, a, 2, true, true)
+TRANS_FEAT(MOVAZ_zt4, aa64_sme2p1, do_mova_tile_n, a, 4, true, true)
+
+static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n,
+                            bool to_vec, bool zero)
 {
     TCGv_ptr t_za;
     int svl;
@@ -336,6 +354,9 @@ static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
 
         if (to_vec) {
             tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, o_za, svl, svl);
+            if (zero) {
+                tcg_gen_gvec_dup_imm_var(MO_8, t_za, o_za, svl, svl, 0);
+            }
         } else {
             tcg_gen_gvec_mov_var(MO_8, t_za, o_za, tcg_env, o_zr, svl, svl);
         }
@@ -343,10 +364,13 @@ static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
     return true;
 }
 
-TRANS_FEAT(MOVA_az2, aa64_sme2, do_mova_array_n, a, 2, false)
-TRANS_FEAT(MOVA_az4, aa64_sme2, do_mova_array_n, a, 4, false)
-TRANS_FEAT(MOVA_za2, aa64_sme2, do_mova_array_n, a, 2, true)
-TRANS_FEAT(MOVA_za4, aa64_sme2, do_mova_array_n, a, 4, true)
+TRANS_FEAT(MOVA_az2, aa64_sme2, do_mova_array_n, a, 2, false, false)
+TRANS_FEAT(MOVA_az4, aa64_sme2, do_mova_array_n, a, 4, false, false)
+TRANS_FEAT(MOVA_za2, aa64_sme2, do_mova_array_n, a, 2, true, false)
+TRANS_FEAT(MOVA_za4, aa64_sme2, do_mova_array_n, a, 4, true, false)
+
+TRANS_FEAT(MOVAZ_za2, aa64_sme2p1, do_mova_array_n, a, 2, true, true)
+TRANS_FEAT(MOVAZ_za4, aa64_sme2p1, do_mova_array_n, a, 4, true, true)
 
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0a2ceea8be..f7e4143b7d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -100,6 +100,42 @@ MOVA_za2        11000000 00 00011 00 .. 010 00 off:3 zr:4 0  \
 MOVA_za4        11000000 00 00011 00 .. 011 00 off:3 zr:3 00 \
                 &mova_a rv=%mova_rv
 
+### SME Move and Zero
+
+MOVAZ_za2       11000000 00000110 0 .. 01010 off:3 zr:4 0    \
+                &mova_a rv=%mova_rv
+MOVAZ_za4       11000000 00000110 0 .. 01110 off:3 zr:3 00   \
+                &mova_a rv=%mova_rv
+
+MOVAZ_zt        11000000 00 00001 0 v:1 .. 0001 off:4 zr:5    \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVAZ_zt        11000000 01 00001 0 v:1 .. 0001 za:1 off:3 zr:5    \
+                &mova_t rs=%mova_rs esz=1
+MOVAZ_zt        11000000 10 00001 0 v:1 .. 0001 za:2 off:2 zr:5    \
+                &mova_t rs=%mova_rs esz=2
+MOVAZ_zt        11000000 11 00001 0 v:1 .. 0001 za:3 off:1 zr:5    \
+                &mova_t rs=%mova_rs esz=3
+MOVAZ_zt        11000000 11 00001 1 v:1 .. 0001 za:4 zr:5    \
+                &mova_t rs=%mova_rs esz=4 off=0
+
+MOVAZ_zt2       11000000 00 00011 0 v:1 .. 00010 off:3 zr:4 0 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVAZ_zt2       11000000 01 00011 0 v:1 .. 00010 za:1 off:2 zr:4 0 \
+                &mova_t rs=%mova_rs esz=1
+MOVAZ_zt2       11000000 10 00011 0 v:1 .. 00010 za:2 off:1 zr:4 0 \
+                &mova_t rs=%mova_rs esz=2
+MOVAZ_zt2       11000000 11 00011 0 v:1 .. 00010 za:3 zr:4 0 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
+MOVAZ_zt4       11000000 00 00011 0 v:1 .. 001100 off:2 zr:3 00 \
+                &mova_t rs=%mova_rs esz=0 za=0
+MOVAZ_zt4       11000000 01 00011 0 v:1 .. 001100 za:1 off:1 zr:3 00 \
+                &mova_t rs=%mova_rs esz=1
+MOVAZ_zt4       11000000 10 00011 0 v:1 .. 001100 za:2 zr:3 00 \
+                &mova_t rs=%mova_rs esz=2 off=0
+MOVAZ_zt4       11000000 11 00011 0 v:1 .. 00110 za:3 zr:3 00 \
+                &mova_t rs=%mova_rs esz=3 off=0
+
 ### SME Move into/from ZT0
 
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
-- 
2.43.0


