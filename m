Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C1AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjH3-0001ss-45; Fri, 04 Jul 2025 12:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFU-0004yM-MY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:52 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFR-0006x9-HM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so735794f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646408; x=1752251208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fdOoCdlOlne44OqBtSkb8B1KzT+H2bYTeiNCpuOhZHw=;
 b=PlqibCFY1A2pxS4V1Z7rzGAPCPq9ZE5n9li02Prn0BmmubpruARarD8KmcpBKzhm4l
 DM9CR0y4nXRt/23Agb4QE1W8TBYXci1o4k7RmAZ+VFrbQ+QGclDocMA8UKqodzDFz3fX
 QGMImJ/pcWXDzrhYffjaMRGab+voi1aCKBdgBa0k0tNRVfxNUk5XWPvTK3OQcOv0Dp2D
 uLqvYw5A4EaBHNPsBdkhm3OarUy+tOEXcJWWAyeNAbZ9r3i4anu5MOxS5BjC7uVJF6Ag
 xU6aFIFE/YE435gcGU3pkx6RZSnA44VAENBZReJHJQCtzgNi/46hqeFIPnNYgn7W4J1k
 na5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646408; x=1752251208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdOoCdlOlne44OqBtSkb8B1KzT+H2bYTeiNCpuOhZHw=;
 b=KPwNpVtWtv3EXZjox8hdYZcjKrL/De4XAI6wR80802CWVQifdGLZh/w5c9iOPNsAqL
 9/9XCr52xZL0SoNJopJAtFfDphmkIzRpw3S/V2PHNIax3xxU0YlvBeTtdOD+vjanqCFO
 tuUlWhNMsA21MiYkFmqPyc1PdlkQvQEsuCYU0defmFHb9VLGNDTSxYz09kVdNttcAd/6
 fcTy8zzCg/QNvJMPyUjildHjYiu4dseLrO2j6d4udA//CLDylDot2H8exA3r55ToGxea
 9+sc8iV+Yzq1X2WC2f365tLWPxu8jJh1GytWSltBODRgdLcY3OAt6IZ4RwtdqXnsI65o
 yv7g==
X-Gm-Message-State: AOJu0YxtCKP1meP60jR5YUy9jyILhRt1E+nxzQgh3oTdSh5sLyInvfY9
 rJknZg0XSWQJrcpLUV9RJUww24DKEbIFzD8NpSA3wqYpJPQDu4PJrIe141TfREaeQQQbru/3uHv
 JaJUr
X-Gm-Gg: ASbGnct9fqdGnc1nKG+Ht5WAJnbwJGYHKrJOZmdk8yi9XezAbknhI2d9BywUP/FopuW
 EAC5Hrbl790yIEOe8BrFc4eakaT9kPq2a070Cy4SKXBjKsU3mN7nILk0FWnWr7Sh9nJWCdn+1Q0
 yQJdaY8U0/UbdxAkCTlBnLAwnjME+yEpvfDJqTi3GiOGhV4kS8vWRXuV2UBerzTWh2vdV/r0yTl
 f2es+Hi0NtxPhdbN9j6zfZQW4wn1CiAF9dRiLUnAvbTdxlLUNmAqoUTeXFnvWmdyW9rOk1PhBwi
 ur2FpA0+f8/YJP3yqprcf5cFIPUSjmjNgX9Lob7H6flxeLkm3qEIDCxQJUBzItgDYodd
X-Google-Smtp-Source: AGHT+IHcgn8mUcjlQMhF2pVB20h4eEORYPOfFaavxRykjdD+SE6zL1vK+vJS5+ItLgH0OhxZsbCo9Q==
X-Received: by 2002:a05:6000:4a14:b0:3a4:f918:9db9 with SMTP id
 ffacd0b85a97d-3b4964def46mr2803733f8f.32.1751646407828; 
 Fri, 04 Jul 2025 09:26:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 111/119] target/arm: Implement MOVAZ for SME2p1
Date: Fri,  4 Jul 2025 17:24:51 +0100
Message-ID: <20250704162501.249138-112-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-100-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme.decode      | 36 ++++++++++++++++++++
 target/arm/tcg/sme_helper.c    | 60 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 46 +++++++++++++++++++-------
 4 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 467073ea258..c9961d6b7ff 100644
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0a2ceea8bee..f7e4143b7de 100644
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
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index df16bb2f9c4..424fc006be4 100644
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
index 74075971772..9592f6a9960 100644
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
-- 
2.43.0


